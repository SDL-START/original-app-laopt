import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/DI/service_locator.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/core/models/insurance.dart';
import 'package:insuranceapp/core/models/sos_logs.dart';
import 'package:insuranceapp/core/params/policy_schedule_params.dart';
import 'package:insuranceapp/core/widgets/pt_webview_page.dart';
import 'package:insuranceapp/features/app/presentation/cubit/app_cubit.dart';
import 'package:insuranceapp/features/app/presentation/pages/app_page.dart';
import 'package:insuranceapp/features/buy_insurance/presentation/cubit/buy_insurance_cubit.dart';
import 'package:insuranceapp/features/certification/presentration/cubit/certificate_cubit.dart';
import 'package:insuranceapp/features/chats/presentation/pages/staff/chat_staff_page.dart';
import 'package:insuranceapp/features/hospitals/presentation/cubit/hospital_cubit.dart';
import 'package:insuranceapp/features/languages/presentation/pages/language_page.dart';
import 'package:insuranceapp/features/login/presentation/pages/forgotpassword/reset_password_page.dart';
import 'package:insuranceapp/features/login/presentation/pages/login_detail.dart';
import 'package:insuranceapp/features/login/presentation/pages/login_page.dart';
import 'package:insuranceapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:insuranceapp/features/settings/presentation/pagse/change_password_page.dart';
import 'package:insuranceapp/features/settings/presentation/pagse/profile_page.dart';
import 'package:insuranceapp/features/sos/presentation/pages/sos_request_detail_page.dart';
import 'package:insuranceapp/features/support/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:insuranceapp/features/support/presentation/pages/chats/preview_image_page.dart';
import 'package:insuranceapp/features/support/presentation/pages/chats/send_location_page.dart';

import '../../features/buy_insurance/presentation/pages/add_member_page.dart';
import '../../features/buy_insurance/presentation/pages/buy_insurance_page.dart';
import '../../features/buy_insurance/presentation/pages/select_package_page.dart';
import '../../features/buy_insurance/presentation/pages/upload_document_page.dart';
import '../../features/certification/presentration/pages/scan_certificate_page.dart';
import '../../features/claim/presentation/cubit/claim_cubit.dart';
import '../../features/claim/presentation/pages/claim_page.dart';
import '../../features/home/presentation/cubit/tabs_cubit/tab_cubit.dart';
import '../../features/home/presentation/pages/tab_page.dart';
import '../../features/hospitals/presentation/pages/hospital_detail_page.dart';
import '../../features/hospitals/presentation/pages/hospital_service_page.dart';
import '../../features/languages/presentation/cubit/language_cubit.dart';
import '../../features/login/presentation/cubit/login_cubit.dart';
import '../../features/login/presentation/pages/forgotpassword/forgot_password_page.dart';
import '../../features/my_insurance/presentation/cubit/my_insurance_cubit.dart';
import '../../features/my_insurance/presentation/pages/certificate_member_page.dart';
import '../../features/my_insurance/presentation/pages/my_insurance_detail_page.dart';
import '../../features/my_insurance/presentation/pages/my_insurance_page.dart';
import '../../features/my_insurance/presentation/pages/payment_page.dart';
import '../../features/my_insurance/presentation/pages/policy_schedule_page.dart';
import '../../features/registration/presentation/cubit/register_cubit.dart';
import '../../features/registration/presentation/pages/confirm_otp_page.dart';
import '../../features/registration/presentation/pages/register_page.dart';
import '../../features/registration/presentation/pages/register_purpose_page.dart';
import '../../features/registration/presentation/pages/set_password_page.dart';
import '../../features/registration/presentation/pages/upload_documents_page.dart';
import '../../features/sos/presentation/cubit/sos_cubit.dart';
import '../../features/sos/presentation/pages/sos_detail_page.dart';
import '../../features/sos/presentation/pages/sos_page.dart';
import '../../features/support/presentation/cubit/location_cubit/location_cubit.dart';
import '../../features/support/presentation/cubit/support_cubit/support_cubit.dart';
import '../../features/support/presentation/pages/chats/chat_page.dart';
import '../../features/support/presentation/pages/chats/live_location_page.dart';
import '../../features/support/presentation/pages/ticket_detail_page.dart';
import '../entities/webview_params.dart';
import '../models/hospital.dart';
import '../models/ticket.dart';
import '../params/policy_member_params.dart';
import '../params/preview_img_params.dart';
import '../widgets/not_found.dart';

