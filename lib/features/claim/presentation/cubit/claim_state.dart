part of 'claim_cubit.dart';

@freezed
class ClaimState with _$ClaimState {
  const factory ClaimState({
    @Default(DataStatus.initial) DataStatus status,
    String? error,
    @Default([]) List<Claim> listClaim,
    @Default([]) List<Certificate> listCertificate,
    Certificate? currentCertificate,
    CertificateMember? currentCertificateMember,
    User? currentUser,
    @Default([]) List<Hospital> listHospital,
    @Default([]) List<ResponseDropdown> listClaimType,
    @Default({}) Map<String, dynamic> formValue,
    @Default([]) List<String> listDocument,
    @Default([])
    List<ClaimLog> listClaimLog,
  }) = _Initial;
}
