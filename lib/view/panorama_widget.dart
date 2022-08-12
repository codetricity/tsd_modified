import 'dart:io';

import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:take_save_display_12/view/hotspot_button.dart';
import 'package:take_save_display_12/view/panorama_network.dart';

class PanoramaWidget extends StatelessWidget {
  final File myFile;
  const PanoramaWidget({Key? key, required this.myFile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Panorama(
          // sensorControl: SensorControl.Orientation,
          hotspots: [
            Hotspot(
              name: 'next scene',
              latitude: -33.0,
              longitude: 123.0,
              width: 300.0,
              height: 300.0,
              widget: HotspotButton(
                  text: 'explore',
                  icon: Icons.arrow_upward,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PanoramaNetwork()));
                  }),
            ),
          ],
          animSpeed: 1.0,
          child: Image.file(myFile),
        ),
      ),
    );
  }
}
