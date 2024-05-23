import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/core/models/certificate_response.dart';
import 'package:insuranceapp/core/models/claim.dart';
import 'package:insuranceapp/core/models/claim_log.dart';
import 'package:insuranceapp/core/models/menu.dart';
import 'package:insuranceapp/core/models/pt_image.dart';
import 'package:insuranceapp/core/models/response_data.dart';
import 'package:insuranceapp/core/models/response_dropdown.dart';
import 'package:insuranceapp/core/models/sos_logs.dart';
import 'package:insuranceapp/core/models/ticket.dart';

import '../../../../core/models/certificate_member.dart';
import '../../../../core/models/claim_request.dart';
import '../../../../core/models/request_sos.dart';
import '../../../../core/models/response_qr.dart';

abstract class HomeRepository{
  Future<Either<Failure,List<PTImage>>>getSlideImage();
  Future<Either<Failure,List<Menu>>>getMenu();
  Future<Either<Failure,ResponseData>>uploadFile({required File file});
  Future<Either<Failure,CertificateResponse>>createCertificate({required Certificate body});
  Future<Either<Failure,dynamic>>getGenerateQR({required String id,required String amount});
  Future<Either<Failure,List<Certificate>>>getMyInsurance();
  Future<Either<Failure,List<Claim>>>getClaim();
  Future<Either<Failure,List<ClaimLog>>>getClaimLog({required int id});
  Future<Either<Failure,List<ResponseDropdown>>>getClaimType();
  Future<Either<Failure,String>>payCredit({Certificate? certificate});
  Future<Either<Failure,Responseqr>>payBCEL({required String id, String? amount});
  Future<Either<Failure,List<Certificate>>>getPaidInsurance();
  Future<Either<Failure,Ticket>>requestSOS({required RequestSOS data});
  Future<Either<Failure,dynamic>>cliamRequest({required ClaimRequest data});
  Future<Either<Failure,List<SOSLogs>>>getSOSProcessing();
  Future<Either<Failure,List<CertificateMember>>>getCertificateMember({int? id});


}