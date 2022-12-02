import 'dart:async';

import 'package:dovtron/utils/fade_animation.dart';
import 'package:dovtron/utils/system_ui.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 2),
        () => {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false)
            });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    systemUi();
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeAnimation(
          delay: 0,
          child: Text(
            'DOVTRON',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
