import 'package:emotion_diary/common/widgets/icon_textbox_with_dotted_border.dart';
import 'package:emotion_diary/common/widgets/black_button.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../writing_diary_view/writing_diary_view.dart';
import '../authentication/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  User? currentUser; // 로그인 상태 변수

  DateTime today = DateTime.now();
  Map<DateTime, List<Event>> events = {
    // DateTime(2023, 11, 1): [Event('Event 1'), Event("Event2")],
    // DateTime(2023, 11, 25): [Event('Event 2')],
  };
  late final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier(_getEvents(today));

  // Firestore에서 데이터를 가져오는 함수
  Future<void> loadEventsFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('diaries').get();

    Map<DateTime, List<Event>> newEvents = {};

    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      DateTime date = (data['date'] as Timestamp).toDate();
      String title = data['diaryText'];
      String? imagePath = data['image'];

      // Firestore의 날짜를 기준으로 Event 객체를 생성하고 events 맵에 추가
      DateTime dateWithoutTime = DateTime(date.year, date.month, date.day);
      var event = Event(title, imagePath: imagePath);

      if (newEvents[dateWithoutTime] != null) {
        newEvents[dateWithoutTime]!.add(event);
      } else {
        newEvents[dateWithoutTime] = [event];
      }
    }

    print('Loaded events: $newEvents');

    setState(() {
      events = newEvents;
      _selectedEvents.value = _getEvents(today); // 선택된 날짜에 맞는 이벤트 업데이트
    });
  }

  @override
  void initState() {
    super.initState();
    loadEventsFromFirestore(); // initState에서 Firestore에서 데이터 로드
    currentUser = FirebaseAuth.instance.currentUser; // 현재 로그인 상태 확인
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '일기 작성',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          IconButton(onPressed: (){loadEventsFromFirestore();}, icon: Icon(Icons.refresh)),
          if (currentUser != null) // 로그인 상태일 경우
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut(); // 로그아웃
                setState(() {
                  currentUser = null; // 상태 업데이트
                });
              },
            )
          else // 로그인 상태가 아닐 경우
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
        ],
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
              child: Text(
                '메뉴',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('일기 작성하기'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WritingDiaryView()),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: Column(
          children: [
            TableCalendar(
              locale: 'ko_KR',
              focusedDay: today,
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.now(),
              daysOfWeekHeight: 30,
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                ),
                headerPadding: EdgeInsets.symmetric(vertical: 4.0),
              ),
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  switch (day.weekday) {
                    case 1:
                      return const Center(
                        child: Text('월'),
                      );
                    case 2:
                      return const Center(
                        child: Text('화'),
                      );
                    case 3:
                      return const Center(
                        child: Text('수'),
                      );
                    case 4:
                      return const Center(
                        child: Text('목'),
                      );
                    case 5:
                      return const Center(
                        child: Text('금'),
                      );
                    case 6:
                      return const Center(
                        child: Text('토'),
                      );
                    case 7:
                      return const Center(
                        child: Text(
                          '일',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                  }
                },
                markerBuilder: (context, day, events) { //이모티콘 추가
                  if (events.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: 40),
                          child: Icon(
                            size: 20,
                            Icons.pets_outlined,
                          ),
                        );

                      },
                    );
                  }
                },
              ),
              onDaySelected: _onDaySelected,
              selectedDayPredicate: (day) => isSameDay(day, today),

              eventLoader: _getEvents,

              calendarStyle: const CalendarStyle(
                markerDecoration:  BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),

            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    if (value.isNotEmpty) { // 일기 내용이 있다면
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          Event event = value[index];
                          return Card( // Material 디자인의 카드 스타일을 적용
                            child: Column(
                              children: <Widget>[
                                event.imagePath != null
                                    ? Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Image.network(event.imagePath!, width: double.infinity),
                                    ) // 이미지를 상단에 표시
                                    : Container(height: 200, color: Colors.grey), // 이미지가 없을 경우 대체 요소
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView( // 내용이 길 경우 스크롤 가능
                                    child: Text(event.title),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else { // 일기 쓴 내역이 없다면
                      return GestureDetector(
                        onTap: () {
                          print('Tapped');
                        },
                        child: const IconTextboxWithDottedBorder(
                          icon: Icons.add_photo_alternate_outlined,
                          label: "아직 일기를 작성하지 않았어요.",
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      _selectedEvents.value = _getEvents(today);
    });
  }

  List<Event> _getEvents(DateTime today) {
    DateTime dateWithoutTime = DateTime(today.year, today.month, today.day);
    return events[dateWithoutTime] ?? [];
  }

}

// Event 클래스에 이미지 경로를 추가
class Event {
  Event(this.title, {this.imagePath});
  final String title;
  final String? imagePath;

  @override
  String toString() {
    return title;
  }
}