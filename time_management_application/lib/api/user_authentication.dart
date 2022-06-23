import 'dart:convert';

import "package:http/http.dart" as http;

class UserAuthentication {
  // Local host server
  final String _url = "http://10.0.2.2:8000/api/";

  // Function to request and response data in and from backed respectively.
  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;

    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  //
  _setHeaders() => {
        "Content-type": "application/json",
        "Accept": "application/json",
      };
}
