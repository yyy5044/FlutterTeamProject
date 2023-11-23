import 'package:emotion_diary/common/utils/colors.dart';
import 'package:emotion_diary/common/widgets/black_button.dart';
import 'package:emotion_diary/common/widgets/textbox_with_border.dart';
import 'package:flutter/material.dart';

class WritingDiaryView extends StatefulWidget {
  const WritingDiaryView({super.key});

  @override
  State<WritingDiaryView> createState() => _WritingDiaryViewState();
}

class _WritingDiaryViewState extends State<WritingDiaryView> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedEmotions;
  final String _imageUrl =
      'https://cdn.imweb.me/upload/S20210807d1f68b7a970c2/7170113c6a983.jpg';

  @override
  void initState() {
    super.initState();
    _selectedEmotions = '기쁨';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '일기 작성',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTapUp: (details) {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                        height: 500,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16.0),
                                          child: CalendarDatePicker(
                                              initialDate: _selectedDate,
                                              firstDate: DateTime(2023, 1, 1),
                                              lastDate: DateTime.now(),
                                              onDateChanged: (newDate) {
                                                setState(() {
                                                  _selectedDate = newDate;
                                                });
                                              }),
                                        ));
                                  },
                                );
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${_selectedDate.year}년'),
                                        Row(
                                          children: [
                                            Text(
                                                "${_selectedDate.month}월 ${_selectedDate.day}일"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.expand_more),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Row(
                            children: [
                              Text("오늘 나의 감정은"),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: GestureDetector(
                                    child: Row(
                                      children: [
                                        Text(_selectedEmotions!),
                                        Icon(Icons.expand_more),
                                      ],
                                    ),
                                    onTapUp: (details) {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: 200,
                                            color: Colors.amber,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  const Text(
                                                      'Modal BottomSheet'),
                                                  ElevatedButton(
                                                    child: const Text('Done!'),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )),
                              Text("이야"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 200,
                              color: Colors.amber,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text('Modal BottomSheet'),
                                    ElevatedButton(
                                      child: const Text('Done!'),
                                      onPressed: () => Navigator.pop(context),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.add_reaction,
                        color: EmotionDiaryColors.grey0,
                      )),
                ),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 200,
                            color: Colors.amber,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text('Modal BottomSheet'),
                                  ElevatedButton(
                                    child: const Text('Done!'),
                                    onPressed: () => Navigator.pop(context),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.thermostat,
                        color: EmotionDiaryColors.grey0)),
              ],
            ),
            DiaryImage(imageUrl: _imageUrl),
            TextboxWithBorder(
              content:
                  "일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 일기내용 ",
            ),
            SizedBox(height: 20),
            BlackButton(
              onPressed: () {},
              label: 'test',
            ),
          ],
        ),
      ),
    );
  }
}

class DiaryImage extends StatelessWidget {
  const DiaryImage({
    super.key,
    required String imageUrl,
  }) : _imageUrl = imageUrl;

  final String _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, top: 16.0),
        child: Image(image: NetworkImage(_imageUrl)),
      ),
    );
  }
}
