import 'package:emotion_diary/common/widgets/icon_textbox_with_dotted_border.dart';
import 'package:emotion_diary/common/widgets/black_button.dart';
import 'package:emotion_diary/feature/main_page/event.dart';
import 'package:emotion_diary/feature/main_page/events_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../writing_diary_view/writing_diary_view.dart';
import '../authentication/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:emotion_diary/common/utils/emojis.dart';
import 'package:emotion_diary/common/utils/weathers.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:emotion_diary/feature/emotion_words_view/emotion_categories_view.dart';

class MainPage extends ConsumerStatefulWidget {
  MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  User? currentUser; // 로그인 상태 변수
  bool isInitiated = false;
  DateTime? today = DateTime.now();

  late Map<DateTime, List<Event>> events;
  late final eventsProvider;
  late final ValueNotifier<List<Event>> _selectedEvents =
      ValueNotifier(_getEvents(today!));

  @override
  void initState() {
    // today = widget.targetDateTime != null ? widget.targetDateTime! : today;
    // print(widget.targetDateTime);
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser; // 현재 로그인 상태 확인
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    today = ModalRoute.of(context)?.settings.arguments as DateTime? ??
        DateTime.now();
    if (!isInitiated) {
      events = ref.watch(eventsNotifierProvider);
      eventsProvider = ref.read(eventsNotifierProvider.notifier);
      isInitiated = true;
    }
    _selectedEvents.value = _getEvents(today!);
    // 로그인 시 데이터 불러오기 기능 동작
    loadEventsFromFirestore();
  }

  // Firestore에서 데이터를 가져오는 함수
  Future<void> loadEventsFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 현재 로그인된 유저의 ID를 확인
    String currentUserId = currentUser?.uid ?? '';

    // 현재 유저의 ID와 일치하는 일기만 쿼리
    QuerySnapshot querySnapshot = await firestore
        .collection('diaries')
        .where('userId', isEqualTo: currentUserId)
        .get();

    Map<DateTime, List<Event>> newEvents = {};

    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      DateTime date = (data['date'] as Timestamp).toDate();
      String diaryText = data['diaryText'];
      String? imagePath = data['image'];
      int emoji = data['emojiIndex'];
      int emotion = data['emotions'];
      int weather = data['weatherIndex'];

      // 받아온 일기 데이터들로 일기 객체 생성
      Event event = Event(
        diaryText: diaryText,
        imagePath: imagePath,
        emoji: emoji,
        emotion: emotion,
        weather: weather,
      );

      DateTime dateWithoutTime = DateTime(date.year, date.month, date.day);

      if (newEvents[dateWithoutTime] != null) {
        newEvents[dateWithoutTime]!.add(event);
      } else {
        newEvents[dateWithoutTime] = [event];
      }
    }

    print('Loaded events: $newEvents');

    setState(() {
      events = newEvents;
      _selectedEvents.value = _getEvents(today!); // 선택된 날짜에 맞는 이벤트 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '일기 작성',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          IconButton(
              onPressed: () {
                loadEventsFromFirestore();
              },
              icon: Icon(Icons.refresh)),
          if (currentUser != null) // 로그인 상태일 경우
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut(); // 로그아웃
                // 로그아웃 시 데이터 초기화하도록 기능 동작
                setState(() {
                  events.clear();
                  currentUser = null;
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
              child: Text(
                '메뉴',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.emoji_emotions),
              title: const Text('감정 어휘'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmotionCategoryView()),
                );
              },
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Column(
            children: [
              TableCalendar(
                locale: 'ko_KR',
                focusedDay: today!,
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
                  markerBuilder: (context, day, List<Event> events) {
                    //이모티콘 추가
                    if (events.isNotEmpty) {
                      // return ListView.builder(  이모티콘 여러개 보여줄 때
                      //   shrinkWrap: true,
                      //   scrollDirection: Axis.horizontal,
                      //   itemCount: events.length,
                      //   itemBuilder: (context, index) {
                      //     return Container(
                      //       margin: EdgeInsets.only(top: 30),
                      //       child: Image(
                      //         image: AssetImage(
                      //             Emojis.emojiList[events[index].emoji]),
                      //         width: 30,
                      //         height: 30,
                      //       ),
                      //     );
                      //
                      //   },
                      // );
                      return ListView(
                          // 이모티콘 한개만 보여줄 때
                          shrinkWrap: true,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Image(
                                image: AssetImage(
                                    Emojis.emojiList[events[0].emoji]),
                                width: 25,
                                height: 25,
                              ),
                            )
                          ]);
                    }
                  },
                ),
                onDaySelected: _onDaySelected,
                selectedDayPredicate: (day) => isSameDay(day, today!),
                eventLoader: _getEvents,
                calendarStyle: const CalendarStyle(
                  markerDecoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    if (value.isNotEmpty) {
                      // 일기 내용이 있다면
                      return Column(
                          children:
                              List<Widget>.generate(value.length, (index) {
                        Event event = value[index];
                        return Card(
                          // Material 디자인의 카드 스타일을 적용
                          child: Column(
                            children: <Widget>[
                              event.imagePath != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Image.network(event.imagePath!,
                                          width: double.infinity),
                                    ) // 이미지를 상단에 표시
                                  : Container(height: 0), // 이미지가 없을 경우 빈 컨테이너
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // TODO: 일단은 텍스트로 표시해뒀는데 각 함수를 구현하고 비활성화라고 적힌 부분을 풀면 됨.

                                    // 이모티콘을 표시
                                    // Icon(getEmoji(event.emoji)), // 일단 비활성화
                                    // Text('Emoji: ${event.emoji}'), // 일단은 텍스트로
                                    Image(
                                      image: AssetImage(
                                          Emojis.emojiList[event.emoji]),
                                      width: 30,
                                      height: 30,
                                    ),
                                    SizedBox(width: 10), // 아이콘 간 간격
                                    // 감정 어휘 표시
                                    // Text('Emotion: ${getEmotion(event.emotion)}'), // 일단 비활성화
                                    Text(
                                        'Emotion: ${event.emotion}'), // 일단은 텍스트로
                                    SizedBox(width: 10),
                                    // 날씨 정보를 표시
                                    // Icon(getWeather(event.weather)), // 일단 비활성화
                                    //Text('Weather: ${event.weather}'), // 일단은 텍스트로
                                    Image(
                                      image: AssetImage(
                                          Weathers.weatherList[event.weather]),
                                      width: 30,
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  // 내용이 길 경우 스크롤 가능
                                  child: Text(event.diaryText),
                                ),
                              ),
                            ],
                          ),
                        );
                      }));
                    } else {
                      // 일기 쓴 내역이 없다면
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WritingDiaryView()),
                          );
                        },
                        child: const IconTextboxWithDottedBorder(
                          icon: Icons.add_photo_alternate_outlined,
                          label: "아직 일기를 작성하지 않았어요.",
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      _selectedEvents.value = _getEvents(today!);
    });
  }

  List<Event> _getEvents(DateTime today) {
    DateTime dateWithoutTime = DateTime(today.year, today.month, today.day);
    return events[dateWithoutTime] ?? [];
  }
}
