import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/models/location_log.dart';

import '../../../../core/usecases/usecase_sync.dart';
import '../repositories/support_repository.dart';

@lazySingleton
class GetLiveLocationUsecase
    implements SynchronousUseCase<Stream<LocationLog>, GetLiveLocationParams> {
  final SupportRepository _repository;

  GetLiveLocationUsecase(this._repository);

  @override
  Stream<LocationLog> call(GetLiveLocationParams params) {
    return _repository.getLiveLocation(params.controller, params.messageId);
  }
}

class GetLiveLocationParams extends Equatable {
  final StreamController<LocationLog> controller;
  final int? messageId;

  const GetLiveLocationParams(this.controller, this.messageId);
  @override
  List<Object?> get props => [];
}
