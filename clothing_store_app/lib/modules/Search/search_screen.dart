import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:clothing_store_app/services/database/search_history.dart';
import 'package:clothing_store_app/utils/localfiles.dart';
import 'package:clothing_store_app/utils/text_styles.dart';
import 'package:clothing_store_app/utils/themes.dart';
import 'package:clothing_store_app/widgets/common_detailed_app_bar.dart';
import 'package:clothing_store_app/widgets/tap_effect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;
  final picker = ImagePicker();
  late dynamic _recognitions;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    initTFlite();
  }

  @override
  void dispose() {
    searchController.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double lottieSize = MediaQuery.of(context).size.width * 0.2;
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
                        controller: searchController,
                        cursorColor: AppTheme.brownColor,
                        decoration: InputDecoration(
                          fillColor: AppTheme.backgroundColor,
                          filled: true,
                          contentPadding: const EdgeInsets.all(0),
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppTheme.greyBackgroundColor,
                              width: 0.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppTheme.greyBackgroundColor,
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
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
                              NavigationServices(context)
                                  .gotoResultScreen(searchController.text);
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
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 1),
                                    IconButton(
                                      onPressed: () {
                                        pickImageFromGallery();
                                      },
                                      icon: const Icon(Iconsax.document_upload),
                                      color:
                                          const Color.fromRGBO(88, 57, 39, 1),
                                      iconSize: 70,
                                    ),
                                    const Padding(padding: EdgeInsets.all(14)),
                                    IconButton(
                                      onPressed: () {
                                        pickImageFromCamera();
                                      },
                                      icon: const Icon(Iconsax.camera),
                                      color:
                                          const Color.fromRGBO(88, 57, 39, 1),
                                      iconSize: 70,
                                    ),
                                    const SizedBox(width: 1),
                                  ],
                                ),
                              );
                            });
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
                        overlayColor: Colors.transparent,
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return AlertDialog(
                            backgroundColor: Colors.transparent,
                            content: Lottie.asset(
                              Localfiles.loading,
                              width: lottieSize,
                            ));
                      }

                      List<DocumentSnapshot<Object?>> dc = snapshot.data!.docs;
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
                                        setState(() {
                                          searchController.text =
                                              data[index]['content'];
                                        });
                                        NavigationServices(context)
                                            .gotoResultScreen(
                                                searchController.text);
                                      },
                                      style: TextButton.styleFrom(
                                        overlayColor: Colors.transparent,
                                      ),
                                      child: Text(
                                        data[index]['content'],
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        SearchHistoryService().removeHistory(
                                            hisID: data[index]['hisID']);
                                      },
                                      icon: const Icon(
                                        Icons.highlight_remove,
                                        color: Color.fromRGBO(88, 57, 39, 1),
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
  }

  initTFlite() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
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
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions;
      searchController.text = _recognitions[0]["label"];
    });
    SearchHistoryService().addHistory(
        hisID: DateTime.now().millisecondsSinceEpoch.toString(),
        content: searchController.text);
    NavigationServices(context).gotoResultScreen(searchController.text);
  }
}
