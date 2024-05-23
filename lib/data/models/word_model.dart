import 'meaning_model.dart';

class Word {
  String word;
  String phonetic;
  String audio;
  List<Meaning> meanings;
  List<String> synonyms;
  List<String> antonyms;

  Word({
    required this.word,
    required this.phonetic,
    required this.audio,
    required this.meanings,
    required this.synonyms,
    required this.antonyms,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    List<Meaning> meanings = (json['meanings'] as List)
        .map((meaning) => Meaning.fromJson(meaning))
        .toList();

    List<String> synonyms = [];
    List<String> antonyms = [];
    for (var meaning in meanings) {
      synonyms.addAll(meaning.synonyms);
      antonyms.addAll(meaning.antonyms);
    }

    String audioUrl = '';
    if (json['phonetics'] != null && (json['phonetics'] as List).isNotEmpty) {
      for (var phonetic in json['phonetics']) {
        if (phonetic['audio'] != null && phonetic['audio'].isNotEmpty) {
          audioUrl = phonetic['audio'];
          break;
        }
      }
    }

    return Word(
      word: json['word'].toString(),
      phonetic: json['phonetic']?.toString() ?? '',
      audio: audioUrl,
      meanings: meanings,
      synonyms: synonyms,
      antonyms: antonyms,
    );
  }
}
