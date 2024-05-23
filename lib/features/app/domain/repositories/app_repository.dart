import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/user.dart';

abstract class AppRepository{
  User getLocalUser();
  Future<Either<Failure, void>> setupFlutterNotifications();
  void onMessageStream();
}