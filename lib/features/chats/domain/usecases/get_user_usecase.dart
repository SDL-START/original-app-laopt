import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/chats/domain/repositories/chat_repository.dart';

@lazySingleton
class GetUserByIdUsecase implements UseCase<User,int>{
  final ChatRepository _chatRepository;

  GetUserByIdUsecase(this._chatRepository);

  @override
  Future<Either<Failure, User>> call(int params)async {
    return await _chatRepository.getUserById(id: params);
  }
}