class AppRoute {
  static const String initialRoute = "/";
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
  static const String langRoute = "/language";
  static const String loginDetailRoute = "/logindetail";
  static const String changePasswordRoute = "/changepassword";
  static const String policyRoute = "/policy";
  static const String profileRoute = "/profile";
  static const String buyInsuranceRoute = "/buyinsurance";
  static const String selectPackageRoute = "/package";
  static const String addMemberRoute = "/member";
  static const String myInsuranceDetail = "/insuranceDetail";
  static const String policySchedule = "/policySchedule";
  static const String paymentRoute = "/payment";
  static const String myInsuranceRoute = "/myinsurance";
  static const String myWebviewRoute = "/myWebview";
  static const String hospitalRoute = "/hospital";
  static const String hospitalDetailRoute = "/hospitalDetail";
  static const String claimRoute = "/claim";
  static const String claimDtailRoute = "/claimDetail";
  static const String requestClaimRoute = "/requestclaim";
  static const String ticketDetailRoute = "/ticketDetail";
  static const String sosRequestDetailRoute = "/sos";
  static const String selectCertificateRoute = "/selectCertificate";
  static const String requestUploadRoute = "/requestUpload";
  static const String selectCerMemberRoute = "/selectMember";
  static const String registerRoute = "/register";
  static const String confirmOTP = "/otp";
  static const String sosListRoute = "/staffsoslist";
  static const String sosDetail = "/sosDetail";
  static const String scanRoute = "/scancertificate";
  static const String registerPurposeRoute = "/registerPurpose";
  static const String uploadDocumentsRoute = "/uploadDocuments";
  static const String setPasswordRoute = "/setPassword";
  static const String chatRoute = "/chat";
  static const String chatStaffRoute = "/chatStaff";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String resetPasswordRoute = "/resetPassword";
  static const String certificateMemberRoute = "/certificateMember";
  static const String insuranceDocument = "/insuranceDocument";
  static const String sendLocationRoute = "/senlocation";
  static const String previewImageRoute = "/previewImage";
  static const String liveLocationRoute = "/liveLocation";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return _materialRoute(
          providers: [
            BlocProvider<AppCubit>(
              create: (context) => getIt<AppCubit>()..initialApp()
                
            ),
          ],
          child: const AppPage(),
        );
      case loginRoute:
        return _materialRoute(child: const LoginPage(), providers: [
          BlocProvider<LoginCubit>(
            create: (context) => getIt<LoginCubit>()..initial(),
          )
        ]);
      case langRoute:
        return _materialRoute(child: const LanguagePage(), providers: [
          BlocProvider<LanguageCubit>(
            create: (context) => getIt<LanguageCubit>()..getLanguage(),
          )
        ]);
      case loginDetailRoute:
        final params = settings.arguments as bool;
        return _materialRoute(child: LoginDetail(isPhone: params), providers: [
          BlocProvider<LoginCubit>(
            create: (context) => getIt<LoginCubit>()
              ..getFirbaseToken()
              ..getLoginData(isPhone: params),
          )
        ]);
      case homeRoute:
        return _materialRoute(child: const TabPage(), providers: [
          BlocProvider<TabCubit>(
            create: (context) => getIt<TabCubit>(),
          ),
        ]);
      case changePasswordRoute:
        return _materialRoute(child: const ChangePasswordPage(), providers: [
          BlocProvider<SettingsCubit>(
            create: (context) => getIt<SettingsCubit>()..getUserInfo(),
          ),
        ]);
      case profileRoute:
        return _materialRoute(child: const ProfilePage(), providers: [
          BlocProvider<SettingsCubit>(
              create: (context) => getIt<SettingsCubit>()..getUserProfile()),
        ]);
      case buyInsuranceRoute:
        return _materialRoute(child: const BuyInsurancePage(), providers: [
          BlocProvider<BuyInsuranceCubit>(
            create: (context) => getIt<BuyInsuranceCubit>()..getInsuranceType(),
          )
        ]);
      case selectPackageRoute:
        final params = settings.arguments as Insurance;
        return _materialRoute(child: const SelectPackagePage(), providers: [
          BlocProvider<BuyInsuranceCubit>(
            create: (_) =>
                getIt<BuyInsuranceCubit>()..getInsurancePackage(params),
          )
        ]);
      case addMemberRoute:
        final params = settings.arguments as Map<String, dynamic>;
        return _materialRoute(child: const AddMemberPage(), providers: [
          BlocProvider<BuyInsuranceCubit>(
            create: (context) => getIt<BuyInsuranceCubit>()
              ..getInsuranceMember(
                package: params['package'],
                currentInsurance: params['insurance'],
                currentUser: params['currentUser'],
              ),
          )
        ]);

