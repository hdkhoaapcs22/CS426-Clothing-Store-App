import 'dart:io';
import 'dart:typed_data';
import 'package:clothing_store_app/modules/test_ai/result.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late File _image;
  dynamic _probability = 0;
  String? _result;
  List<String>? _labels;
  tfl.Interpreter? _interpreter;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    loadModel().then((_) {
      loadLabels().then((loadedLabels) {
        setState(() {
          _labels = loadedLabels;
        });
      });
    });
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

  void navigateToResult() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultPage(
                  resultImage: _image,
                  result: _result!,
                  probability: _probability,
                )));
  }

  Future<void> loadModel() async {
    try {
      _interpreter =
          await tfl.Interpreter.fromAsset('assets/model_unquant.tflite');
    } catch (e) {
      debugPrint('Error loading model: $e');
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }
  }

  void _setImage(File image) {
    setState(() {
      _image = image;
    });
    runInference();
  }

  Future<Uint8List> preprocessImage(File imageFile) async {
    // Decode the image to an Image object
    img.Image? originalImage = img.decodeImage(await imageFile.readAsBytes());

    // Resize the image to the correct size
    img.Image resizedImage =
        img.copyResize(originalImage!, width: 256, height: 256);

    // Convert to a byte buffer in the format suitable for TensorFlow Lite (RGB)
    // The model expects a 4D tensor [1, 224, 224, 3]
    // Flatten the resized image to match this shape
    Uint8List bytes = resizedImage.getBytes();
    return bytes;
  }

  Future<void> runInference() async {
    if (_labels == null) {
      return;
    }

    try {
      Uint8List inputBytes = await preprocessImage(_image);
      var input = inputBytes.buffer.asUint8List().reshape([1, 256, 256, 3]);
      var outputBuffer = List<int>.filled(1 * 4, 0).reshape([1, 4]);

      _interpreter!.run(input, outputBuffer);

      // Assuming output is now List<List<int>> after inference
      List<double> output = outputBuffer[0];

      // Print raw output for debugging
      debugPrint('Raw output: $output');

      // Calculate probability
      double maxScore = output.reduce(max);
      _probability = (maxScore / 255.0); // Convert to percentage

      // Get the classification result
      int highestProbIndex = output.indexOf(maxScore);
      String classificationResult = _labels![highestProbIndex];

      setState(() {
        _result = classificationResult;
        // _probability is updated with the calculated probability
      });
      navigateToResult();
    } catch (e) {
      debugPrint('Error during inference: $e');
    }
  }

  Future<List<String>> loadLabels() async {
    final labelsData =
        await DefaultAssetBundle.of(context).loadString('assets/labels.txt');
    return labelsData.split('\n');
  }

  String classifyImage(List<int> output) {
    int highestProbIndex = output.indexOf(output.reduce(max));
    return _labels![highestProbIndex];
  }
}
