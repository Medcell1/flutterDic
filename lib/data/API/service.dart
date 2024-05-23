import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/word_model.dart';

class ApiService {
  final http.Client client;
  ApiService({required this.client});

  Future<List<Word>> fetchWord(String word) async {
    try {
      var response = await client.get(
        Uri.parse(
          'https://api.dictionaryapi.dev/api/v2/entries/en/$word',
        ),
      );
      print('https://api.dictionaryapi.dev/api/v2/entries/en/$word');

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        print("data ===> $data");
        return data.map<Word>((item) => Word.fromJson(item)).toList();
      } else {
        print("Failed to load data: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("error from api service ===> $e");
      return [];
    }
  }
}
