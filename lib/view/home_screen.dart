import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:take_save_display_12/blocs/theta/theta_bloc.dart';
import 'package:take_save_display_12/view/image_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThetaBloc, ThetaState>(
      builder: (context, state) {
        return Column(
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
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                : state.cameraState == 'done' && state.finishedSaving != true
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
        );
      },
    );
  }
}