      case insuranceDocument:
        return _materialRoute(
          child: const UploadDocumentPage(),
        );
      case myInsuranceDetail:
        final params = settings.arguments as Certificate;
        return _materialRoute(
          child: MyInsuranceDetailPage(
            certificate: params,
          ),
          providers: [
            BlocProvider<MyInsuranceCubit>(
              create: (context) => getIt<MyInsuranceCubit>()
                ..getCertificateMember(id: params.id),
            )
          ],
        );
      case certificateMemberRoute:
        final params = settings.arguments as PolicyMemberParams;
        return _materialRoute(
          child: CertificateMemberPage(
            certificate: params.certificate,
            member: params.member,
          ),
        );
      case policySchedule:
        final params = settings.arguments as PolicyScheduleParams;
        return _materialRoute(
          child: PolicySchedulePage(
            certificate: params.certificate,
            certificateMember: params.certificateMember,
          ),
        );
      case paymentRoute:
        final params = settings.arguments as Certificate;
        return _materialRoute(
          child: PaymentPage(certificate: params),
          providers: [
            BlocProvider<MyInsuranceCubit>(
              create: (context) => getIt<MyInsuranceCubit>(),
            )
          ],
        );
      case myInsuranceRoute:
        return _materialRoute(child: const MyInsurancePage(), providers: [
          BlocProvider<MyInsuranceCubit>.value(
            value: getIt<MyInsuranceCubit>()..getMyInsurance(),
          )
        ]);
      case myWebviewRoute:
        final params = settings.arguments as WebviewParams;
        return _materialRoute(
            child: PTWebviewPagw(params: params), providers: []);
      case hospitalRoute:
        return _materialRoute(child: const HospitalServicePage(), providers: [
          BlocProvider<HospitalCubit>.value(
            value: getIt<HospitalCubit>()..getHospitalService(),
          )
        ]);
      case hospitalDetailRoute:
        final params = settings.arguments as Hospital;
        return _materialRoute(
          child: HospitalDetailPage(hospital: params),
        );
      case claimRoute:
        return _materialRoute(child: const ClaimPage(), providers: [
          BlocProvider<ClaimCubit>(
            create: (context) => getIt<ClaimCubit>()
              ..getCliam()
              ..getCurrentUser()
              ..getHospital()
              ..getClaimType(),
          )
        ]);
      case ticketDetailRoute:
        final params = settings.arguments as Ticket;
        return _materialRoute(
          child: const TicketDetailPage(),
          providers: [
            BlocProvider<SupportCubit>(
              create: (context) => getIt<SupportCubit>()
                ..getCurrentuser()
                ..getTicketDetail(params),
            ),
          ],
        );
      case sosRequestDetailRoute:
        final params = settings.arguments as Ticket;
        return _materialRoute(
          providers: [
            BlocProvider<SosCubit>(
              create: (context) => getIt<SosCubit>()..getTicketHistory(),
            )
          ],
          child: SOSRequestDetail(ticket: params),
        );

      case registerRoute:
        return _materialRoute(
          child: const RegisterPage(),
          providers: [
            BlocProvider<RegisterCubit>(
              create: (context) => getIt<RegisterCubit>(),
            ),
          ],
        );
      case confirmOTP:
        final param = settings.arguments as RegisterCubit;
        return _materialRoute(
          child: const ConfirmOTPPage(),
          providers: [
            BlocProvider<RegisterCubit>.value(
              value: param,
            ),
          ],
        );

