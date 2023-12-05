import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_diary/feature/emotion_words_view/add_emotion_view.dart';
import 'package:emotion_diary/feature/emotion_words_view/emotion_word_detail_view.dart';
import 'package:flutter/material.dart';

import 'package:emotion_diary/common/utils/colors.dart';
import 'package:emotion_diary/common/utils/theme_manager.dart';

import 'package:emotion_diary/common/model/emotion_model.dart';

class EmotionWordsView extends StatefulWidget {
  EmotionWordsView({super.key, required this.category});

  EmotionCategoryModel category;

  @override
  State<EmotionWordsView> createState() => _EmotionWordsViewState();
}

class _EmotionWordsViewState extends State<EmotionWordsView> {
  late List<EmotionModel> emotionList = widget.category.words!;

  @override
  void initState() {
    super.initState();
    loadEmotionWords(widget.category.category!.korean!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EmotionDiaryColors.white0,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black,

        title: Text(
          widget.category!.category!.korean,
          style: Theme.of(context).textTheme.titleSmall,
        ),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEmotionView(category: widget.category,))
              );
            },
            icon: const Icon(Icons.add,),
          )
        ],
      ),

      body: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 402 / 68,
            mainAxisSpacing: 12,
          ),
          itemCount: emotionList.length,
          itemBuilder: (context, index) {
            return EmotionListTile(emotion: emotionList[index]);
          },
        ),
      )
    );
  }
}

extension on _EmotionWordsViewState {

  Future<void> loadEmotionWords(String category) async {
    List<EmotionModel> emotions = [];

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(category)
        .get();

    for (var doc in snapshot.docs) {
      var emotion = doc.data() as EmotionModel;
      emotions.add(emotion);
    }

    setState(() {
      emotionList += emotions;
    });
  }
}

class EmotionListTile extends StatelessWidget {
  const EmotionListTile({super.key, required this.emotion});

  final EmotionModel emotion;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.1,
              blurRadius: 5,
              offset: const Offset(0, 0)
          )
        ]
      ),
      child: ElevatedButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmotionWordDetailView(emotion: emotion))
          );
        },

        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: EmotionDiaryColors.white0,
          foregroundColor: EmotionDiaryColors.black0,
          textStyle: ThemeManager.themeData.textTheme.headlineSmall,
          elevation: 0
        ),

        child: Row(
          children: [
            Text(
              emotion.word,
              style: ThemeManager.themeData.textTheme.headlineSmall,
            ),

            const SizedBox(width: 16,),

            Flexible(
              child: Text(
                emotion.definition,
                overflow: TextOverflow.ellipsis,
                style: ThemeManager.themeData.textTheme.bodyMedium,
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
