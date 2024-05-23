
import '../bloc/word_cubit.dart';
import 'package:flutter/material.dart';
class DropDownWidget extends StatelessWidget {
  final WordCubit wordCubit;

  const DropDownWidget({
    super.key,
    required this.wordCubit,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      padding: const EdgeInsets.only(left: 20, right: 40),
      underline: const SizedBox(),
      dropdownColor: Colors.green,
      style: const TextStyle(fontSize: 12, color: Colors.white),
      iconSize: 18,
      icon: const Icon(Icons.keyboard_arrow_down),
      iconEnabledColor: Colors.white,
      items: wordCubit.dropdownsItems
          .map(
            (item) => DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      )
          .toList(),
      isExpanded: true,
      onChanged: (value) {
        print("heyyyyy");
        wordCubit.dropDownValueChanged(value!.toString());
        print("selected===>${wordCubit.selectedValue}");
      },
      value: wordCubit.selectedValue,
    );
  }
}
