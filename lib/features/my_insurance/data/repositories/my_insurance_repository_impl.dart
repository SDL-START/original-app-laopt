import 'package:injectable/injectable.dart';
import 'package:insuranceapp/features/my_insurance/domain/repositories/my_insurance_repository.dart';

@LazySingleton(as: MyInsuranceRepository)
class MyInsuranceRepositoryImpl implements MyInsuranceRepository{

}