import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/auth/find_auth_data.dart';
import '../providers/find_auth_notifier.dart';
import '../widgets/auth/find_id_form.dart';
import '../widgets/auth/find_pw_form.dart';
import '../widgets/auth/reset_password_form.dart';
import '../widgets/auth/verify_input.dart';

class FindIdPwScreen extends ConsumerStatefulWidget {
  const FindIdPwScreen({super.key});

  @override
  ConsumerState<FindIdPwScreen> createState() => _FindIdPwScreenState();
}

class _FindIdPwScreenState extends ConsumerState<FindIdPwScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    // 탭 전환 시 Provider 상태 초기화 (다른 인증 플로우 시작 대비)
    _tabController.addListener(_onTabChange);
  }

  void _onTabChange() {
    // 탭 전환 시 상태 초기화
    if (!_tabController.indexIsChanging) {
      ref.read(findAuthNotifierProvider.notifier).resetState();
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(findAuthNotifierProvider, (previous, next) {
      if (next.isVerified &&
          next.currentAuthType == AuthType.findId &&
          next.foundId != null &&
          next.foundId!.isNotEmpty) {
        _showIdFoundDialog(context, next.foundId!);
        ref.read(findAuthNotifierProvider.notifier).resetState();
      }
    });

    final state = ref.watch(findAuthNotifierProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.white, // 실제 앱에 맞는 색상 사용
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.grey,
              labelPadding: const EdgeInsets.all(16),
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              controller: _tabController,
              tabs: const [
                Text("아이디 찾기"),
                Text("비밀번호 찾기"),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildIdTab(state),
                    _buildPwTab(state),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================== 아이디 찾기 탭 ==========================
  Widget _buildIdTab(FindAuthState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32),
          if (!state.isCodeSent) const FindIdForm(),
          if (state.isCodeSent) const VerifyInput(),
        ],
      ),
    );
  }

  // ========================== 비밀번호 찾기 탭 ==========================
  Widget _buildPwTab(FindAuthState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32),
          if (!state.isCodeSent) const FindPwForm(),
          if (state.isCodeSent && !state.isVerified) VerifyInput(),
          if (state.isVerified &&
              state.currentAuthType == AuthType.findPw) // ← 추가
            const ResetPasswordForm(),
        ],
      ),
    );
  }

  // ========================== 다이얼로그 ==========================
  void _showIdFoundDialog(BuildContext context, String foundId) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: const Row(
            children: [
              Icon(FontAwesomeIcons.check, color: Colors.green),
              SizedBox(width: 16),
              Text('아이디 확인'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('회원님의 아이디는 다음과 같습니다.'),
              const SizedBox(height: 16),
              Text(
                foundId,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pop(context);
              },
              child: const Text(
                '로그인하러 가기',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
