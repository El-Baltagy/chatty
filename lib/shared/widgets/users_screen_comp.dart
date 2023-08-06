// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:chatty/models/user_model.dart';
// import '../utils/app_colors.dart';
// import '../utils/app_textstyle.dart';
// import '../utils/responsive.dart';
// import 'message_screen_comp.dart';
//
// class AllUsersComponent extends StatelessWidget {
//   final UserModel userModel;
//   final VoidCallback onPressed;
//
//   const AllUsersComponent({
//     super.key,
//     required this.userModel,
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: Material(
//         child: InkWell(
//           onTap: onPressed,
//           splashColor: AppColors.backgroundColor,
//           highlightColor: AppColors.textColor.withOpacity(.2),
//           child: Ink(
//             height: rhight(context) / 10,
//             width: rwidth(context),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20), color: Colors.white),
//             child: Row(
//               children: [
//                 Stack(
//                   alignment: Alignment.bottomRight,
//                   children: [
//                     CircleImage(
//                       image: CachedNetworkImageProvider(userModel.image),
//                       width: rwidth(context) / 5,
//                       hight: rhight(context) / 10,
//                       margin: 4,
//                     ),
//                     Positioned(
//                       top: rhight(context) / 14,
//                       child: const CircleAvatar(
//                         radius: 11,
//                         backgroundColor: Colors.white,
//                         child: CircleAvatar(
//                           radius: 7,
//                           backgroundColor: Colors.green,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   width: rwidth(context) / 30,
//                 ),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         userModel.userName,
//                         style: AppTextStyle.messageTitle,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       )
//                     ],
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
