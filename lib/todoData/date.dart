import 'package:flutter/material.dart';

Widget dateWigdet(DateTime date) {
  final String fDate = '${date.day} | ${date.month} | ${date.year}';

  return SizedBox(
    height: 40,
    width: 100,
    child: Card(
      //elevation: 100,
      child: Center(
          child: Text(
        fDate,
        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
      )),
    ),
  );
}
