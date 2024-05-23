part of 'my_insurance_cubit.dart';

@freezed
class MyInsuranceState with _$MyInsuranceState {
  const factory MyInsuranceState({
    @Default(DataStatus.initial)
    DataStatus status,
    String? error,
    @Default([])
    List<Certificate> listCertificate,
    @Default([])
    List<CertificateMember> listCertificateMember,
  }) = _Initial;
}
