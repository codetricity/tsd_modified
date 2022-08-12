import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panorama/panorama.dart';
import 'package:take_save_display_12/blocs/panorama/panorama_bloc.dart';
import 'package:take_save_display_12/blocs/theta/theta_bloc.dart';
import 'package:take_save_display_12/panorama_network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThetaBloc>(
          create: (context) => ThetaBloc(),
        ),
        BlocProvider<PanoramaBloc>(
          create: (context) => PanoramaBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        home: BlocBuilder<ThetaBloc, ThetaState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black54,
                  title: const Text("THETA TSD"),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (state.finishedSaving ||
                                state.cameraState == 'initial') {
                              context.read<ThetaBloc>().add(PictureEvent());
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Wait for Process to Complete'),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.amber,
                          ),
                          iconSize: 80,
                        ),
                      ],
                    ),
                    state.cameraState == 'inProgress' && state.fileUrl.isEmpty
                        ? Column(
                            children: const [
                              CircularProgressIndicator(),
                              Text('Processing Photo'),
                            ],
                          )
                        : state.cameraState == 'done' &&
                                state.finishedSaving != true
                            ? Column(
                                children: const [
                                  CircularProgressIndicator(),
                                  Text('Saving to Gallery'),
                                ],
                              )
                            : Container(),
                    IconButton(
                        onPressed: () async {
                          final thetaBlocContext = context.read<ThetaBloc>();
                          final image = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );
                          if (image == null) return;
                          thetaBlocContext.add(ImagePickerEvent(image));
                        },
                        icon: const Icon(Icons.image)),
                    state.images != null
                        ? ImageWidget(myFile: File(state.images!.path))
                        : Container()
                  ],
                ));
          },
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final File myFile;
  const ImageWidget({Key? key, required this.myFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PanoramaWidget(myFile: myFile)));
            },
            child: Image.file(myFile)),
        const Icon(
          Icons.circle,
          color: Colors.black12,
          size: 65,
        ),
        InkWell(
          child: const Icon(
            Icons.threesixty,
            color: Colors.white,
            size: 50,
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PanoramaWidget(myFile: myFile),
            ),
          ),
        )
      ],
    );
  }
}

class PanoramaWidget extends StatelessWidget {
  final File myFile;
  const PanoramaWidget({Key? key, required this.myFile}) : super(key: key);
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
                  style: const TextStyle(color: Colors.white, fontSize: 30),
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
        child: Panorama(
          // animSpeed: 1.0,
          // sensorControl: SensorControl.Orientation,
          hotspots: [
            Hotspot(
              name: 'next scene',
              latitude: -33.0,
              longitude: 123.0,
              width: 260.0,
              height: 260.0,
              widget: hotspotButton(
                  text: 'next scene',
                  icon: Icons.arrow_upward,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PanoramaNetwork()));
                  }),
            ),
          ],
          // animSpeed: 1.0,
          // sensorControl: SensorControl.Orientation,
          child: Image.file(myFile),
        ),
      ),
    );
  }
}
