// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:insuranceapp/generated/locale_keys.g.dart';

// import '../constants/api_path.dart';
// import '../constants/app_colors.dart';
// import '../utils/utils.dart';

// class PolicyPage extends StatefulWidget {
//   final VoidCallback? onPressed;
//   final bool isLoading;
//   const PolicyPage({
//     super.key,
//     this.onPressed,
//     this.isLoading = false,
//   });

//   @override
//   State<PolicyPage> createState() => _PolicyPageState();
// }

// class _PolicyPageState extends State<PolicyPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(LocaleKeys.kPolicy.tr()),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         //kkkkkk
//         // child: InAppWebView(
//         //   initialUrlRequest: URLRequest(
//         //     url: Uri.parse(
//         //       '${APIPath.baseUrl}/policy-${Utils.convertCode(context: context)}.html?1=1',
//         //     ),
//         //   ),
//         // ),
//       ),
//       floatingActionButton: widget.onPressed == null
//           ? null
//           : Builder(
//               builder: (context) {
//                 if (widget.isLoading) {
//                   return Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: const BoxDecoration(
//                         shape: BoxShape.circle, color: AppColors.primaryColor),
//                     child: const CircularProgressIndicator(
//                       color: Colors.white,
//                     ),
//                   );
//                 } else {
//                   return FloatingActionButton.extended(
//                     onPressed: widget.onPressed,
//                     label: Text(LocaleKeys.kAcceptedTerms.tr()),
//                   );
//                 }
//               },
//             ),
//     );
//   }
// }
