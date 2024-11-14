import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:problem_dictionary/flutter_flow/flutter_flow_util.dart';

import '../../backend/schema/users_record.dart';
import 'auth_util.dart';

class KakaoAuthManager {
  DocumentReference? currentUserReference;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> handleKakaoLogin(BuildContext context) async {
    try {
      // 카카오 로그인 처리
      final User kakaoUser = await UserApi.instance.me();
      final String uid = kakaoUser.id.toString();

      // Firestore에서 해당 사용자가 첫 로그인인지 확인
      final DocumentReference userDoc = _firestore.collection('users').doc(uid);
      final DocumentSnapshot userSnapshot = await userDoc.get();

      if (!userSnapshot.exists) {
        // 첫 로그인 시 사용자 문서를 생성하고 페이지 이동
        // 사용자 문서를 생성
        final userRef = await _firestore.collection('users').doc(uid).set({
          'email': 'kakao',
          'uid': uid,
          // 필요한 필드 추가
        });

        // currentUserReference에 해당 문서의 참조 저장
        currentUserReference = _firestore.collection('users').doc(uid);

        // 첫 로그인 시 CreateProfile로 이동
        if (context.mounted) {
          context.pushNamedAuth('CreateProfile', context.mounted);
        }
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
