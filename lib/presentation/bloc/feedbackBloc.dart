import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'feedbackEvent.dart';
import 'feedbackState.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackState(step: 0, messages: [])) {
    on<FeedbackEvent>(_fetchQuestion);
  }

  void _fetchQuestion(FeedbackEvent event, Emitter<FeedbackState> emit) async {
    const apiUrl =
        'https://sapdos-api-v2.azurewebsites.net/api/Credentials/FeedbackJoiningBot';
    final requestBody = {"step": event.step};
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode != 200) {
        if (kDebugMode) {
          print(
              "Failed to fetch question. Status Code: ${response.statusCode}");
        }
        return;
      }

      final String nonJsonResponse = response.body;
      const String messageStart = '"message": "';
      const String messageEnd = '"';

      final int startIndex = nonJsonResponse.indexOf(messageStart);
      final int endIndex =
          nonJsonResponse.indexOf(messageEnd, startIndex + messageStart.length);

      if (startIndex != -1 && endIndex != -1) {
        final String message = nonJsonResponse.substring(
            startIndex + messageStart.length, endIndex);

        emit(FeedbackState(
          step: event.step + 1,
          messages: [...state.messages, message],
        ));
      } else {
        if (kDebugMode) {
          print("Unexpected non-JSON response format: $nonJsonResponse");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during API request: $e");
      }
    }
  }
}
