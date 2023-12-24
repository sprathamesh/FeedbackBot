import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/feedbackBloc.dart';
import '../../bloc/feedbackEvent.dart';
import '../../bloc/feedbackState.dart';

class MobileLayoutHome extends StatefulWidget {
  const MobileLayoutHome({super.key});

  @override
  State<MobileLayoutHome> createState() => _MobileLayoutHomeState();
}

class _MobileLayoutHomeState extends State<MobileLayoutHome> {
  final TextEditingController _textController = TextEditingController();
  List<String> submittedMessages = [];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;//width of screen

    return Scaffold(
      appBar: _buildAppBar(width),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildBody(),
    );
  }

//AppBar
  PreferredSizeWidget _buildAppBar(double width) {//customize size
    return PreferredSize(
      preferredSize: Size(width, 75),
      child: Container(
        margin: const EdgeInsets.only(top: 25),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome To CentraLogic!',
                style: GoogleFonts.roboto(
                  color: const Color.fromRGBO(12, 15, 36, 1),
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              Text(
                'Hi Charles!',
                style: GoogleFonts.roboto(
                  color: const Color.fromRGBO(12, 15, 36, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(),
            const SizedBox(width: 8),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return SizedBox(
      width: 250,
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          hintText: 'Type your message',
          hintStyle: GoogleFonts.roboto(color: Colors.black),
          prefixIcon: Image.asset('assets/pin.png'),
          filled: true,
          fillColor: const Color.fromRGBO(231, 231, 233, 1),
          contentPadding: const EdgeInsets.all(10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.black),
        maxLines: 1,//max line to show in textfield
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: 80,
      height: 45,
      child: TextButton(
        onPressed: () => _submitMessage(),
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromRGBO(27, 72, 155, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        child: Text(
          'Submit',
          style: GoogleFonts.roboto(
            color: const Color.fromRGBO(255, 255, 255, 1),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _submitMessage() {
    setState(() {//to update state after changes
      submittedMessages.add(_textController.text);
    });
    if (_textController.text.isNotEmpty) {
      final int step = int.tryParse(_textController.text) ?? 0;//if fail 0
      context.read<FeedbackBloc>().add(FeedbackEvent(step: step));//triger state changes
    }
    _textController.clear();//clear txt field
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildLogoAndDescription(),
          _buildTodayContainer(),
          BlocBuilder<FeedbackBloc, FeedbackState>(
            builder: (context, state) {
              return _buildFeedbackMessages(state);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogoAndDescription() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
          child: Image.asset(
            'assets/logo.png',
            width: 64,
            height: 64,
          ),
        ),
        Text(
          'CentraLogic Bot',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        Text(
          'Hi! I am CentraLogic Bot, your onboarding agent',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildTodayContainer() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(233, 236, 244, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "Today",
          style: GoogleFonts.roboto(
            color: const Color.fromRGBO(12, 15, 36, 1),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackMessages(FeedbackState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
      child: Column(
        children: [
          _buildMessageRow(//defualt msg 
            'Hi Welcome to CentraLogic Feedback Agent! Thank you for your interest in CentraLogic!',
          ),
          const SizedBox(height: 10.0),
          _buildMessageRow(
            'What were the most valuable aspects of the Flutter training for you ?',
          ),
          const SizedBox(height: 10.0),
          _buildMessageList(state),
        ],
      ),
    );
  }

  Widget _buildMessageRow(String message) {
    return Row(
      children: [
        Image.asset(
          'assets/logo.png',
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 10),
        Container(
          width: 250,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(233, 236, 244, 1),
            borderRadius: BorderRadius.circular(8),
          ),
                    child: Text(
            message,
            style: GoogleFonts.roboto(
              color: const Color.fromRGBO(12, 15, 36, 1),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageList(FeedbackState state) {
    return ListView.builder(
      itemCount: state.messages.length + submittedMessages.length,
      itemBuilder: (context, index) {
        if (index % 2 == 0) {
          final submittedIndex = index ~/ 2;
          return Align(
            alignment: Alignment.centerRight,
            child: _buildSubmittedMessageContainer(
              submittedMessages[submittedIndex],
            ),
          );
        } else {
          final receivedIndex = index ~/ 2;//interger divison 
          return Align(
            alignment: Alignment.centerLeft,
            child: _buildReceivedMessageContainer(
              state.messages[receivedIndex],
            ),
          );
        }
      },
    );
  }

  Widget _buildSubmittedMessageContainer(String message) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(233, 236, 244, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: GoogleFonts.roboto(
          color: const Color.fromRGBO(12, 15, 36, 1),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildReceivedMessageContainer(String message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            'assets/logo.png',
            width: 30,
            height: 30,
          ),
          const SizedBox(width: 10),
          Container(
            width: 250,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(233, 236, 244, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: GoogleFonts.roboto(
                color: const Color.fromRGBO(12, 15, 36, 1),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


