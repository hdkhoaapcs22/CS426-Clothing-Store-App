import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final picker = ImagePicker();
  late List _recognitions;

  initTFlite() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
    );
  }

  @override
  void initState() {
    super.initState();
    initTFlite();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

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
              const Padding(padding: EdgeInsets.all(40)),
              //Image.asset('assets/home_page_logo.png'),
              const Padding(padding: EdgeInsets.all(40)),
              ElevatedButton.icon(
                onPressed: () {
                  pickImageFromGallery();
                },
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Color.fromARGB(255, 247, 220, 185))),
                icon: const Icon(
                  Icons.upload_outlined,
                  color: Color.fromARGB(255, 60, 115, 99),
                  size: 30.0,
                ),
                label: const Text('Upload from your device',
                    style: TextStyle(color: Color.fromARGB(255, 60, 115, 99))),
              ),
              const Padding(padding: EdgeInsets.all(5)),
              ElevatedButton.icon(
                onPressed: () {
                  pickImageFromCamera();
                },
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Color.fromARGB(255, 247, 220, 185))),
                icon: const Icon(
                  Icons.camera,
                  color: Color.fromARGB(255, 60, 115, 99),
                  size: 30.0,
                ),
                label: const Text('Take a photo',
                    style: TextStyle(color: Color.fromARGB(255, 60, 115, 99))),
              ),
            ],
          )),
    );
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      recognizeImage(pickedFile);
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      recognizeImage(pickedFile);
    }
  }

  Future recognizeImage(XFile image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions!;
    });
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms. Result is $_recognitions");
  }
}
