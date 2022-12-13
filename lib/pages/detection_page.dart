import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:dovtron/utils/fade_animation.dart';
import 'package:dovtron/utils/route_arguments.dart';
import 'package:dovtron/utils/system_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:http/http.dart' as http;

class DetectionPage extends StatefulWidget {
  final XFile image;
  const DetectionPage({super.key, required this.image});

  @override
  State<DetectionPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<DetectionPage> {
  bool isDetected = false;
  bool isErrorUpload = false;
  String predictions = 'Normal';

  @override
  void initState() {
    super.initState();
    uploadImage();
  }

  Future<void> uploadImage() async {
    setState(() {
      isDetected = false;
      isErrorUpload = false;
    });
    var url = "https://dovtronmodelpy-f4thffsvra-et.a.run.app/api/predict";
    try {
      var formData = FormData.fromMap({
        'name': 'wendux',
        'age': 25,
        'image': await MultipartFile.fromFile(widget.image.path,
            filename: 'images.txt'),
      });
      var response = await Dio().post(url, data: formData);
      if (response.data['success']) {
        setState(() {
          isDetected = true;
          isErrorUpload = false;
          predictions = response.data['predictions'];
        });
      } else {
        setState(() {
          isDetected = true;
          isErrorUpload = true;
        });
      }
    } catch (e) {
      setState(() {
        isDetected = true;
        isErrorUpload = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    systemUi();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Proses Deteksi',
          style: TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              TablerIcons.arrow_narrow_left,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Stack(children: [
        FadeAnimation(
          delay: 0,
          isHorizontal: true,
          child: Center(
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: Container(
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: FileImage(File(widget.image.path)),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: FadeAnimation(
              delay: 200,
              child: GestureDetector(
                onTap: () {
                  if (predictions.toUpperCase() != 'DAUN SEHAT') {
                    if (isDetected && !isErrorUpload) {
                      Navigator.pushNamed(context, '/result',
                          arguments: DiseasePageArguments(predictions));
                    } else if (isDetected && isErrorUpload) {
                      uploadImage();
                    }
                  }
                },
                child: Container(
                    margin: const EdgeInsets.all(24),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: isErrorUpload ? Colors.red : Colors.black87,
                        borderRadius: BorderRadius.circular(8)),
                    child: isDetected && !isErrorUpload
                        ? Stack(
                            children: [
                              Center(
                                child: Text(
                                  predictions.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 8, top: 4, left: 8, right: 8),
                                      child: Icon(
                                        TablerIcons.arrow_narrow_right,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : !isDetected
                            ? const Center(
                                child: Text(
                                  'SEDANG MENDETEKSI',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  uploadImage();
                                },
                                child: const Center(
                                  child: Text(
                                    'ULANGI DETEKSI',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
              ),
            )),
        !isDetected
            ? Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: const CupertinoActivityIndicator(),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ]),
    );
  }
}
