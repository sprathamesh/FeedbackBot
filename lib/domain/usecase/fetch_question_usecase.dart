import 'package:dartz/dartz.dart';
import 'package:assignment5/domain/entities/feedback_entity.dart';
import 'package:assignment5/domain/repositories/feedback_repository.dart';
import 'package:assignment5/domain/exception/feedback_exception.dart';

class FetchQuestionUsecase {
  final FeedbackRepository repository;

  FetchQuestionUsecase(this.repository);

  Future<Either<FeedbackException, FeedbackEntity>> execute(int step) async {
    try {
      final messageEither = await repository.fetchQuestion(step);
      return messageEither;
    } catch (e) {
      return Left(FeedbackException(e.toString()));
    }
  }
}
