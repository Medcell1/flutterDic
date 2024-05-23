part of 'word_cubit.dart';

abstract class WordState extends Equatable {
  @override
  List<Object> get props => [];
}

final class WordLoading extends WordState {}

class WordInitial extends WordState {
  @override
  List<Object> get props => [];
}

class WordLoaded extends WordState {
  final List<Word> words;
  final List<String> dropdownsItems;
  final String selectedValue;
  final List<String> definitions;
  final List<String> synonyms;
  final List<String> antonyms;
  final String audioUrl;

  WordLoaded(
    this.words,
    this.dropdownsItems,
    this.selectedValue,
    this.definitions,
    this.synonyms,
    this.antonyms,
    this.audioUrl,
  );

  @override
  List<Object> get props => [
        words,
        dropdownsItems,
        selectedValue,
        definitions,
        synonyms,
        antonyms,
        audioUrl,
      ];
}

class WordError extends WordState {
  late final String message;

  WordError(this.message);

  @override
  List<Object> get props => [message];
}
