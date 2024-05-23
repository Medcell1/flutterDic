import 'package:flutter/material.dart';

class BulletPointList extends StatelessWidget {
  final List<String> items;

  const BulletPointList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.isEmpty
          ? [
            const Spacer(),
              const Center(
                child: Text(
                  "Not available",
                  style: TextStyle(color: Colors.white),
                ),
              ),
        const Spacer(),
            ]
          : items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "•",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontSize: 16,
                              height: 1.55,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
    );
  }
}
