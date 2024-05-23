// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:insuranceapp/core/constants/api_path.dart';
// import 'package:insuranceapp/core/utils/app_navigator.dart';
// import 'package:insuranceapp/features/home/presentation/cubit/insurance/insurance_cubit.dart';

// import '../../../../core/constants/constant.dart';

// class AddImageWidget extends StatelessWidget {
//   final String? description;
//   final String? title;
//   final FileType fileType;
//   const AddImageWidget({
//     super.key,
//     this.description,
//     this.title,
//     required this.fileType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<InsuranceCubit>();
//     return Card(
//       child: Container(
//         padding: const EdgeInsets.only(left: 5, top: 8, bottom: 8),
//         child: ListTile(
//           trailing: CachedNetworkImage(
//             imageUrl:
//                 "${APIPath.publicUrl}/${cubit.getFileString(fileType: fileType)}",
//             width: 100,
//             errorWidget: (context, url, error) {
//               return const Icon(Icons.photo_outlined);
//             },
//           ),
//           title: Text(title ?? ''),
//           subtitle: Text(description ?? ''),
//           onTap: () {
//             showModalBottomSheet(
//               context: context,
//               builder: (_) {
//                 return SizedBox(
//                   height: 100,
//                   width: double.infinity,
//                   child: Flex(
//                     direction: Axis.horizontal,
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: TextButton.icon(
//                           onPressed: () {
//                             AppNavigator.goBack();
//                             cubit.getImageFile(source: ImageSource.camera,fileType: fileType);
//                           },
//                           icon: const Icon(Icons.camera_alt),
//                           label: const Text('Camera'),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: TextButton.icon(
//                           onPressed: () {
//                             AppNavigator.goBack();
//                             cubit.getImageFile(
//                                 source: ImageSource.gallery, fileType: fileType);
//                           },
//                           icon: const Icon(Icons.photo_album),
//                           label: const Text("Gallery"),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
