import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_diary/feature/main_page/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final eventsNotifierProvider =
    StateNotifierProvider<EventsNotifier, Map<DateTime, List<Event>>>(
  (ref) => EventsNotifier(),
);

class EventsNotifier extends StateNotifier<Map<DateTime, List<Event>>> {
  EventsNotifier() : super({});

  // Firestore에서 데이터를 가져오는 함수
  Future<void> loadEventsFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 현재 로그인된 유저의 ID를 확인
    String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

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
      String emotion = data['emotions'];
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

    debugPrint('Loaded events: $newEvents');
  }

  void clear() {
    // state = {};
    state.clear();
  }

  Future<bool> uploadEventToFirestore(
      {required pickedFile,
      required imageUrl,
      required selectedDate,
      required selectedEmoji,
      required selectedWeather,
      required selectedEmotion,
      required diary}) async {
    try {
      // Firebase Storage에 이미지 업로드 후 URL 가져오는 코드
      // 이미지 파일 이름이 겹치지 않게 DateTime.now를 사용했음. 문제 있으면 알려주세요~
      final currentUserUid = FirebaseAuth.instance.currentUser?.uid ?? '';

      if (pickedFile != null) {
        final file = File(pickedFile!.path);
        final ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('diaryImages')
            .child('${DateTime.now().toIso8601String()}_${pickedFile!.name}');

        await ref.putFile(file); // 파일 업로드
        imageUrl = await ref.getDownloadURL(); // 업로드된 파일의 URL 가져오기
      }

      final diaryData = {
        'userId': currentUserUid,
        'date': selectedDate,
        'emojiIndex': selectedEmoji,
        'weatherIndex': selectedWeather,
        'emotions': selectedEmotion,
        'diaryText': diary, // 여기에 사용자가 입력한 일기 내용을 포함
        'image': imageUrl, // 업로드된 이미지 URL
      };

      await FirebaseFirestore.instance.collection('diaries').add(diaryData);
      return Future(() => true);
    } catch (error) {
      return Future(() => false);
    }
  }
}
