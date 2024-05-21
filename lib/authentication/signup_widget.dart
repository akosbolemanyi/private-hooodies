import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/theme_select.dart';
import 'login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import '../image_handler/user_image.dart';
import '../components/language_select.dart';
import 'utils.dart';

  class SignUpWidget extends StatefulWidget {
    final VoidCallback onClickedSignIn;

    const SignUpWidget({
      Key? key,
      required this.onClickedSignIn,
  }) : super(key: key);

    @override
    _SignUpWidgetState createState() => _SignUpWidgetState();
  }

  class _SignUpWidgetState extends State<SignUpWidget> {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    String imageUrl = '';

    @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();

      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      final nation = Locales.currentLocale(context)?.languageCode;

      return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //----------------------------------------------------------------------------------------------------
                const SizedBox(height: 130),
                Text(
                  "Hooodies!",
                  style: GoogleFonts.lobster(
                      fontSize: 50,
                      color: Colors.red

                  ),
                ),
                LocaleText(
                  'sign_up_motto',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cabin(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                //----------------------------------------------------------------------------------------------------
                const SizedBox(height: 40),
                LocaleText(
                  'email',
                  style: GoogleFonts.cabin(
                      color: Colors.grey.shade500,
                      fontSize: 15
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                  (email != null && !EmailValidator.validate(email) && nation == 'hu')
                      ? "Érvényes e-mail címet adjon meg" :
                  (email != null && !EmailValidator.validate(email) && nation == 'en')
                      ? "Enter a valid email" :
                  (email != null && !EmailValidator.validate(email) && nation == 'de')
                      ? "Geben Sie eine gültige E-Mail-Adresse ein"
                      : null,
                ),
                const SizedBox(height: 30),
                LocaleText(
                  'password',
                  style: GoogleFonts.cabin(
                      color: Colors.grey.shade500,
                      fontSize: 15
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                  (value != null && !EmailValidator.validate(value) && nation == 'hu' && value.length < 6)
                      ? "Adjon meg minimum 6 karaktert" :
                  (value != null && !EmailValidator.validate(value) && nation == 'en' && value.length < 6)
                      ? "Enter minimum 6 characters" :
                  (value != null && !EmailValidator.validate(value) && nation == 'de' && value.length < 6)
                      ? "Geben Sie mindestens 6 Zeichen ein"
                      : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(Icons.lock_open, size: 32, color: Colors.black),
                  label: LocaleText(
                    'sign_up',
                    style: GoogleFonts.cabin(
                        fontSize: 24,
                        color: Colors.black
                    ),
                  ),
                  onPressed: signUp,
                ),
                const SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                      style: GoogleFonts.cabin(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 15
                      ),
                      text: nation == 'hu' ? "Van már fiókod?  "
                          : nation == 'en' ? "Already have an account?  "
                          : "Hast du schon ein Konto?  ",
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignIn,
                            text: nation == 'hu' ? "Bejelentkezés"
                                : nation == 'en' ? "Sign in"
                                : "Anmeldung",
                            style: GoogleFonts.cabin(
                                decoration: TextDecoration.underline,
                                color: Colors.purple
                            )
                        )
                      ]

                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: "btn1",
                backgroundColor: Colors.red.shade400,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SettingScreen()));
                },
                child: const Icon(
                  Icons.language_rounded,
                ),
              ),
              Expanded(child: Container()),
              FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Colors.red.shade400,
                onPressed: () => {Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ThemePage()))
                },
                child: const Icon(
                  Icons.lightbulb_outline,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Future signUp() async {
      final isValid = formKey.currentState!.validate();
      if (!isValid) return;

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator())
      );

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim()
        );

        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).set({
          'email': emailController.text.trim(),
          'imageUrl': this.imageUrl
        });
      } on FirebaseAuthException catch (e) {
        if (kDebugMode) {
          print(e);
        }

        Utils.showSnackBar(e.message);
      }
      // Navigator.of(context) now working!
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
