import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/providers/filter_provider.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/services/database/search_history.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_button.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;
  final picker = ImagePicker();
  late File _image;
  List<String>? labels;
  late tfl.Interpreter interpreter;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    loadModel().then((_) {
      loadLabels().then((loadedLabels) {
        setState(() {
          labels = loadedLabels;
        });
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    interpreter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double lottieSize = MediaQuery.of(context).size.width * 0.2;
    return Consumer<FilterProvider>(
      builder: (context, filterProvider, _) {
        return Scaffold(
            backgroundColor: AppTheme.scaffoldBackgroundColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonDetailedAppBarView(
                        onPrefixIconClick: () {
                          Navigator.pop(context);
                        },
                        title: AppLocalizations(context).of("search"),
                        prefixIconData: Icons.arrow_back),
                    const Padding(padding: EdgeInsets.all(12)),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onEditingComplete: () {
                              SearchHistoryService().addHistory(
                                  hisID: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  content: searchController.text);
                              NavigationServices(context).gotoResultScreen(
                                  searchController.text,
                                  filterProvider.priceRange);
                            },
                            controller: searchController,
                            cursorColor: AppTheme.brownColor,
                            decoration: InputDecoration(
                              fillColor: AppTheme.backgroundColor,
                              filled: true,
                              contentPadding: const EdgeInsets.all(0),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                borderSide: BorderSide(
                                  color: AppTheme.greyBackgroundColor,
                                  width: 0.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                borderSide: BorderSide(
                                  color: AppTheme.greyBackgroundColor,
                                  width: 0.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                borderSide: BorderSide(
                                  color: AppTheme.greyBackgroundColor,
                                  width: 0.5,
                                ),
                              ),
                              prefixIcon: IconButton(
                                onPressed: () {
                                  SearchHistoryService().addHistory(
                                      hisID: DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString(),
                                      content: searchController.text);
                                  NavigationServices(context).gotoResultScreen(
                                      searchController.text,
                                      filterProvider.priceRange);
                                },
                                icon: Icon(Iconsax.search_normal_1,
                                    color: AppTheme.brownColor),
                              ),
                              hintText: AppLocalizations(context).of("search"),
                              hintStyle: TextStyles(context)
                                  .getLabelLargeStyle(true)
                                  .copyWith(),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(4)),
                        TapEffect(
                          onClick: () {
                            showAnimatedImagePickerDialog(
                                filterProvider.priceRange);
                          },
                          child: CircleAvatar(
                            backgroundColor: AppTheme.brownButtonColor,
                            child: Icon(
                              Iconsax.scanning,
                              size: 20,
                              color: AppTheme.iconColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(4)),
                    Row(
                      children: [
                        Text(AppLocalizations(context).of("recent"),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            SearchHistoryService().removeAllHistory();
                          },
                          style: TextButton.styleFrom(
                              //overlayColor: Colors.transparent,
                              ),
                          child: Text(
                            AppLocalizations(context).of("clear_all"),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(88, 57, 39, 1),
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1, color: Colors.grey),
                    StreamBuilder(
                        stream: SearchHistoryService().getSearchHistoryStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: Lottie.asset(
                                  Localfiles.loading,
                                  width: lottieSize,
                                ));
                          }

                          List<DocumentSnapshot<Object?>> dc =
                              snapshot.data!.docs;
                          List<Map<String, dynamic>> data = [];
                          for (int i = dc.length - 1; i >= 0; --i) {
                            data.add(dc[i].data()! as Map<String, dynamic>);
                          }

                          return SizedBox(
                              height: MediaQuery.of(context).size.height - 300,
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            searchController.text =
                                                data[index]['content'];
                                            SearchHistoryService().addHistory(
                                                hisID: DateTime.now()
                                                    .millisecondsSinceEpoch
                                                    .toString(),
                                                content: searchController.text);
                                            NavigationServices(context)
                                                .gotoResultScreen(
                                                    searchController.text,
                                                    filterProvider.priceRange);
                                          },
                                          style: TextButton.styleFrom(
                                              //overlayColor: Colors.transparent,
                                              ),
                                          child: Text(
                                            data[index]['content'],
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18),
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            SearchHistoryService()
                                                .removeHistory(
                                                    hisID: data[index]
                                                        ['hisID']);
                                          },
                                          icon: const Icon(
                                            Icons.highlight_remove,
                                            color:
                                                Color.fromRGBO(88, 57, 39, 1),
                                          ),
                                        )
                                      ],
                                    );
                                  }));
                        }),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Future<void> loadModel() async {
    try {
      interpreter =
          await tfl.Interpreter.fromAsset('assets/model_unquant.tflite');
    } catch (e) {
      debugPrint('Error loading model: $e');
    }
  }

  Future<List<String>> loadLabels() async {
    final labelsData =
        await DefaultAssetBundle.of(context).loadString('assets/labels.txt');
    return labelsData.split('\n');
  }

  Future<void> pickImageFromCamera(RangeValues priceRange) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _setImage(File(pickedFile.path), priceRange);
    }
  }

  Future<void> pickImageFromGallery(RangeValues priceRange) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _setImage(File(pickedFile.path), priceRange);
    }
  }

  void _setImage(File image, RangeValues priceRange) {
    setState(() {
      _image = image;
    });
    runInference(priceRange);
  }

  Future<Uint8List> preprocessImage(File imageFile) async {
    // Decode the image to an Image object
    img.Image? originalImage = img.decodeImage(await imageFile.readAsBytes());

    // Resize the image to 224x224
    img.Image resizedImage =
        img.copyResize(originalImage!, width: 224, height: 224);

    // Ensure the image has 3 channels (RGB)
    img.Image rgbImage = img.copyResize(resizedImage,
        width: 224, height: 224, interpolation: img.Interpolation.cubic);

    // Convert to Uint8List in the correct format for TensorFlow Lite (RGB only)
    Uint8List bytes = Uint8List.fromList(
        rgbImage.getBytes(format: img.Format.rgb)); // Only keep RGB channels

    return bytes;
  }

  Future<void> runInference(RangeValues priceRange) async {
    if (labels == null) {
      return;
    }

    try {
      Uint8List inputBytes = await preprocessImage(_image);
      var input = inputBytes.buffer.asUint8List().reshape([1, 224, 224, 3]);
      var outputBuffer = List<double>.filled(1 * 4, 0).reshape([1, 4]);

      interpreter.run(input, outputBuffer);

      // Assuming output is now List<List<int>> after inference
      List<double> output = outputBuffer[0];

      // Calculate probability
      double maxScore = output.reduce(max);
      //probability = (maxScore / 255.0); // Convert to percentage

      // Get the classification result
      int highestProbIndex = output.indexOf(maxScore);
      String classificationResult = labels![highestProbIndex];

      searchController.text = classificationResult.trim();
      SearchHistoryService().addHistory(
          hisID: DateTime.now().millisecondsSinceEpoch.toString(),
          content: searchController.text);
      NavigationServices(context)
          .gotoResultScreen(searchController.text, priceRange);
    } catch (e) {
      debugPrint('Error during inference: $e');
    }
  }

  Future<void> showAnimatedImagePickerDialog(RangeValues priceRange) {
    final size = MediaQuery.of(context).size;
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (content, animation1, animation2) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation1),
            child: FadeTransition(
                opacity:
                    Tween<double>(begin: 0.5, end: 1.0).animate(animation1),
                child: AlertDialog(
                  title: Center(
                    child: Text(
                      'Upload your picture',
                      style: TextStyles(context)
                          .getButtonTextStyle()
                          .copyWith(color: AppTheme.primaryTextColor),
                    ),
                  ),
                  content: SizedBox(
                    height: size.height / 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CommonButton(
                            onTap: () async {
                              Navigator.pop(context);
                              pickImageFromGallery(priceRange);
                            },
                            backgroundColor: AppTheme.brownButtonColor,
                            radius: 30,
                            height: size.height / 18,
                            buttonTextWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  AppLocalizations(context).of("from_library"),
                                  style: TextStyles(context)
                                      .getLabelLargeStyle(false)
                                      .copyWith(
                                          color: AppTheme.backgroundColor,
                                          fontWeight: FontWeight.w500),
                                ),
                                const Padding(padding: EdgeInsets.all(8)),
                                const Icon(
                                  Iconsax.gallery_add,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                        CommonButton(
                            onTap: () async {
                              Navigator.pop(context);
                              pickImageFromCamera(priceRange);
                            },
                            radius: 30,
                            height: size.height / 18,
                            backgroundColor: AppTheme.brownButtonColor,
                            buttonTextWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(AppLocalizations(context).of("take_photo"),
                                    style: TextStyles(context)
                                        .getLabelLargeStyle(false)
                                        .copyWith(
                                            color: AppTheme.backgroundColor,
                                            fontWeight: FontWeight.w500)),
                                const Padding(padding: EdgeInsets.all(8)),
                                const Icon(
                                  Iconsax.camera,
                                  color: Colors.white,
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                )),
          );
        },
        transitionBuilder: (context, a1, a2, widget) {
          return widget;
        });
  }
}
