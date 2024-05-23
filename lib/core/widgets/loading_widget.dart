import 'package:flutter/material.dart';
import 'package:insuranceapp/core/constants/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final String? title;

  const LoadingWidget({super.key,this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const CircularProgressIndicator(color: AppColors.primaryColor,),
           const SizedBox(height: 15,),
           Text(title??""),
          ],
        ),
      ),
    );
  }
}