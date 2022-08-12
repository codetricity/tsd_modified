import 'package:flutter/material.dart';

class HotspotButton extends StatelessWidget {
  const HotspotButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
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
        Container(
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
      ],
    );
  }
}
