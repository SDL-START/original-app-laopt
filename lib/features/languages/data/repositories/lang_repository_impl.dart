import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/features/languages/data/datasources/lang_local_datasource.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/features/languages/domain/repositories/lang_repository.dart';


@LazySingleton(as: LangRepository)
class LangRepositoryImpl implements LangRepository {
  final LangLocalDataSource langLocalDataSource;
  LangRepositoryImpl(this.langLocalDataSource);

  @override
  String? getLanguageCode() {
    try {
      final result = langLocalDataSource.getLangCode();
      return result;
    } on CacheException catch (error) {
      throw CacheFailure(error.msg);
    }
  }
  
  @override
  Future<Either<Failure, bool>> setLanguageCode({required String code})async {
    try {
      final result = await langLocalDataSource.setLangCode(code: code);
      return Right(result);
    } on CacheException catch (error) {
      throw Left(CacheFailure(error.msg));
    }
  }
}
