import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> downloadFile(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode != HttpStatus.ok) {
    throw Exception('Failed to download file at $url.');
  }
  return response.body;
}