      case sosListRoute:
        return _materialRoute(
          child: const SOSListPage(),
          providers: [
            BlocProvider<SosCubit>(
              create: (context) => getIt<SosCubit>()
                ..getSOSPending()
                ..getCurrentLocation(),
            ),
          ],
        );
      case sosDetail:
        final params = settings.arguments as int;
        return _materialRoute(
          child: const SOSDetailStaffPage(),
          providers: [
            BlocProvider<SosCubit>(
              create: (context) => getIt<SosCubit>()
                ..getCurrentUser()
                ..getCurrentLocation()
                ..getTicketDetail(id: params),
            ),
          ],
        );
      case scanRoute:
        return _materialRoute(
          child: const ScanCertificatePage(),
          providers: [
            BlocProvider<CertificateCubit>(
              create: (context) => getIt<CertificateCubit>(),
            ),
          ],
        );

      case registerPurposeRoute:
        final param = settings.arguments as RegisterCubit;
        return _materialRoute(
          child: const RegisterPurposePage(),
          providers: [
            BlocProvider<RegisterCubit>.value(
              value: param
                ..getProvinces()
                ..getPurposes(),
            ),
          ],
        );
      case uploadDocumentsRoute:
        final param = settings.arguments as RegisterCubit;
        return _materialRoute(
          child: const UploadDocuments(),
          providers: [
            BlocProvider<RegisterCubit>.value(
              value: param,
            ),
          ],
        );
      case setPasswordRoute:
        final param = settings.arguments as RegisterCubit;
        return _materialRoute(
          child: const SetPasswordPage(),
          providers: [
            BlocProvider<RegisterCubit>.value(
              value: param,
            ),
          ],
        );
      case chatRoute:
        final params = settings.arguments as Ticket;
        return _materialRoute(
          child: const ChatPage(),
          providers: [
            BlocProvider<ChatCubit>(
              create: (context) => getIt<ChatCubit>()
                ..getMessageStream(params.ticketId)
                ..getCurrentuser()
                ..getTicketDetail(params)
                ..getCurrentLocation()
                ..getLocationDistance(),
            ),
          ],
        );
      case chatStaffRoute:
        final params = settings.arguments as SOSLogs;
        return _materialRoute(
          child: ChatStaffPage(
            log: params,
          ),
          providers: [
            BlocProvider<ChatCubit>(create: (context) => getIt<ChatCubit>()
                // ..getUserById(id: params.sos_tickets?.userid ?? 0)
                ),
          ],
        );
      case forgotPasswordRoute:
        return _materialRoute(
          child: const ForgotPasswordPage(),
          providers: [
            BlocProvider<LoginCubit>(create: (context) => getIt<LoginCubit>()),
          ],
        );
      case resetPasswordRoute:
        final params = settings.arguments as LoginCubit;
        return _materialRoute(
          child: const ResetPasswordPage(),
          providers: [
            BlocProvider<LoginCubit>.value(
              value: params,
            ),
          ],
        );
      case sendLocationRoute:
        final params = settings.arguments as Ticket;
        return _materialRoute(
          providers: [
            BlocProvider<ChatCubit>(
              create: (context) => getIt<ChatCubit>()
                ..getTicketDetail(params)
                ..getCurrentuser()
                ..getCurrentLocation(),
            )
          ],
          child: const SendLocationPage(),
        );
      case previewImageRoute:
        final params = settings.arguments as PreviewImageParams;
        return _materialRoute(
          child: PreviewImage(
            params: params,
          ),
        );
      case liveLocationRoute:
        final params = settings.arguments as int?;
        return _materialRoute(
          providers: [
            BlocProvider<LocationCubit>(
              create: (context) => getIt<LocationCubit>()
                ..getLiveLocation(messageId: params)
                ..getCurrentLocation(),
            ),
          ],
          child: const LiveLocationpage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFound(),
        );
    }
  }

  static Route<dynamic> _materialRoute(
      {required Widget child, List<BlocProvider> providers = const []}) {
    return MaterialPageRoute(
        builder: (context) => providers.isNotEmpty
            ? MultiBlocProvider(providers: providers, child: child)
            : child);
  }
}
