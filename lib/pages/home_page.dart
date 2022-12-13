import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dovtron/utils/route_arguments.dart';
import 'package:dovtron/utils/system_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.cameras, super.key});
  final List<CameraDescription> cameras;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraController controller;
  bool isFlash = false;
  bool isFront = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera({isFront = false}) {
    controller =
        CameraController(widget.cameras[isFront ? 1 : 0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        controller.setFlashMode(FlashMode.off);
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            insetPadding: const EdgeInsets.all(24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/corn.jpg'),
                  const Text('Kamu yakin mau nutup aplikasi')
                ]),
            alignment: Alignment.center,
            contentTextStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black45),
            actions: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Color(0xffE6E6E6), width: 1.5)),
                        child: const Center(
                            child: Text(
                          'Stay dulu',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                        // Navigator.of(context).pop(true);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Color(0xffE6E6E6),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Color(0xffE6E6E6), width: 1.5)),
                        child: const Center(
                            child: Text(
                          'Yakin',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    systemUi();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(TablerIcons.arrow_narrow_left,
                    color: Colors.white)),
          ),
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                child: showCamera(context, controller)),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DottedBorder(
                    borderType: BorderType.RRect,
                    color: Colors.white54,
                    radius: const Radius.circular(12),
                    dashPattern: [12, 12],
                    strokeWidth: 3,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            controller.setFlashMode(
                                isFlash ? FlashMode.off : FlashMode.torch);
                            setState(() {
                              isFlash = !isFlash;
                            });
                          },
                          icon: isFlash
                              ? const Icon(
                                  TablerIcons.bolt,
                                  color: Colors.white,
                                )
                              : const Icon(TablerIcons.bolt_off,
                                  color: Colors.white)),
                      GestureDetector(
                        onTap: () async {
                          final image = await controller.takePicture();
                          // ignore: use_build_context_synchronously
                          await Navigator.pushNamed(context, '/detection',
                              arguments: DetectionPageArguments(image));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(48),
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: Container(
                            height: 48,
                            width: 48,
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(48),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.setFlashMode(FlashMode.off);
                            initCamera(isFront: !isFront);
                            setState(() {
                              isFront = !isFront;
                              isFlash = !isFlash;
                            });
                          },
                          icon: const Icon(
                            TablerIcons.refresh,
                            color: Colors.white,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: const EdgeInsets.all(24),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    'ARAHKAN DAUN KE POSISI YANG SESUAI',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  )))
        ]),
      ),
    );
  }
}

Widget showCamera(context, controller) {
  if (!controller.value.isInitialized) {
    return const CupertinoActivityIndicator();
  }
  return CameraPreview(controller);
}
