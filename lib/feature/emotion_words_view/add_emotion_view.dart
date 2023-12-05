import 'package:flutter/material.dart';

import 'package:emotion_diary/common/utils/colors.dart';
import 'package:emotion_diary/common/utils/theme_manager.dart';

class AddEmotionView extends StatefulWidget {
  const AddEmotionView({super.key});

  @override
  State<AddEmotionView> createState() => _AddEmotionViewState();
}

class _AddEmotionViewState extends State<AddEmotionView> {
  final _formKey = GlobalKey<FormState>();

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

      body: LayoutBuilder(
        builder: (context, BoxConstraints viewport) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewport.maxHeight
              ),
              child: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
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

                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "단어"
                                ),
                              ),

                              const SizedBox(height: 24,),

                              TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "의미"
                                ),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24,),

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
                              Text("어휘 추가하기")
                            ],
                          ),
                        ),
                      )
                    ]
                  ),
                ),
              ),
            ),
          );
        }
      )

    );
  }
}
