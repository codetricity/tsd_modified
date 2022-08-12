import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_save_display_12/blocs/panorama/panorama_bloc.dart';
import 'package:take_save_display_12/blocs/theta/theta_bloc.dart';
import 'package:take_save_display_12/view/home_screen.dart';

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
                body: const HomeScreen());
          },
        ),
      ),
    );
  }
}
