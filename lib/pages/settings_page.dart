import 'package:dovtron/providers/google_sign_in_provider.dart';
import 'package:dovtron/utils/fade_animation.dart';
import 'package:dovtron/utils/system_ui.dart';
import 'package:dovtron/widgets/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    systemUi();
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Settings',
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
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeAnimation(
                  delay: 0,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: NetworkImage(user.photoURL!),
                            fit: BoxFit.cover)),
                  )),
              const SizedBox(
                height: 24,
              ),
              const FadeAnimation(
                delay: 200,
                child: Text(
                  'Dovtron',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              FadeAnimation(
                delay: 200,
                child: Text(
                  user.displayName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black45,
                      fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              FadeAnimation(
                delay: 400,
                child: GestureDetector(
                  onTap: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.logout();
                    Navigator.pop(context);
                  },
                  child: const Button(
                    color: Colors.red,
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
