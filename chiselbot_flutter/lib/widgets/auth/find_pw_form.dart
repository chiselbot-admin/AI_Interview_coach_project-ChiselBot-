import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../models/auth/find_auth_data.dart';
import '../../providers/find_auth_notifier.dart';

class FindPwForm extends ConsumerStatefulWidget {
  const FindPwForm({super.key});

  @override
  ConsumerState<FindPwForm> createState() => _FindPwFormState();
}

class _FindPwFormState extends ConsumerState<FindPwForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> _requestVerification() async {
    // 폼 유효성 검사
    if (_formKey.currentState?.validate() != true) return;

    // 폼 값 저장
    _formKey.currentState?.save();
    final formData = _formKey.currentState?.value;
    final contact = formData?['email'] as String?;

    if (contact == null) return;

    // Notifier 접근
    final notifier = ref.read(findAuthNotifierProvider.notifier);

    try {
      // 인증번호 요청
      await notifier.requestVerificationCode(
        contact: contact,
        type: AuthType.findPw, // 비밀번호 찾기 타입 지정
      );

      // 성공 메시지는 상위 화면에서 처리
    } catch (e) {
      // 실패 처리
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('인증 요청 실패: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 상태 읽기
    final state = ref.watch(findAuthNotifierProvider);
    final isLoading = state.isLoading && !state.isCodeSent;

    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          // 이메일 입력 필드
          FormBuilderTextField(
            name: 'email',
            decoration: const InputDecoration(
              labelText: '아이디(이메일)',
            ),
            keyboardType: TextInputType.emailAddress,
            enabled: !isLoading,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "아이디(이메일)를 입력해주세요."),
              FormBuilderValidators.email(errorText: "유효한 이메일 형식이 아닙니다."),
            ]),
          ),

          const SizedBox(height: 20),

          // 인증번호 요청 버튼
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: Colors.grey),
            ),
            onPressed: isLoading ? null : _requestVerification,
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 3.0),
                  )
                : const Text(
                    "인증번호 요청",
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }
}
