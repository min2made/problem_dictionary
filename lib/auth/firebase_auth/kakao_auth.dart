import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:problem_dictionary/flutter_flow/flutter_flow_util.dart';

class KakaoAuthManager {
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
        await userDoc.set({
          'username': 'DefaultUsername',  // 기본 username 값 설정
          'createdAt': FieldValue.serverTimestamp(),
        });
        print("첫 로그인: 사용자 문서 생성 완료");

        // 첫 로그인 시 ListPage로 이동
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
