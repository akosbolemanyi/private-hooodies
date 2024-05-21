import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';

class HoodieItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final void Function()? onPressed;


  const HoodieItemTile({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    final nation = Locales.currentLocale(context)?.languageCode;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          itemName,
          style: GoogleFonts.lobster(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Image.asset(
          imagePath,
          height: 310,
        ),
        MaterialButton(
          onPressed: onPressed,
          color: Colors.grey[800],
          child: Text(
            nation == 'hu' ? '$itemPrice Ft' : nation == 'en' ? '\$$itemPrice' : '\€ $itemPrice',
            style: GoogleFonts.cabin(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
