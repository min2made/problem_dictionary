import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:problem_dictionary/flutter_flow/flutter_flow_util.dart';

import '../../backend/schema/users_record.dart';
import 'auth_util.dart';

class KakaoAuthManager {
  DocumentReference? currentUserReference;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> handleKakaoLogin(BuildContext context) async {
    try {
      // 카카오 로그인 처리
      final kakao.User kakaoUser = await kakao.UserApi.instance.me();
      final String uid = kakaoUser.id.toString();
      final user = FirebaseAuth.instance.currentUser;
      final String? firebaseUID = user?.uid;

      // Firestore에서 해당 사용자가 첫 로그인인지 확인
      final DocumentReference userDoc = _firestore.collection('users').doc(uid);
      final DocumentSnapshot userSnapshot = await userDoc.get();

      if (!userSnapshot.exists) {
        // currentUserReference에 해당 문서의 참조 저장
        currentUserReference = _firestore.collection('users').doc(uid);

        // 첫 로그인 시 CreateProfile로 이동
        if (context.mounted) {
          context.pushNamedAuth('CreateProfile', context.mounted);
        }
        await userDoc.set({
          'displayName': '임시'
        });
      } else {
        // 이미 로그인한 사용자의 경우
        print("이미 한번이라도 로그인: 사용자 문서 존재");

        // ListPage로 이동
        if (context.mounted) {
          context.pushNamedAuth('ListPage', context.mounted);
        }
      }
    } catch (e) {
      print("카카오 로그인 중 오류 발생: $e");
    }
  }
}
