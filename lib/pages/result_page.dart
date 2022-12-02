import 'package:dovtron/utils/fade_animation.dart';
import 'package:dovtron/utils/system_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
      body: ListView(
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
                    width: MediaQuery.of(context).size.height * 0.6 * 0.6,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 16,
                            color: Colors.black26.withAlpha(48),
                            spreadRadius: 0,
                            offset: const Offset(0, 8))
                      ],
                      image: DecorationImage(
                          image: AssetImage('assets/images/${index + 1}.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ),
          const FadeAnimation(
            delay: 200,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('Hawar Daun',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800)),
            ),
          ),
          FadeAnimation(
            delay: 200,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, left: 24, right: 24, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Penyebab',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Et sunt anim dolore anim magna amet nostrud excepteur. Dolore cupidatat dolor velit id. Nisi ea et minim amet laborum esse aliqua. Excepteur esse nostrud ut dolor dolore cupidatat ea est. Proident nostrud duis laboris aliqua adipisicing ut labore exercitation labore. Nisi duis aute in eu incididunt ea eiusmod enim laborum adipisicing. Sunt sunt laboris tempor culpa adipisicing. Nostrud et aliqua aute aliqua. Ad cupidatat cupidatat cillum quis officia magna commodo reprehenderit est qui. Aute adipisicing dolore sunt aliqua et Lorem deserunt Lorem in id eu nulla occaecat laborum. Officia eu sint eiusmod exercitation esse dolor non cupidatat cillum nulla sint sunt amet.',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 2,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Perawatan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Et sunt anim dolore anim magna amet nostrud excepteur. Dolore cupidatat dolor velit id. Nisi ea et minim amet laborum esse aliqua. Excepteur esse nostrud ut dolor dolore cupidatat ea est. Proident nostrud duis laboris aliqua adipisicing ut labore exercitation labore. Nisi duis aute in eu incididunt ea eiusmod enim laborum adipisicing. Sunt sunt laboris tempor culpa adipisicing. Nostrud et aliqua aute aliqua. Ad cupidatat cupidatat cillum quis officia magna commodo reprehenderit est qui. Aute adipisicing dolore sunt aliqua et Lorem deserunt Lorem in id eu nulla occaecat laborum. Officia eu sint eiusmod exercitation esse dolor non cupidatat cillum nulla sint sunt amet.',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 2,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Pencegahan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Et sunt anim dolore anim magna amet nostrud excepteur. Dolore cupidatat dolor velit id. Nisi ea et minim amet laborum esse aliqua. Excepteur esse nostrud ut dolor dolore cupidatat ea est. Proident nostrud duis laboris aliqua adipisicing ut labore exercitation labore. Nisi duis aute in eu incididunt ea eiusmod enim laborum adipisicing. Sunt sunt laboris tempor culpa adipisicing. Nostrud et aliqua aute aliqua. Ad cupidatat cupidatat cillum quis officia magna commodo reprehenderit est qui. Aute adipisicing dolore sunt aliqua et Lorem deserunt Lorem in id eu nulla occaecat laborum. Officia eu sint eiusmod exercitation esse dolor non cupidatat cillum nulla sint sunt amet.',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 2,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(24),
          //   child: DefaultTabController(
          //       length: 3,
          //       child: Column(children: [
          //         TabBar(
          //           physics: const BouncingScrollPhysics(),
          //           controller: _tabController,
          //           labelColor: Colors.white,
          //           unselectedLabelColor: Colors.grey,
          //           indicatorColor: Colors.black,
          //           labelPadding:
          //               const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          //           indicatorSize: TabBarIndicatorSize.tab,
          //           labelStyle: const TextStyle(
          //               fontWeight: FontWeight.w500, fontSize: 14),
          //           unselectedLabelStyle: const TextStyle(
          //               fontWeight: FontWeight.w500, fontSize: 14),
          //           tabs: const [
          //             Text(
          //               'Penyebab',
          //             ),
          //             Text(
          //               'Perawatan',
          //             ),
          //             Text(
          //               'Pencegahan',
          //             ),
          //           ],
          //           indicator: ShapeDecoration(
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(6)),
          //               color: Colors.blue),
          //         ),
          //         // Expanded(
          //         //   child: TabBarView(children: [
          //         //     Text('1'),
          //         //     Text('2'),
          //         //     Text('3'),
          //         //   ]),
          //         // ),
          //       ])),
          // ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
