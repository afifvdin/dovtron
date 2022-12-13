import 'package:dovtron/providers/google_sign_in_provider.dart';
import 'package:dovtron/utils/fade_animation.dart';
import 'package:dovtron/utils/system_ui.dart';
import 'package:dovtron/widgets/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    systemUi();
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(TablerIcons.square_x, color: Colors.black)),
          ),
          actions: [
            StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                          icon: const Icon(TablerIcons.settings,
                              color: Colors.black)),
                    );
                  } else {
                    return const SizedBox();
                  }
                })
          ],
          elevation: 0,
        ),
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              } else if (snapshot.hasData) {
                return const WelcomeWidget(loggedIn: true);
              } else {
                return const WelcomeWidget(
                  loggedIn: false,
                );
              }
            }));
  }
}

class WelcomeWidget extends StatefulWidget {
  final bool loggedIn;
  const WelcomeWidget({Key? key, required this.loggedIn}) : super(key: key);

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const FadeAnimation(
            delay: 0,
            child: Text(
              'Dovtron',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const FadeAnimation(
            delay: 200,
            child: Text(
              'Selamat datang di dovtron!',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black45,
                  fontSize: 14),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          FadeAnimation(
              delay: 200,
              child: Image.asset('assets/images/corn.jpg', fit: BoxFit.cover)),
          const SizedBox(
            height: 24,
          ),
          widget.loggedIn
              ? FadeAnimation(
                  delay: 400,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Button(
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Masuk kedalam Deteksi',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                          Icon(
                            TablerIcons.arrow_narrow_right,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : FadeAnimation(
                  delay: 400,
                  child: GestureDetector(
                    onTap: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                    },
                    child: Button(
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Image.asset(
                                  'assets/images/google_logo.webp',
                                  fit: BoxFit.cover)),
                          const Text(
                            'Lanjutkan dengan Google',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
