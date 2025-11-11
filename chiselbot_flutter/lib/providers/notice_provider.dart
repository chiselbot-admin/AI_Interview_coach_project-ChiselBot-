import 'package:ai_interview/core/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/notice.dart';
import '../repositories/i_notice_repository.dart';
import '../repositories/server_notice_repository.dart';
import '../services/notice_api_service.dart';
import 'auth_notifier.dart';

final noticeApiServiceProvider = Provider<NoticeApiService>((ref) {
  final authState = ref.watch(authNotifierProvider);
  final token = authState.maybeWhen(
    (isLoading, isLoggedIn, user, token, errorMessage) => token,
    orElse: () => null,
  );
  return NoticeApiService(Constants.baseUrl, token: token);
});

final noticeRepositoryProvider = Provider<INoticeRepository>((ref) {
  // Server 사용
  final apiService = ref.watch(noticeApiServiceProvider);
  return ServerNoticeRepository(apiService);
});

final noticesProvider = FutureProvider<List<Notice>>((ref) async {
  final repository = ref.watch(noticeRepositoryProvider);
  return await repository.getNotices();
});

final noticeProvider = FutureProvider.family<Notice, int>((ref, id) async {
  final repository = ref.watch(noticeRepositoryProvider);
  return await repository.getNoticeById(id);
});
