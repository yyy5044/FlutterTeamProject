import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_diary/common/model/emotion_model.dart';
import 'package:emotion_diary/common/utils/colors.dart';
import 'package:emotion_diary/common/utils/theme_manager.dart';
import 'package:emotion_diary/common/utils/weathers.dart';
import 'package:emotion_diary/common/widgets/black_button.dart';
import 'package:emotion_diary/common/widgets/icon_textbox_with_dotted_border.dart';
import 'package:emotion_diary/common/widgets/textform_with_border.dart';
import 'package:emotion_diary/feature/main_page/event.dart';
import 'package:emotion_diary/feature/main_page/events_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WritingDiaryView extends ConsumerStatefulWidget {
  WritingDiaryView({
    super.key,
    this.categoryIndex = 0,
    this.emotionIndex = 0,
  });

  int categoryIndex;
  int emotionIndex;

  @override
  ConsumerState<WritingDiaryView> createState() => _WritingDiaryViewState();
}

class _WritingDiaryViewState extends ConsumerState<WritingDiaryView> {
  // List<String> sampleEmotionList = [
  //   'sample1',
  //   'sample2',
  //   'sample3',
  //   'sample4',
  //   'sample5',
  //   'sample6',
  //   'sample7',
  // ];

  List<EmotionModel> emotions = EmotionCategoryList.categories
      .expand((e) => e.words as List<EmotionModel>)
      .toList();

  TextEditingController _diaryFieldController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  int _selectedEmoji = 0;
  int _selectedWeather = 0;
  int _selectedEmotion = 0;
  XFile? _pickedFile;
  String diary = "";
  bool isUploading = false;

  late Map<DateTime, List<Event>> events;
  late EventsNotifier eventsProvider;

  EmotionCategoryModel? category;

  @override
  void initState() {
    super.initState();

    setState(() {
      _selectedEmoji = widget.categoryIndex;
      _selectedEmotion = widget.emotionIndex;

      category = EmotionCategoryList.categories[_selectedEmoji];
      emotions = category!.words!;
    });

    print(_selectedEmoji);
    print(_selectedEmotion);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    events = ref.watch(eventsNotifierProvider);
    eventsProvider = ref.read(eventsNotifierProvider.notifier);
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
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black,
      ),
      body: Stack(
        children: [
          SafeArea(
            minimum: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: GestureDetector(
                                      child: Row(
                                        children: [
                                          Text(
                                            emotions[_selectedEmotion].word,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                          const Icon(Icons.expand_more),
                                        ],
                                      ),
                                      onTapUp: (details) {
                                        setState(() {
                                          showEmotionSelectingBottomSheet(
                                              context);
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
                          padding:
                              const EdgeInsets.only(bottom: 20.0, top: 16.0),
                          child: Visibility(
                            visible: _pickedFile != null,
                            replacement: GestureDetector(
                                onTapUp: (details) {
                                  _getPhotoLibraryImage();
                                },
                                child: const IconTextboxWithDottedBorder(
                                  icon: Icons.add_box_outlined,
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
                    onPressed: () async {
                      setState(
                        () {
                          isUploading = true;
                        },
                      );

                      await _saveDiary();

                      setState(() {
                        isUploading = false;
                      });
                    },
                    label: '일기 작성하기',
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isUploading,
            child: Container(
              color: Colors.black45.withAlpha(100),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 16.0,
                    ),
                    child: Center(
                        child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('emotion/')
                          .where('userId',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          // .where('category', isEqualTo: category!.category!.korean!)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        List docs = snapshot.data!.docs;

                        if (category != null) {
                          emotions = category!.words!;
                        }

                        for (var doc in docs) {
                          final emotion = EmotionModel(
                              word: doc['word'], definition: doc['definition']);
                          if (category == null) {
                            emotions.add(emotion);
                          } else if (doc['category'] ==
                              category!.category!.korean) {
                            emotions.add(emotion);
                          }
                        }
                        emotions.removeWhere((a) =>
                            a != emotions.firstWhere((b) => a.word == b.word));

                        return GridView.builder(
                          padding: const EdgeInsets.all(12),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 402 / 68,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: emotions.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 0.1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 0))
                              ]),
                              child: ElevatedButton(
                                onPressed: () {
                                  bottomState(() {
                                    setState(() {
                                      _selectedEmotion = index;
                                      print("INDEX : $index");

                                      Navigator.pop(context);
                                    });
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: EmotionDiaryColors.white0,
                                    foregroundColor: EmotionDiaryColors.black0,
                                    textStyle: ThemeManager
                                        .themeData.textTheme.headlineSmall,
                                    elevation: 0),
                                child: Row(
                                  children: [
                                    Text(
                                      emotions[index].word,
                                      style: ThemeManager
                                          .themeData.textTheme.headlineSmall,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Flexible(
                                      child: Text(
                                        emotions[index].definition,
                                        overflow: TextOverflow.ellipsis,
                                        style: ThemeManager
                                            .themeData.textTheme.bodyMedium,
                                        maxLines: 1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )),
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
                                print("INDEX : $index");
                                category = EmotionCategoryList
                                    .categories[_selectedEmoji];
                                emotions = category!.words!;
                                Navigator.pop(context);
                              });
                            });
                          },
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 500),
                            child: Image(
                              image: AssetImage(EmotionCategoryList
                                  .categories[index].category!
                                  .imagePath()),
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

  // 사용자에게 띄울 메세지 함수
  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('알림'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('확인'),
            onPressed: () {
              Navigator.of(ctx).pop(); // 다이얼로그 닫기
              // Route route = MaterialPageRoute(builder: (context) => MainPage());
              Navigator.of(ctx).pushReplacementNamed(
                '/mainpage',
                arguments: _selectedDate,
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _saveDiary() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      _showDialog('로그인을 하셔야 합니다.');
      return;
    }

    // 사용자가 입력한 일기 내용을 diary 변수에 저장
    diary = _diaryFieldController.text;

    String? imageUrl; // 이미지 url 변수
    try {
      // Firebase Storage에 이미지 업로드 후 URL 가져오는 코드
      // 이미지 파일 이름이 겹치지 않게 DateTime.now를 사용했음. 문제 있으면 알려주세요~
      if (_pickedFile != null) {
        final file = File(_pickedFile!.path);
        final ref = FirebaseStorage.instance
            .ref()
            .child('diaryImages')
            .child('${DateTime.now().toIso8601String()}_${_pickedFile!.name}');

        await ref.putFile(file); // 파일 업로드
        imageUrl = await ref.getDownloadURL(); // 업로드된 파일의 URL 가져오기
      }

      final diaryData = {
        'userId': currentUser.uid,
        'date': _selectedDate,
        'emojiIndex': _selectedEmoji,
        'weatherIndex': _selectedWeather,
        'emotions': emotions[_selectedEmotion].word,
        'diaryText': diary, // 여기에 사용자가 입력한 일기 내용을 포함
        'image': imageUrl, // 업로드된 이미지 URL
      };

      await FirebaseFirestore.instance.collection('diaries').add(diaryData);
      _showDialog('작성되었습니다.');
    } catch (error) {
      _showDialog('죄송합니다. 다시 시도해주세요.');
    }
  }
}
