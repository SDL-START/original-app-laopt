part of 'certificate_cubit.dart';

@freezed
class CertificateState with _$CertificateState {
  const factory CertificateState({
    @Default(DataStatus.initial)
    DataStatus status,
    String? error,
    @Default([])
    List<ScanCertificate> listScanCertificate,
    ScanCertificate? currentScanCertificate,
  }) = _Initial;
}
