import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panorama/panorama.dart';
import 'package:take_save_display_12/blocs/panorama/panorama_bloc.dart';
import 'package:take_save_display_12/view/hotspot_button.dart';

import '../data/urls.dart' as data;

class PanoramaNetwork extends StatelessWidget {
  const PanoramaNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocBuilder<PanoramaBloc, PanoramaState>(
          builder: (context, state) {
            return Panorama(
                animSpeed: 1.0,
                // sensorControl: SensorControl.Orientation,
                hotspots: [
                  Hotspot(
                    name: 'explore',
                    latitude: -33.0,
                    longitude: 123.0,
                    width: 300.0,
                    height: 300.0,
                    widget: HotspotButton(
                        text: 'explore',
                        icon: Icons.arrow_upward,
                        onPressed: () {
                          if (state.urlIndex < data.urls.length - 1) {
                            context
                                .read<PanoramaBloc>()
                                .add(IncrementPanoramaEvent());
                          } else {
                            context
                                .read<PanoramaBloc>()
                                .add(ZeroPanoramaEvent());
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PanoramaNetwork()));
                        }),
                  ),
                ],
                // animSpeed: 1.0,
                // sensorControl: SensorControl.Orientation,
                child: Image(
                  image: CachedNetworkImageProvider(data.urls[state.urlIndex]),
                ));
          },
        ),
      ),
    );
  }
}
