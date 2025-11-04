import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../models/user_model.dart';
import '../providers/signup_notifier.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  // 이메일 인증 요청
  Future<void> _requestEmailVerification() async {
    final emailField = _formKey.currentState?.fields['email'];
    if (emailField?.validate() != true) return;

    final email = emailField?.value as String?;
    if (email == null || email.isEmpty) return;

    await ref.read(signUpNotifierProvider.notifier).sendVerificationCode(email);

    // 상태에 따른 스낵바 표시
    final state = ref.read(signUpNotifierProvider);
    if (mounted) {
      if (state.isCodeSent) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('인증번호가 이메일로 전송되었습니다.')),
        );
      } else if (state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('인증번호 전송 실패: ${state.errorMessage}')),
        );
      }
    }
  }

  // 인증번호 확인
  Future<void> _verifyEmailCode() async {
    final verifyCodeField = _formKey.currentState?.fields['verify_code'];
    final emailField = _formKey.currentState?.fields['email'];

    if (verifyCodeField?.validate() != true) return;

    final code = verifyCodeField?.value as String?;
    final email = emailField?.value as String?;

    if (code == null || code.isEmpty || email == null) return;

    await ref.read(signUpNotifierProvider.notifier).verifyCode(email, code);

    // 상태에 따른 처리
    final state = ref.read(signUpNotifierProvider);
    if (mounted) {
      if (state.isVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('이메일 인증이 완료되었습니다.')),
        );
      } else if (state.errorMessage != null) {
        _formKey.currentState?.fields['verify_code']
            ?.invalidate('인증번호가 일치하지 않아요.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage!)),
        );
      }
    }
  }

  // 회원가입
  Future<void> _signUp() async {
    final state = ref.read(signUpNotifierProvider);

    // 1. 이메일 인증 확인
    if (!state.isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이메일 인증을 먼저 완료해주세요.')),
      );
      return;
    }

    // 2. 전체 폼 검증
    if (_formKey.currentState?.validate() != true) return;

    // 3. 폼 데이터 저장 및 추출
    _formKey.currentState?.save();
    final formData = _formKey.currentState?.value;

    final name = formData?['name'] as String?;
    final phoneNumber = formData?['phoneNumber'] as String?;
    final email = formData?['email'] as String?;
    final password = formData?['password'] as String?;

    if (name == null ||
        phoneNumber == null ||
        email == null ||
        password == null) {
      return;
    }

    // 4. UserModel 생성
    final user = UserModel(
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      name: name,
    );

    // 5. 회원가입 호출
    await ref.read(signUpNotifierProvider.notifier).signUp(user);

    // 6. 결과 처리
    final signUpState = ref.read(signUpNotifierProvider);
    if (mounted) {
      if (signUpState.successMessage != null) {
        await _showSuccessDialog();
        if (mounted) {
          Navigator.of(context).pop(); // 로그인 화면으로
        }
      } else if (signUpState.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(signUpState.errorMessage!)),
        );
      }
    }
  }

  // 성공 다이얼로그
  Future<void> _showSuccessDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(FontAwesomeIcons.check, color: Colors.green),
              SizedBox(width: 16),
              Text('회원가입 완료'),
            ],
          ),
          content: const Text('회원가입이 완료되었습니다.\n로그인 화면으로 이동합니다.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpNotifierProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // 이름
              FormBuilderTextField(
                name: 'name',
                textInputAction: TextInputAction.next,
                enabled: !signUpState.isLoading,
                decoration: const InputDecoration(
                  labelText: '이름',
                ),
                validator: _validateName,
              ),
              const SizedBox(height: 16),
              // 휴대전화번호
              FormBuilderTextField(
                name: 'phoneNumber',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                enabled: !signUpState.isLoading,
                decoration: const InputDecoration(
                  labelText: '휴대전화번호',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: "휴대전화번호를 입력해주세요."),
                  FormBuilderValidators.match(
                    RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$'),
                    errorText: "올바른 휴대전화번호 형식인지 확인해주세요.",
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              // 이메일 + 인증 버튼
              Row(children: [
                Flexible(
                  child: FormBuilderTextField(
                    name: 'email',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: '이메일',
                    ),
                    validator: _validateEmail,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                        color: signUpState.isCodeSent
                            ? Colors.grey.shade700
                            : Colors.grey),
                  ),
                  onPressed: signUpState.isLoading || signUpState.isCodeSent
                      ? null
                      : _requestEmailVerification,
                  child: signUpState.isLoading && !signUpState.isCodeSent
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        )
                      : Text(
                          signUpState.isCodeSent ? "전송됨" : "인증",
                          style: TextStyle(
                              color: signUpState.isCodeSent
                                  ? Colors.grey.shade700
                                  : Colors.white),
                        ),
                ),
              ]),

              const SizedBox(height: 16),
              // 인증번호 + 확인 버튼
              Row(
                children: [
                  Flexible(
                    child: FormBuilderTextField(
                      name: 'verify_code',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '인증번호',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: '인증번호를 입력해주세요.'),
                        FormBuilderValidators.numeric(
                            errorText: '인증번호는 숫자만 입력 가능해요.'),
                      ]),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                          color: signUpState.isVerified
                              ? Colors.grey.shade700
                              : Colors.grey),
                    ),
                    onPressed: signUpState.isLoading ||
                            !signUpState.isCodeSent ||
                            signUpState.isVerified
                        ? null
                        : _verifyEmailCode,
                    child: signUpState.isLoading &&
                            signUpState.isCodeSent &&
                            !signUpState.isVerified
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2.0),
                          )
                        : Text(
                            signUpState.isVerified ? "완료" : "확인",
                            style: TextStyle(
                                color: signUpState.isVerified
                                    ? Colors.grey.shade700
                                    : Colors.white),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 비밀번호
              FormBuilderTextField(
                name: 'password',
                textInputAction: TextInputAction.done,
                obscureText: true,
                enabled: !signUpState.isLoading,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 32),
              // 회원가입 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                ),
                onPressed: signUpState.isLoading ? null : _signUp,
                child: signUpState.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 3.0),
                      )
                    : const Text(
                        "회원가입",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateName(String? value) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
          errorText: '앗! 이름을 입력하지 않으셨어요. 다시 한번 확인해주세요'),
      FormBuilderValidators.minLength(2,
          errorText: '이름이 너무 짧아요. 최소 2글자 이상 입력해주세요.'),
      FormBuilderValidators.maxLength(20,
          errorText: '이름이 너무 길어요. 20글자 이하로 부탁드려요.'),
    ])(value);
  }

  String? _validateEmail(String? value) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: '이메일 주소를 입력해주세요.'),
      FormBuilderValidators.email(errorText: '올바른 이메일 형식인지 확인해 주세요.'),
    ])(value);
  }

  String? _validatePassword(String? value) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: '비밀번호를 입력해주세요.'),
      FormBuilderValidators.password(
          errorText: '비밀번호는 8자 이상, 대/소문자, 특수문자를 섞어주세요'),
    ])(value);
  }
}
