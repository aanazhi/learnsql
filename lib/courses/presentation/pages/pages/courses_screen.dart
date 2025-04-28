// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:learnsql/config/theme/app_theme.dart';
// import 'package:learnsql/courses/presentation/pages/all_pages.dart';
// import 'package:learnsql/courses/presentation/widgets/widgets/custom_app_bar.dart';

// class CoursesScreen extends ConsumerStatefulWidget {
//   const CoursesScreen({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _CoursesScreenState();
// }

// class _CoursesScreenState extends ConsumerState<CoursesScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: CustomAppBar(showButton: true, controller: _tabController),

//       body: TabBarView(
//         controller: _tabController,
//         children: [const AllCoursesContent(), const MyCoursesContent()],
//       ),
//     );
//   }
// }
