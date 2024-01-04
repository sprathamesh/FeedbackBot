import 'package:dartz/dartz.dart';
import 'package:assignment5/domain/entities/feedback_entity.dart';
import 'package:assignment5/domain/exception/feedback_exception.dart';
//import 'package:assignment5/domain/failures/feedback_failures.dart';

abstract class FeedbackRepository {
  Future<Either<FeedbackException, FeedbackEntity>> fetchQuestion(int step);
}
