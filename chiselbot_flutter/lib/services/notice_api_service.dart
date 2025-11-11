import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notice.dart';

class NoticeApiService {
  final String baseUrl;
  final String? token;

  NoticeApiService(this.baseUrl, {this.token});

  Map<String, String> _headers() {
    final h = <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
    };
    if (token != null && token!.isNotEmpty) {
      h['Authorization'] = 'Bearer $token';
    }
    return h;
  }

  /// 공지사항 목록 조회
  Future<List<Notice>> getNotices() async {
    final res = await http.get(
      Uri.parse('$baseUrl/api/notice'),
      headers: _headers(),
    );

    if (res.statusCode == 200) {
      final m = jsonDecode(utf8.decode(res.bodyBytes));

      // CommonResponse 파싱
      if (m is Map && m['success'] == true) {
        final data = m['data'];
        if (data is List) {
          return data.map((e) => Notice.fromJson(e)).toList();
        }
      }
      throw Exception('공지사항 데이터 형식 오류');
    }
    throw Exception('공지사항 목록 조회 실패 (${res.statusCode})');
  }

  /// 공지사항 상세 조회 (조회수 증가)
  Future<Notice> getNoticeById(int noticeId) async {
    final res = await http.get(
      Uri.parse('$baseUrl/api/notice/$noticeId'),
      headers: _headers(),
    );

    if (res.statusCode == 200) {
      final m = jsonDecode(utf8.decode(res.bodyBytes));

      // CommonResponse 파싱
      if (m is Map && m['success'] == true) {
        final data = m['data'];
        return Notice.fromJson(data as Map<String, dynamic>);
      }
      throw Exception('공지사항 데이터 형식 오류');
    }
    throw Exception('공지사항 상세 조회 실패 (${res.statusCode})');
  }
}
