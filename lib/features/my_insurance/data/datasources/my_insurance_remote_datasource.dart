import 'package:injectable/injectable.dart';

abstract class MyInsuranceRemoteDatasource{

}

@LazySingleton(as: MyInsuranceRemoteDatasource)
class MyInsuranceRemoteDatasourceImpl implements MyInsuranceRemoteDatasource{

}