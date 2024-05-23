import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dictionary/data/API/service.dart';
import 'package:flutter_dictionary/data/get_it/locator.dart';
import '../data/models/word_model.dart';

part 'word_state.dart';

class WordCubit extends Cubit<WordState> {
  final ApiService apiService = getIt<ApiService>();

  WordCubit() : super(WordInitial());

  List<String> dropdownsItems = [];
  List<String> antonyms = [];
  List<String> synonyms = [];
  String selectedValue = "";
  List<String> definitions = [];
  String? audioUrl;

  Future<void> fetchWords(String word) async {
    emit(WordLoading());
    try {
      List<Word> words = await apiService.fetchWord(word);
      print("words from cubit====>$words");

      if (words.isNotEmpty) {
        _initializeWordData(words);
        emit(
          WordLoaded(
            words,
            dropdownsItems,
            selectedValue,
            definitions,
            synonyms,
            antonyms,
            audioUrl!,
          ),
        );
      } else {
        emit(WordError("Failed to fetch words."));
      }
    } catch (e) {
      emit(WordError(e.toString()));
    }
  }

  void dropDownValueChanged(String newValue) {
    selectedValue = newValue;
    final currentState = state;

    if (currentState is WordLoaded) {
      getDefinitionsBySelectedValue(currentState.words);
      emit(
        WordLoaded(
          currentState.words,
          currentState.dropdownsItems,
          newValue,
          definitions,
          currentState.antonyms,
          currentState.synonyms,
          currentState.audioUrl,
        ),
      );
    }
  }

  void _initializeWordData(List<Word> words) {
    dropdownsItems = _getDropDownItems(words);
    selectedValue = dropdownsItems.isNotEmpty ? dropdownsItems.first : "";
    audioUrl = _getFirstValidAudioUrl(words);
    getDefinitionsBySelectedValue(words);
    antonyms = _getAntonyms(words);
    synonyms = _getSynonyms(words);
  }

  List<String> _getDropDownItems(List<Word> words) {
    return words
        .expand((word) => word.meanings)
        .map((meaning) => meaning.partOfSpeech)
        .toSet()
        .toList(growable: false);
  }

  void getDefinitionsBySelectedValue(List<Word> words) {
    definitions = words
        .expand((word) => word.meanings)
        .where((meaning) => meaning.partOfSpeech == selectedValue)
        .expand((meaning) => meaning.definitions)
        .toList();
    definitions =
        definitions.length > 3 ? definitions.sublist(0, 3) : definitions;
  }

  List<String> _getAntonyms(List<Word> words) {
    var antonymsList = words
        .expand((word) => word.meanings)
        .expand((meaning) => meaning.antonyms)
        .toSet()
        .toList();
    return antonymsList.length > 6 ? antonymsList.sublist(0, 6) : antonymsList;
  }

  List<String> _getSynonyms(List<Word> words) {
    var synonymsList = words
        .expand((word) => word.meanings)
        .expand((meaning) => meaning.synonyms)
        .toSet()
        .toList();
    return synonymsList.length > 6 ? synonymsList.sublist(0, 6) : synonymsList;
  }

  String? _getFirstValidAudioUrl(List<Word> words) {
    for (var word in words) {
      if (word.audio.isNotEmpty) {
        return word.audio;
      }
    }
    return null;
  }

  void playAudio() async {
    final player = AudioPlayer();
    if (audioUrl != null && audioUrl!.isNotEmpty) {
      print("Playing audio URL: $audioUrl");
      await player.play(
        UrlSource(audioUrl!),
      );
    } else {
      print("No valid audio URL found.");
    }
  }
}
