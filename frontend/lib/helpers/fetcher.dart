import 'package:http/http.dart' as http;

class Fetcher {
  static Future<http.Response> fetchWithAuth(String url, String token) {
    final headers = {"Authorization": "Bearer: $token"};
    return http.get(Uri.parse(url), headers: headers);
  }
}
