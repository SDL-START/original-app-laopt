import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/change_password.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../../../../core/models/response_data.dart';
import '../repositories/setting_repository.dart';

@lazySingleton
class ChangePasswordUsecase implements UseCase<ResponseData, ChangePasswordParams> {
  final SettingsRepository settingsRepository;

  ChangePasswordUsecase(this.settingsRepository);

  @override
  Future<Either<Failure, ResponseData>> call(ChangePasswordParams params) async {
    return await settingsRepository.changePassword(
      data: params.data,
      token: params.token,
    );
  }
}

class ChangePasswordParams extends Equatable {
  final ChangePassword data;
  final String token;
  const ChangePasswordParams({
    required this.data,
    required this.token,
  });

  @override
  List<Object?> get props => [data];
}
