import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dictionary/bloc/word_cubit.dart';
import 'package:flutter_dictionary/constants/colors.dart';

import '../widgets/build_column.dart';

class DisplayPage extends StatefulWidget {
  final String searchWord;

  const DisplayPage({super.key, required this.searchWord});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    BlocProvider.of<WordCubit>(context).fetchWords(widget.searchWord);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<WordCubit, WordState>(
        builder: (context, state) {
          final wordCubit = context.watch<WordCubit>();
          if (state is WordLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is WordLoaded) {
            String phonetic = state.words[0].phonetic;
            String word = state.words[0].word;
            List<String> definitions = state.definitions;
            List<String> synonyms = state.synonyms;
            List<String> antonyms = state.antonyms;
            return buildColumn(width, context, wordCubit, word, phonetic,
                _tabController, definitions, antonyms, synonyms);
          } else if (state is WordError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else {
            return const Center(child: Text('No Word found'));
          }
        },
      ),
    );
  }
}
