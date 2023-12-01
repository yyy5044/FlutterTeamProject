import 'package:emotion_diary/feature/emotion_words_view/emotion_word_view.dart';
import 'package:flutter/material.dart';

import 'package:emotion_diary/common/utils/colors.dart';
import 'package:emotion_diary/common/utils/theme_manager.dart';

import 'package:emotion_diary/common/model/emotion_model.dart';

class EmotionCategoryView extends StatelessWidget {
  const EmotionCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EmotionDiaryColors.white0,

      appBar: AppBar(
        title: Text(
          "감정 어휘",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black,
      ),

      body: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: EmotionCategory.values.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 188 / 116,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24
          ),
          itemBuilder: (context, index) {
            return EmotionCategoryTile(
                emotion: EmotionCategoryList.categories[index],
            );
          }
        ),
      ),
    );
  }
}



class EmotionCategoryTile extends StatelessWidget {
  const EmotionCategoryTile({super.key, required this.emotion});

  final EmotionCategoryModel emotion;

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
            MaterialPageRoute(builder: (context) => EmotionWordsView(category: emotion,))
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(emotion.category!.imagePath()),
              width: 44,
              height: 44,
            ),

            const SizedBox(height: 8,),

            Text(
              emotion.category!.korean,
              style: ThemeManager.themeData.textTheme.headlineSmall,
            )
          ],
        ),
      ),
    );
    // return Container(
    //   decoration: BoxDecoration(
    //     boxShadow: [
    //       BoxShadow(
    //           color: Colors.black.withOpacity(0.1),
    //           spreadRadius: 0.1,
    //           blurRadius: 5,
    //           offset: const Offset(0, 0)
    //       )
    //     ]
    //   ),
    //   child: ElevatedButton(
    //       onPressed: (){
    //
    //       },
    //       style: ElevatedButton.styleFrom(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         backgroundColor: EmotionDiaryColors.white0,
    //         foregroundColor: EmotionDiaryColors.black0,
    //         textStyle: ThemeManager.themeData.textTheme.headlineSmall
    //       ),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Image(
    //             image: AssetImage(emotion.category!.imagePath()),
    //             width: 44,
    //             height: 44,
    //           ),
    //
    //           const SizedBox(height: 8,),
    //
    //           Text(
    //             emotion.category!.korean,
    //             style: ThemeManager.themeData.textTheme.headlineSmall,
    //           )
    //         ],
    //       )
    //   ),
    // );
  }
}
