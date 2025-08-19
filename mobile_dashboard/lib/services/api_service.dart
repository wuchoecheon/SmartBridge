import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 🔗 Flask 서버 URL (나중에 실제 서버 주소로 변경)
  static const String _baseUrl =
      'https://737411f04049.ngrok-free.app'; // ngrok 주소
  //static const String _baseUrl = 'http://192.168.253.204:5000'; // 실제 서버 IP

  // ⏱️ 타임아웃 설정 (웹에서 빠른 실패를 위해 짧게 설정)
  static const Duration _timeout = Duration(seconds: 3);

  // 🤖 파이썬 추천 API 호출
  static Future<Map<String, dynamic>?> getRecommendations() async {
    try {
      print('🚀 파이썬 추천 API 호출 시도...');
      print('🔗 서버 URL: $_baseUrl/recommend_gesture_auto');

      final uri = Uri.parse('$_baseUrl/recommend_gesture_auto');

      print('📡 HTTP GET 요청 시작...');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(_timeout);

      print('📡 API 응답 상태: ${response.statusCode}');
      print('📡 응답 본문 길이: ${response.body.length}');

      if (response.statusCode == 200) {
        print(
            '📡 응답 내용: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}...');
        final data = json.decode(response.body) as Map<String, dynamic>;
        print('✅ 추천 데이터 수신 성공: ${data.keys}');
        return data;
      } else {
        print('❌ API 오류: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('💥 네트워크 오류 상세: $e');
      print('💥 오류 타입: ${e.runtimeType}');
      return null;
    }
  }

  // 🔧 서버 연결 테스트
  static Future<bool> testConnection() async {
    try {
      print('🔍 서버 연결 테스트 중...');

      final uri = Uri.parse('$_baseUrl/recommend_gesture_auto');

      final response = await http.get(uri).timeout(
            const Duration(seconds: 2), // 더 짧은 타임아웃
          );

      final isConnected = response.statusCode == 200;
      print(isConnected ? '✅ 서버 연결 성공!' : '❌ 서버 연결 실패');

      return isConnected;
    } catch (e) {
      print('💥 서버 연결 실패: $e');
      return false;
    }
  }

  // 🌡️ 서버 상태 체크 (헬스체크)
  static Future<Map<String, dynamic>> getServerStatus() async {
    try {
      final isConnected = await testConnection();

      return {
        'connected': isConnected,
        'baseUrl': _baseUrl,
        'timestamp': DateTime.now().toIso8601String(),
        'timeout': _timeout.inSeconds,
      };
    } catch (e) {
      return {
        'connected': false,
        'error': e.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }

  // 📊 추천 데이터 파싱 및 변환
  static Map<String, dynamic> parseRecommendations(
      Map<String, dynamic> apiData) {
    try {
      final recommendations =
          apiData['recommendations'] as List<dynamic>? ?? [];
      final timestamp = apiData['timestamp'] as String?;

      // Flutter 앱에서 사용하기 쉬운 형태로 변환
      final parsedRecommendations = recommendations.map((rec) {
        final recommendation = rec as Map<String, dynamic>;
        return {
          'device': recommendation['device'] ?? '',
          'gesture': recommendation['recommended_gesture'] ?? '',
          'reason': recommendation['reason'] ?? '',
        };
      }).toList();

      return {
        'recommendations': parsedRecommendations,
        'timestamp': timestamp,
        'totalCount': parsedRecommendations.length,
        'source': 'python_api',
      };
    } catch (e) {
      print('❌ 추천 데이터 파싱 오류: $e');
      return {
        'recommendations': <Map<String, dynamic>>[],
        'error': e.toString(),
        'source': 'python_api',
      };
    }
  }
}
