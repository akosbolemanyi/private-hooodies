import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'components/navigation_drawer.dart' as sidebar;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng irinyi = LatLng(46.247063879149174, 20.146901738828014);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const sidebar.NavigationDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 70,
        title: LocaleText(
          'main_map',
          style: GoogleFonts.cabin(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        // backgroundColor: Colors.green.shade200,
      ),
      body: GoogleMap(
          initialCameraPosition: const CameraPosition(
              target: irinyi,
              zoom: 13,
          ),
        markers: {
          const Marker(markerId: MarkerId("_company"), icon: BitmapDescriptor.defaultMarker, position: irinyi),
        }
      ),
    );
  }

}