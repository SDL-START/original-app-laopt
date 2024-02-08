import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/features/app/domain/repositories/app_repository.dart';
import '../../../../core/DI/service_locator.dart';
import '../datasources/app_local_datasource.dart';
import '../datasources/app_remote_datasource.dart';

@LazySingleton(as: AppRepository)
class AppRepositoryImpl implements AppRepository {
  final AppLocalDataSource _appLocalDataSource;
  final AppRemoteDatasource _appRemoteDatasource;
  AppRepositoryImpl(this._appLocalDataSource, this._appRemoteDatasource);

  @override
  User getLocalUser() {
    try {
      final user = _appLocalDataSource.getLocalUser();
      return user;
    } on CacheException catch (e) {
      throw CacheFailure(e.msg);
    }
  }

  @override
  Future<Either<Failure, void>> setupFlutterNotifications() async {
    try {
      return Right(await _appRemoteDatasource.setupFlutterNotifications((message)async{
        await firebaseMessagingBackgroundHandler(message);
      }));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  void onMessageStream() {
    _appRemoteDatasource.onMessageStream().listen((message) async {
      bool? isAuth = await _appRemoteDatasource.isAuthorized();
      if (isAuth == true) {
        _appRemoteDatasource.showNotification(message);
      }
    });
  }
}
