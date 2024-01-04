import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment5/presentation/pages/layoutHomeBody.dart';
import 'package:assignment5/presentation/bloc/feedbackBloc.dart';

class LayoutHome extends StatelessWidget {
  const LayoutHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedbackBloc>(
      create: (context) => FeedbackBloc(),
      child: const LayoutHomeBody(),
    );
  }
}