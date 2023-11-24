import 'dart:io';

import 'package:emotion_diary/common/utils/colors.dart';
import 'package:emotion_diary/common/utils/emojis.dart';
import 'package:emotion_diary/common/utils/weathers.dart';
import 'package:emotion_diary/common/widgets/black_button.dart';
import 'package:emotion_diary/common/widgets/emotion_list_button.dart';
import 'package:emotion_diary/common/widgets/icon_textbox_with_dotted_border.dart';
import 'package:emotion_diary/common/widgets/textform_with_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WritingDiaryView extends StatefulWidget {
  const WritingDiaryView({super.key});

  @override
  State<WritingDiaryView> createState() => _WritingDiaryViewState();
}

class _WritingDiaryViewState extends State<WritingDiaryView> {
  List<String> sampleEmotionList = [
    'sample1',
    'sample2',
    'sample3',
    'sample4',
    'sample5',
    'sample6',
    'sample7',
  ];

  TextEditingController _diaryFieldController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  int _selectedEmoji = 0;
  int _selectedWeather = 0;
  int _selectedEmotion = 0;
  XFile? _pickedFile;
  String diary = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool showSaveButton = MediaQuery.of(context).viewInsets.bottom == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '일기 작성',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        leading: IconButton(
          icon: const Icon(Icons.list),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTapUp: (details) {
                              showDateSelectingBottomSheet(context);
                            },
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_selectedDate.year}년',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${_selectedDate.month}월 ${_selectedDate.day}일",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Icon(Icons.expand_more),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: IconButton(
                                onPressed: () {
                                  showEmojiSelectingBottomSheet(context);
                                },
                                icon: Icon(
                                  Icons.add_reaction,
                                  color: EmotionDiaryColors.grey0,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: IconButton(
                                onPressed: () {
                                  showWeatherSelectingBottomSheet(context);
                                },
                                icon: Icon(Icons.thermostat,
                                    color: EmotionDiaryColors.grey0)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Row(
                          children: [
                            Text(
                              "오늘 나의 감정은",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: GestureDetector(
                                  child: Row(
                                    children: [
                                      Text(
                                        sampleEmotionList[_selectedEmotion],
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      const Icon(Icons.expand_more),
                                    ],
                                  ),
                                  onTapUp: (details) {
                                    setState(() {
                                      showEmotionSelectingBottomSheet(context);
                                    });
                                  },
                                )),
                            Text(
                              "이야",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: showSaveButton,
              replacement: Expanded(
                child: Container(),
              ),
              child: Expanded(
                child: Container(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 16.0),
                      child: Visibility(
                        visible: _pickedFile != null,
                        replacement: GestureDetector(
                            onTapUp: (details) {
                              _getPhotoLibraryImage();
                            },
                            child: const IconTextboxWithDottedBorder(
                              icon: Icons.add_photo_alternate_outlined,
                              label: "사진 추가하기",
                            )),
                        child: Image(
                          image: FileImage(File(_pickedFile?.path ?? "")),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              ),
            ),
            TextFormWithBorder(
              controller: _diaryFieldController,
            ),
            Visibility(
              visible: showSaveButton,
              child: const SizedBox(height: 20),
            ),
            Visibility(
              visible: showSaveButton,
              child: BlackButton(
                onPressed: () {
                  _saveDiary();
                },
                label: '일기 작성하기',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showEmotionSelectingBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter bottomState) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: EmotionDiaryColors.white0,
            ),
            height: 450,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 16.0,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                        sampleEmotionList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: EmotionListButton(
                            onPressed: () {
                              bottomState(() {
                                setState(() {
                                  _selectedEmotion = index;
                                });
                              });
                            },
                            label: sampleEmotionList[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Future<dynamic> showDateSelectingBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
            height: 500,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
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
  }

  Future<dynamic> showEmojiSelectingBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter bottomState) {
            return SizedBox(
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    children: List<Widget>.generate(
                      5,
                      (index) => Padding(
                        key: UniqueKey(),
                        padding: const EdgeInsets.all(6.0),
                        child: GestureDetector(
                          onTap: () {
                            bottomState(() {
                              setState(() {
                                _selectedEmoji = index;
                              });
                            });
                          },
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 500),
                            child: Image(
                              image: AssetImage(Emojis.emojiList[index]),
                              width: 60 * (index == _selectedEmoji ? 1.5 : 1.0),
                              height:
                                  60 * (index == _selectedEmoji ? 1.5 : 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  Future<dynamic> showWeatherSelectingBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter bottomState) {
            return SizedBox(
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    children: List<Widget>.generate(
                      5,
                      (index) => Padding(
                        key: UniqueKey(),
                        padding: const EdgeInsets.all(6.0),
                        child: GestureDetector(
                          onTap: () {
                            bottomState(() {
                              setState(() {
                                _selectedWeather = index;
                              });
                            });
                          },
                          child: SizedBox(
                            width: 60,
                            height: 60,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index == _selectedWeather
                                        ? Weathers.weatherColorList[index]
                                        : Colors.transparent,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image(
                                    image:
                                        AssetImage(Weathers.weatherList[index]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  void _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    } else {
      debugPrint('이미지 선택안함');
    }
  }

  // TODO: 데이터 저장 구현하기
  void _saveDiary() {
    // DateTime _selectedDate   -> 날짜 DateTime
    // int _selectedEmoji       -> 이모지 index
    // int _selectedWeather     -> 날짜 index
    // String _selectedEmotions -> 감정 String
    // XFile? _pickedFile       -> 사진 XFile
    // String diary             -> 일기 String
  }
}
