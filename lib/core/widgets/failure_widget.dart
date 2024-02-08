import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final String? message;
  const FailureWidget({super.key,this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( message??"")
          ],
        ),
      ),
    );
  }
}