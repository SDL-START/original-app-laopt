// import 'package:flutter/material.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:insuranceapp/core/entities/webview_params.dart';
// import 'package:insuranceapp/features/travel/pages/book_mark.dart';
// import 'package:insuranceapp/features/travel/pages/place.dart';
// import 'package:insuranceapp/features/travel/pages/popular_place.dart';

// class PTWebviewPagw extends StatelessWidget {
//   final List<Widget> _fragmentScreens = [
//     PopularPlace(),
//     Place(),
//     BookMark(),
//   ];
//   final List<Map<String, dynamic>> _navigationButtonProperties = [
//     {
//       "active_icon": Icons.home,
//       "non_active_icon": Icons.home_outlined,
//       "active_color": Colors.red,
//       "non_active_color": Colors.white,
//       "label": "Home",
//     },
//     {
//       "active_icon": Icons.pin_drop,
//       "non_active_icon": Icons.pin_drop_outlined,
//       "active_color": Colors.red,
//       "non_active_color": Colors.white,
//       "label": "Travel",
//     },
//     {
//       "active_icon": Icons.bookmark,
//       "non_active_icon": Icons.bookmark,
//       "active_color": Colors.red,
//       "non_active_color": Colors.white,
//       "label": "Save",
//     }
//   ];
//   final RxInt _indexNumber = 0.obs;
//   final WebviewParams params;
//   PTWebviewPagw({
//     super.key,
//     required this.params,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   centerTitle: true,
//       //   title: Text(
//       //     params.label ??
//       //         Utils.getTranslate(
//       //           context,
//       //           params.name,
//       //         ),
//       //     // params.label.toString(),
//       //   ),
//       // ),
//       // ),
//       body: SafeArea(
//         child: Obx(
//           () => _fragmentScreens[_indexNumber.value],
//         ),
//       ),
//       bottomNavigationBar: Obx(
//         () => BottomNavigationBar(
//           currentIndex: _indexNumber.value,
//           // ignore: avoid_types_as_parameter_names
//           onTap: (Value) {
//             _indexNumber.value = Value;
//           },
//           backgroundColor: Colors.green[900],
//           showSelectedLabels: true,
//           showUnselectedLabels: true,
//           selectedItemColor: Colors.red,
//           unselectedItemColor: Colors.white,
//           items: List.generate(3, (index) {
//             var navBtnProperty = _navigationButtonProperties[index];
//             return BottomNavigationBarItem(
//               icon: Icon(
//                 _indexNumber.value == index
//                     ? navBtnProperty["active_icon"]
//                     : navBtnProperty["non_active_icon"],
//                 color: _indexNumber.value == index
//                     ? navBtnProperty["active_color"]
//                     : navBtnProperty["non_active_color"],
//               ),
//               label: navBtnProperty["label"],
//             );
//           }),
//         ),
//       ),
//       // body: Padding(
//       //   padding: const EdgeInsets.all(10),
//       //   child: InAppWebView(
//       //     initialUrlRequest: URLRequest(
//       //       url: Uri.parse(
//       //         params.url ?? '',
//       //       ),
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:insuranceapp/core/entities/webview_params.dart';
import 'package:insuranceapp/core/utils/utils.dart';

class PTWebviewPagw extends StatelessWidget {
  final WebviewParams params;
  const PTWebviewPagw({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(params.label ?? Utils.getTranslate(context, params.name)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(params.url ?? '')),
        ),
      ),
    );
  }
}
