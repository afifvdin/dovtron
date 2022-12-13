import 'package:dio/dio.dart';
import 'package:dovtron/utils/fade_animation.dart';
import 'package:dovtron/utils/system_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class ResultPage extends StatefulWidget {
  final String name;
  const ResultPage({super.key, required this.name});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> bercak_daun = [
    'https://raw.githubusercontent.com/adimasmudi/dovtron_image/new/Bercak-Daun/bercak1.jpg',
    'https://raw.githubusercontent.com/adimasmudi/dovtron_image/new/Bercak-Daun/bercak2.jpg',
    'https://raw.githubusercontent.com/adimasmudi/dovtron_image/new/Bercak-Daun/bercak3.png',
    'https://raw.githubusercontent.com/adimasmudi/dovtron_image/new/Bercak-Daun/bercak4.jpg',
  ];
  List<String> karat_daun = [
    'https://raw.githubusercontent.com/adimasmudi/dovtron_image/new/Karat-Daun/karat1.jpg',
    'https://raw.githubusercontent.com/adimasmudi/dovtron_image/new/Karat-Daun/karat2.jpg',
    'https://raw.githubusercontent.com/adimasmudi/dovtron_image/new/Karat-Daun/karat3.jpg',
    'https://raw.githubusercontent.com/adimasmudi/dovtron_image/new/Karat-Daun/karat4.jpg',
  ];
  List<String> hawar_daun = [
    'https://raw.githubusercontent.com/adimasmudi/dovtron_image/new/Hawar-Daun/hawar1.jpg',
    'https://raw.githubusercontent.com/adimasmudi/dovtron_image/new/Hawar-Daun/hawar2.jpg',
    'https://raw.githubusercontent.com/adimasmudi/dovtron_image/new/Hawar-Daun/Hawar3.jpg',
    'https://raw.githubusercontent.com/adimasmudi/dovtron_image/new/Hawar-Daun/hawar4.png',
  ];
  bool isLoading = true;
  String penyebab = '';
  String gejala = '';
  String pengendalian = '';

  Future<void> getDiseaseDesc() async {
    String firstName = widget.name.split(' ')[0];
    String lastName = widget.name.split(' ')[1];
    var url =
        "https://us-central1-dovtronapi.cloudfunctions.net/app/api/getDesease/${firstName}-${lastName}";
    print(url);
    try {
      var response = await Dio().get(url);
      print(response.data);
      setState(() {
        penyebab = response.data['penyebab'];
        gejala = response.data['gejala'];
        pengendalian = response.data['pengendalian'];
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    getDiseaseDesc();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    systemUi();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Hasil Deteksi',
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: IconButton(
              onPressed: () {
                Navigator.popUntil(
                    context, (route) => route.settings.name == '/');
              },
              icon: const Icon(
                TablerIcons.arrow_narrow_left,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return FadeAnimation(
                          isHorizontal: true,
                          delay: 200,
                          child: Container(
                            margin: EdgeInsets.only(
                              left: index == 0 ? 24 : 12,
                              right: 12,
                            ),
                            height: double.infinity,
                            width:
                                MediaQuery.of(context).size.height * 0.6 * 0.6,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 16,
                                    color: Colors.black26.withAlpha(48),
                                    spreadRadius: 0,
                                    offset: const Offset(0, 8))
                              ],
                              image: DecorationImage(
                                  image:
                                      NetworkImage(widget.name == 'Bercak Daun'
                                          ? bercak_daun[index]
                                          : widget.name == 'Karat Daun'
                                              ? karat_daun[index]
                                              : hawar_daun[index]),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  FadeAnimation(
                    delay: 200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(widget.name,
                          style: const TextStyle(
                              fontSize: 36, fontWeight: FontWeight.w800)),
                    ),
                  ),
                  FadeAnimation(
                    delay: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12, left: 24, right: 24, bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Penyebab',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            penyebab,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2,
                                color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            'Gejala',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            gejala,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2,
                                color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            'Pengendalian',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            pengendalian,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 2,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ));
  }
}
