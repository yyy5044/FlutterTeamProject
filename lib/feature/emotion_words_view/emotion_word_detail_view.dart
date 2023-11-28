import 'package:flutter/material.dart';

import 'package:emotion_diary/common/model/emotion_model.dart';
import 'package:emotion_diary/common/utils/colors.dart';
import 'package:emotion_diary/common/utils/theme_manager.dart';

class EmotionWordDetailView extends StatelessWidget {
  const EmotionWordDetailView({super.key, required this.emotion});

  final EmotionModel emotion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EmotionDiaryColors.white0,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black,

        title: Text(
          '감정 어휘',
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

            },
            icon: const Icon(Icons.edit,),
          )
        ],
      ),

      body: SafeArea(
        minimum: const EdgeInsets.all(24),

        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: EmotionDiaryColors.white0,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0.1,
                      blurRadius: 5,
                      offset: const Offset(0, 0)
                  )
                ]
              ),

              child: Row(
                children: [
                  FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          emotion.word,
                          style: ThemeManager.themeData.textTheme.headlineSmall,
                        ),

                        const SizedBox(height: 24,),

                        Text(
                          emotion.definition,
                          style: ThemeManager.themeData.textTheme.bodyMedium,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            const Expanded(child: SizedBox()),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: EmotionDiaryColors.black0,
                  foregroundColor: EmotionDiaryColors.white0,
                  textStyle: ThemeManager.themeData.textTheme.titleSmall,
                  elevation: 0
              ),
              onPressed: (){},

              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("일기 작성하기")
                  ],
                ),
              ),
            )
          ]
        )
        // child: Expanded(
        //   flex: 1,
        //   child: Container(
        //     padding: const EdgeInsets.all(22),
        //     decoration: BoxDecoration(
        //       color: EmotionDiaryColors.white0,
        //       borderRadius: BorderRadius.circular(10),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.black.withOpacity(0.1),
        //           spreadRadius: 0.1,
        //           blurRadius: 5,
        //           offset: const Offset(0, 0)
        //         )
        //       ]
        //     ),
        //
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //
        //       children: [
        //         Text(
        //           emotion.word,
        //           style: ThemeManager.themeData.textTheme.headlineSmall,
        //         ),
        //
        //         const SizedBox(height: 24,),
        //
        //         Text(
        //           emotion.definition,
        //           style: ThemeManager.themeData.textTheme.bodyMedium,
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      )
    );
  }
}
