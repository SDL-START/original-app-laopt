import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';

import '../../../../core/models/scan_certificate.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../domain/usecases/get_certificate_scan_usecase.dart';

part 'certificate_cubit.freezed.dart';
part 'certificate_state.dart';

@injectable
class CertificateCubit extends Cubit<CertificateState> {
  final GetCertificateScan _getCertificateScan;
  CertificateCubit(this._getCertificateScan) : super(const CertificateState());
  Future<void> onScan() async {
    emit(state.copyWith(status: DataStatus.loading));
    final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '',
      LocaleKeys.kCancel.tr(),
      true,
      ScanMode.QR,
    );
    final result = await _getCertificateScan(barcodeScanRes);
    result.fold((error) {
      emit(state.copyWith(status: DataStatus.failure, error: error.msg));
    }, (scanCertificateData) {
      List<ScanCertificate> listData = List.of(state.listScanCertificate);
      if (listData.isNotEmpty) {
        if (listData
            .where(
                (e) => e.certificate?.id == scanCertificateData.certificate?.id)
            .isEmpty) {
          listData.add(scanCertificateData);
        }
      } else {
        listData.add(scanCertificateData);
      }
      emit(
        state.copyWith(
            status: DataStatus.success, listScanCertificate: listData),
      );
      AppNavigator.navigateTo(AppRoute.myInsuranceDetail,params: scanCertificateData.certificate);
    });
  }
}
