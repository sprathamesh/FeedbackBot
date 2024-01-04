import 'package:flutter/material.dart';
import 'package:assignment5/presentation/widgets/layout_home.dart';
import 'package:assignment5/presentation/bloc/feedbackBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Bot',
      debugShowCheckedModeBanner: false, //banner removal
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<FeedbackBloc>(
        create: (context) => FeedbackBloc(),
        child: const LayoutHome(),
      ),
    );
  }
}
