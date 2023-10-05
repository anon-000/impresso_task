import 'package:flutter/material.dart';
import 'package:flutter_anim/widgets/app_outlined_button.dart';
import 'package:flutter_anim/widgets/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 24/09/23 at 2:54 AM
///

class ValidationDialog extends StatelessWidget {
  const ValidationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            // side: const BorderSide(color: Colors.red, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Text(
                "😊",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Your Validation is in Progress. Check your your App Inbox. Validate your career information now?",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppPrimaryButton(
                    onPressed: () {},
                    child: const Text("Proceed"),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: AppOutlineButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
