part of 'buy_insurance_cubit.dart';

@freezed
class BuyInsuranceState with _$BuyInsuranceState {
  const factory BuyInsuranceState({
    @Default(DataStatus.initial)
    DataStatus status,
    String? error,
    @Default([])
    List<Insurance> listInsurance,
    @Default([])
    List<InsurancePackage> listInsurancePackage,
    User? currentUser,
    @Default(true)
    bool includeMe,
    @Default([])
    List<User> packagemembers,
    InsurancePackage? currentPackage,
    Insurance? currentInsurance,
    Certificate? currentCertificate,
    String? passportPhoto,
    String? vaccinePhoto,
    String? rtpcrPhoto,

  }) = _Initial;
}
