import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import '../core/app_router.dart';
import '../providers/notice_provider.dart';

class NoticeView extends ConsumerStatefulWidget {
  const NoticeView({super.key});

  @override
  ConsumerState<NoticeView> createState() => _NoticeViewState();
}

class _NoticeViewState extends ConsumerState<NoticeView> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 10000;
  static const int _infiniteItemCount = 2000000000;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startAutoScroll();
  }

  // 자동 스크롤 시작 로직 (3초마다 페이지 전환)
  void _startAutoScroll() {
    const duration = Duration(seconds: 3);
    _timer = Timer.periodic(duration, (Timer timer) {
      if (_pageController.hasClients) {
        // 다음 페이지 인덱스 계산 (마지막 페이지면 0으로 순환)
        // final int nextPageIndex = (_currentPage + 1) % _bannerItems.length;
        final int nextPageIndex = _currentPage + 1;

        _pageController.animateToPage(
          nextPageIndex,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noticesAsync = ref.watch(noticesProvider);
    final double bannerHeight = 16.0;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.notice);
      },
      child: Center(
        child: SizedBox(
          height: bannerHeight + 16,
          child: noticesAsync.when(
            data: (notices) {
              if (notices.isEmpty) {
                return const Center(
                  child: Text(
                    '공지사항이 없습니다.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                );
              }

              return PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: _infiniteItemCount,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final actualIndex = index % notices.length;
                  final notice = notices[actualIndex];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                        color:
                            Theme.of(context).colorScheme.surfaceContainerLow),
                    child: Row(
                      children: [
                        if (notice.isNew)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: 5,
                              width: 5,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            '[공지] ${notice.title}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              );
            },
            loading: () => const SizedBox(),
            error: (_, __) => const Center(
              child: Text(
                '공지를 불러올 수 없습니다.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
