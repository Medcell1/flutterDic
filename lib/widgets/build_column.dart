import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dictionary/widgets/bullet_point_list.dart';
import 'package:flutter_dictionary/widgets/tab_container.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/word_cubit.dart';
import 'dropdown.dart';

SizedBox buildColumn(
  double width,
  BuildContext context,
  WordCubit wordCubit,
  String word,
  String phonetic,
  TabController tabController,
  List<String> definitions,
  List<String> antonyms,
  List<String> synonyms,
) {
  return SizedBox(
    height: double.maxFinite,
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 25, right: width * 0.85),
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        const Spacer(),
        DropDownWidget(
          wordCubit: wordCubit,
        ),
        Text(
          word.replaceFirst(
            word[0],
            word[0].toUpperCase(),
          ),
          style: GoogleFonts.yesevaOne(
            textStyle: const TextStyle(
                color: Colors.white, letterSpacing: .5, fontSize: 40),
          ),
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: IconButton(
                onPressed: () {
                  wordCubit.playAudio();
                },
                icon: const Icon(
                  CupertinoIcons.speaker_2,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              phonetic,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
        TabBar(
          controller: tabController,
          indicatorColor: Colors.transparent,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          dividerColor: Colors.transparent,
          tabs: [
            TabContainer(
              text: 'definition',
              isSelected: tabController.index == 0,
            ),
            TabContainer(
              text: 'antonyms',
              isSelected: tabController.index == 1,
            ),
            TabContainer(
              text: 'synonyms',
              isSelected: tabController.index == 2,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          flex: 4,
          child: TabBarView(
            controller: tabController,
            children: [
              BulletPointList(
                items: definitions,
              ),
              BulletPointList(
                items: antonyms,
              ),
              BulletPointList(
                items: synonyms,
              ),
            ],
          ),
        ),
        Spacer(),
      ],
    ),
  );
}
