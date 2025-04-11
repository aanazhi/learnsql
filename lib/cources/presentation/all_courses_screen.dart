import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/config.dart';

class AllCoursesScreen extends ConsumerStatefulWidget {
  const AllCoursesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllCoursesScreenState();
}

class _AllCoursesScreenState extends ConsumerState<AllCoursesScreen> {
  @override
  Widget build(BuildContext context) {
    // final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.activeColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Image.asset(
            'assets/images/logo_2.png',
            width: 216,
            height: 59,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: SizedBox(width: 340, height: 55))],
      ),
    );
  }
}
