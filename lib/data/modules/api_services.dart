import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:assignment5/domain/entities/feedback_entity.dart';
import 'package:assignment5/domain/exception/feedback_exception.dart';
import 'package:assignment5/domain/failures/feedback_failures.dart';

class ApiService {
  static const String apiUrl =
      'https://sapdos-api-v2.azurewebsites.net/api/Credentials/FeedbackJoiningBot';

  static Future<FeedbackEntity> fetchQuestion(int step) async {
    final requestBody = {"step": step};
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final String nonJsonResponse = response.body;
        const String messageStart = '"message": "';
        const String messageEnd = '"';
        final int startIndex = nonJsonResponse.indexOf(messageStart);
        final int endIndex =
            nonJsonResponse.indexOf(messageEnd, startIndex + messageStart.length);

        if (startIndex != -1 && endIndex != -1) {
          final message = nonJsonResponse.substring(
            startIndex + messageStart.length,
            endIndex,
          );
          return FeedbackEntity(step: step + 1, messages: [message]);
        } else {
          throw FeedbackException(FeedbackFailures.unexpectedFormat);
        }
      } else {
        throw FeedbackException("Failed to fetch question. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw FeedbackException(e.toString());
    }
  }
}