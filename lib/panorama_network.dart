import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panorama/panorama.dart';
import 'package:take_save_display_12/blocs/panorama/panorama_bloc.dart';

class PanoramaNetwork extends StatelessWidget {
  PanoramaNetwork({Key? key}) : super(key: key);

  final List<String> urls = [
    "https://gallery.theta360.guide/media/images/lakemore_retreat_smaller.jpg",
    "https://gallery.theta360.guide/media/images/Jason-Sievers-Funky-Taco_smaller.jpg",
    "https://gallery.theta360.guide/media/images/R0010599_fb.jpg",
    "https://gallery.theta360.guide/media/images/chao_huang.jpg",
    "https://gallery.theta360.guide/media/images/R0010181-fb.jpg",
    "https://gallery.theta360.guide/media/images/R0010176-fb.jpg",
    "https://gallery.theta360.guide/media/images/reef.jpg",
    "https://gallery.theta360.guide/media/images/kai-moorea4_iKnUMV7.webp",
    "https://gallery.theta360.guide/media/images/kai-moorea-scuba-sand.webp",
    "https://gallery.theta360.guide/media/images/toyo-autumn-40-percent_jEOw4iE.jpg",
  ];

  Widget hotspotButton(
      {String? text, IconData? icon, VoidCallback? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const CircleBorder()),
            backgroundColor: MaterialStateProperty.all(Colors.black38),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: onPressed,
          child: Icon(
            icon,
            size: 200,
          ),
        ),
        text != null
            ? Container(
                padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(
                    child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 36),
                )),
              )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocBuilder<PanoramaBloc, PanoramaState>(
          builder: (context, state) {
            return Panorama(
                // animSpeed: 1.0,
                // sensorControl: SensorControl.Orientation,
                hotspots: [
                  Hotspot(
                    name: 'explore',
                    latitude: -33.0,
                    longitude: 123.0,
                    width: 300.0,
                    height: 300.0,
                    widget: hotspotButton(
                        text: 'explore',
                        icon: Icons.arrow_upward,
                        onPressed: () {
                          if (state.urlIndex < urls.length - 1) {
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
                  image: CachedNetworkImageProvider(urls[state.urlIndex]),
                )
                // Image.network(urls[state.urlIndex])
                );
          },
        ),
      ),
    );
  }
}
