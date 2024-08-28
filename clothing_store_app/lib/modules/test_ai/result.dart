import 'package:flutter/material.dart';
import 'dart:io';

class ResultPage extends StatelessWidget {
  final File resultImage;
  final String result;
  final dynamic probability;
  const ResultPage(
      {super.key,
      required this.resultImage,
      required this.result,
      this.probability});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Coffee tree diseases detector',
                style: TextStyle(
                    color: Color.fromARGB(255, 7, 71, 53),
                    fontWeight: FontWeight.bold)),
            backgroundColor: const Color.fromARGB(255, 185, 148, 112)),
        backgroundColor: const Color.fromARGB(255, 181, 193, 142),
        body: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(20)),
                Image.file(
                  File(resultImage.path),
                  height: 400.0,
                  width: 300.0,
                ),
                const Padding(padding: EdgeInsets.all(20)),
                Text(result),
                const Padding(padding: EdgeInsets.all(20)),
                Text(
                  'Probability: ${(probability * 100).toStringAsFixed(2)}%',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            )));
  }
}
