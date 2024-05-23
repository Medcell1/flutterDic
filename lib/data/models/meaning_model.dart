class Meaning {
  List<String> definitions;
  String partOfSpeech;
  List<String> synonyms;
  List<String> antonyms;

  Meaning({
    required this.definitions,
    required this.partOfSpeech,
    required this.synonyms,
    required this.antonyms,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      definitions: (json['definitions'] as List)
          .map((def) => def['definition'].toString())
          .toList(),
      partOfSpeech: json['partOfSpeech'].toString(),
      synonyms: List<String>.from(json['synonyms'] ?? []),
      antonyms: List<String>.from(json['antonyms'] ?? []),
    );
  }
}
