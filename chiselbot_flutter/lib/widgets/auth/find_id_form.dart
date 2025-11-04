import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../models/auth/find_auth_data.dart';
import '../../providers/find_auth_notifier.dart';

class FindIdForm extends ConsumerStatefulWidget {
  const FindIdForm({super.key});

  @override
  ConsumerState<FindIdForm> createState() => _FindIdFormState();
}

class _FindIdFormState extends ConsumerState<FindIdForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> _requestVerification() async {
    // 폼 유효성 검사
    if (_formKey.currentState?.validate() != true) return;

    // 폼 값 저장
    _formKey.currentState?.save();
    final formData = _formKey.currentState?.value;
    final contact = formData?['phoneNumber'] as String?;

    if (contact == null) return;

    // Notifier 접근
    final notifier = ref.read(findAuthNotifierProvider.notifier);

    try {
      // 인증번호 요청
      await notifier.requestVerificationCode(
        contact: contact,
        type: AuthType.findId, // 아이디 찾기 타입 지정
      );

      // 성공 메시지 (SnackBar 등) 출력은 상위 find_id_pw_screen에서 처리
    } catch (e) {
      // 실패 처리 (SnackBar 또는 Dialog로 사용자에게 알림)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('인증 요청 실패: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 상태 읽기 (로딩 상태를 버튼 비활성화에 사용)
    final state = ref.watch(findAuthNotifierProvider);
    final isLoading = state.isLoading && !state.isCodeSent; // 코드 전송 중일 때만 로딩 표시

    return FormBuilder(
      key: _formKey,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 휴대전화번호 입력 필드
          FormBuilderTextField(
            name: 'phoneNumber',
            decoration: InputDecoration(
              labelText: '휴대전화번호',
            ),
            keyboardType: TextInputType.phone,
            enabled: !isLoading && !state.isCodeSent, // 로딩 중이거나 이미 전송했으면 비활성화
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "휴대전화번호를 입력해주세요."),
              // 이전에 정의했던 실용적인 한국 전화번호 정규식
              FormBuilderValidators.match(
                RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$'),
                errorText: "유효한 휴대전화번호 형식이 아닙니다.",
              ),
            ]),
          ),

          const SizedBox(height: 20),

          // 인증번호 요청 버튼
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: Colors.grey),
            ),
            onPressed:
                isLoading || state.isCodeSent ? null : _requestVerification,
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
