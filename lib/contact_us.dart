import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/navigation_drawer.dart' as sidebar;

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const sidebar.NavigationDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: LocaleText(
          'menu_contact_us',
          style: GoogleFonts.cabin(
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        // backgroundColor: Colors.indigo.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: LocaleText(
                'contact_motto',
                textAlign: TextAlign.center,
                style: GoogleFonts.cabin(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            LocaleText(
              'contact_phone',
              textAlign: TextAlign.left,
              style: GoogleFonts.tinos(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: LocaleText(
                'contact_phone_num',
                textAlign: TextAlign.left,
                style: GoogleFonts.tinos(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            LocaleText(
              'contact_mobile',
              textAlign: TextAlign.left,
              style: GoogleFonts.tinos(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            LocaleText(
              'contact_mobile_num',
              textAlign: TextAlign.left,
              style: GoogleFonts.tinos(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            Divider(),
            LocaleText(
              'contact_email',
              textAlign: TextAlign.left,
              style: GoogleFonts.tinos(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            LocaleText(
              'contact_email_str',
              textAlign: TextAlign.left,
              style: GoogleFonts.tinos(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
