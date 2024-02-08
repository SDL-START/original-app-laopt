// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:insuranceapp/core/error/exceptions.dart';
// import 'package:insuranceapp/core/network/network_call.dart';
// import 'package:insuranceapp/core/network/network_info.dart';
// import 'package:insuranceapp/features/languages/data/models/languages_model.dart';

// import '../../../../core/services/database_sevice.dart';

// abstract class LangRemoteDataSource {
//   Future<List<LanguagesModel>>getLangauge();
// }

// @LazySingleton(as: LangRemoteDataSource)
// class LageRemoteDataSourceImpl implements LangRemoteDataSource{
//   final NetworkCall networkCall;
//   final NetworkInfo networkInfo;
//   final DatabaseService databaseService;

//   LageRemoteDataSourceImpl(this.networkCall, this.networkInfo, this.databaseService);
//   @override
//   Future<List<LanguagesModel>> getLangauge()async {
//     try{
//       final res =  await networkCall.getLanguage();
//       //Save to loal database
//       if(res.isNotEmpty){
//         for (LanguagesModel data in res){
//           await databaseService.setLanguage(data: data);
//         }
//       }
//       return res;
//     }on DioError catch(error){
//       throw ServerException(error.message);
//     }
//   }
// }