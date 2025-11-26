import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crave_crusher/view/features/change_password/controllers/change_password_controller.dart';
import 'package:crave_crusher/view/features/change_password/models/change_password_model.dart';
import 'package:crave_crusher/view/features/profile/profile_screen/profile_screen.dart';
import 'package:crave_crusher/view/components/input_password_field_widget/input_password_field_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmedPassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ChangePasswordController changePasswordController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change Password")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              InputPasswordFieldWidget(
                title: "Old Password",
                controller: _oldPassController,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter old password";
                  if (value.length < 6) return "Password must be at least 6 characters";
                  return null;
                },
              ),
              InputPasswordFieldWidget(
                title: "New Password",
                controller: _newPassController,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter new password";
                  if (value.length < 6) return "Password must be at least 6 characters";
                  return null;
                },
              ),
              InputPasswordFieldWidget(
                title: "Confirm Password",
                controller: _confirmedPassController,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter confirm password";
                  if (value != _newPassController.text) return "Passwords do not match";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              GetBuilder<ChangePasswordController>(
                builder: (controller) {
                  return controller.inProgress
                      ? const CircularProgressIndicator()
                      : CustomButton(onTap: _updateButton,
                  title: "Update",
                  );


                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateButton() async {
    if (_formKey.currentState!.validate()) {
      final model = ChangePasswordModel(
        oldPassword: _oldPassController.text,
        newPassword: _newPassController.text,
        confirmNewPassword: _confirmedPassController.text,
      );

      final success = await changePasswordController.changePassword(model);
      if (success) {
        Get.off(ProfileScreen());
      } else {
        Get.snackbar("Error", changePasswordController.errorMessage ?? "Something went wrong");
      }
    }
  }
}
