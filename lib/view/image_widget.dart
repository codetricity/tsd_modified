import 'dart:io';

import 'package:flutter/material.dart';
import 'package:take_save_display_12/view/panorama_widget.dart';

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
