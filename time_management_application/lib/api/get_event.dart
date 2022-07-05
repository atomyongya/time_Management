import 'package:http/http.dart' as http;

class GetEvent {
  final String _uri = "http://10.0.2.2:8000/api/";
  getEvent(String link) async {
    String finalUrl = _uri + link;
    return await http.get(Uri.parse(finalUrl), headers: _headers());
  }

  _headers() => {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
}
