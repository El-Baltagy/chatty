// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:chatty/models/user_model.dart';
// import '../utils/app_colors.dart';
// import '../utils/app_textstyle.dart';
// import '../utils/app_assets.dart';
// import '../utils/responsive.dart';
//
//
// class SearchComponent extends StatelessWidget {
//   const SearchComponent({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       // controller: AppCubit.get(context).searchController,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide.none),
//         filled: true,
//         fillColor: AppColors.backgroundColor.withOpacity(.5),
//         errorMaxLines: 2,
//         contentPadding: EdgeInsets.zero,
//         hintText: 'Search',
//
//         prefixIcon: const Icon(
//           Icons.search,
//           size: 28,
//           color: Colors.black,
//         ),
//       ),
//       onChanged: (value){
//          // AppCubit.get(context).searchUser(AppCubit.get(context).searchController.text);
//       },
//     );
//   }
// }
//
// class MyMessageComponent extends StatelessWidget {
//   final UserModel model;
//   final VoidCallback onPressed;
//   const MyMessageComponent(
//       {super.key, required this.model, required this.onPressed});
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: Material(
//         child: InkWell(
//           splashColor: AppColors.backgroundColor,
//           highlightColor: AppColors.textColor.withOpacity(.2),
//           onTap: onPressed,
//           child: Ink(
//             height: rhight(context) / 7,
//             width: rwidth(context),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20), color: Colors.white),
//             child: Row(
//               children: [
//                 CircleImage(
//                     image: CachedNetworkImageProvider(model.image),
//                     hight: rhight(context) / 8,
//                     width: rwidth(context) / 4),
//                 SizedBox(
//                   width: rwidth(context) / 50,
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         top: rhight(context) / 80, right: rwidth(context) / 70),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           model.userName,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: AppTextStyle.messageTitle,
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ignore: must_be_immutable
// class CircleImage extends StatelessWidget {
//   final ImageProvider<Object> image;
//   final double hight;
//   final double width;
//   double? margin;
//   CircleImage(
//       {super.key, required this.image,
//       required this.hight,
//       required this.width,
//       this.margin});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: margin ?? 2),
//       height: hight,
//       width: width,
//       decoration: const BoxDecoration(
//         shape: BoxShape.circle,
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: FadeInImage(
//           placeholder: const AssetImage(ImgAsset.loading),
//           placeholderFit: BoxFit.cover,
//           image: image,
//           fit: BoxFit.cover),
//     );
//   }
// }
