// import 'package:crave_crusher/utils/app_colors/app_colors.dart';
// import 'package:crave_crusher/utils/app_images/app_images.dart';
// import 'package:crave_crusher/view/components/common_profile/common_profile_widget.dart';
// import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
// import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
// import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
// import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
// import 'package:crave_crusher/view/screens/battle/widget/battle_tab_selector.dart';
// import 'package:crave_crusher/view/screens/community/Community_post_screen/community_post_screen.dart';
// import 'package:crave_crusher/view/screens/community/community_all_feed_screen/community_all_feed_screen.dart';
// import 'package:crave_crusher/view/screens/community/widgets/common%20comunity%20widget.dart';
// import 'package:crave_crusher/view/screens/community/widgets/community_tab_selector.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
//
// class CommunityScreen extends StatefulWidget {
//   const CommunityScreen({super.key});
//
//   @override
//   State<CommunityScreen> createState() => _CommunityScreenState();
// }
//
// class _CommunityScreenState extends State<CommunityScreen> {
//   int _selectedTabIndex = 0; // track selected tab
//
//   final List<Widget> _screens = const [
//     CommunityAllFeedScreen(),
//     CommunityMyPostScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: NavBar(currentIndex: 2),
//       appBar: CustomAppBar(
//         title: 'Community',
//         onActionPressed: () {},
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           children: [
//             SizedBox(height: 16.h),
//             // Pass callback to tab selector
//             CommunityTabSelector(
//               onTabChanged: (index) {
//                 setState(() {
//                   _selectedTabIndex = index;
//                 });
//               },
//             ),
//             SizedBox(height: 16.h),
//             // Show the selected screen
//             Expanded(child: _screens[_selectedTabIndex]),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
