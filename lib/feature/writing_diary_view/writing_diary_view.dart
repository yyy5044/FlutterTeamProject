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
  final _emotions = ['기쁨', '슬픔', '놀람', '화남', '웃김'];
  String? _selectedEmotions;

  @override
  void initState() {
    super.initState();
    _selectedEmotions = '기쁨';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일기 작성'),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Row(
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
                                        height: 200,
                                        color: Colors.amber,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Text('Modal BottomSheet'),
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
                                child: Container(
                                  child: const Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("2023년"),
                                          Row(
                                            children: [
                                              Text("11월 13일"),
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
                          Row(
                            children: [
                              Text("오늘 나의 감정은"),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: DropdownButton(
                                  value: _selectedEmotions,
                                  // style: TextStyle(color: Colors.black),
                                  items: _emotions
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  onChanged: (String? emotion) {
                                    setState(() {
                                      _selectedEmotions = emotion;
                                    });
                                  },
                                ),
                              ),
                              Text("이야"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_reaction,
                          color: EmotionDiaryColors.grey0,
                        )),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.thermostat,
                          color: EmotionDiaryColors.grey0)),
                ],
              ),
            ),
            const Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Image(
                    image: NetworkImage(
                  'https://cdn.imweb.me/upload/S20210807d1f68b7a970c2/7170113c6a983.jpg',
                )),
              ),
            ),
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
