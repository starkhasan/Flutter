import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/routes.dart';
import '../controllers/signup_controller.dart';
import '../constants/app_colors.dart';
import '../constants/font_path.dart';
import '../constants/strings.dart';
import '../custom_widgets/custom_text.dart';

class SignupScreen extends StatelessWidget {

  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context){
    final signupController = Get.put(SignupController());
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar()),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.blue,
              AppColors.red,
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: Get.width * 0.30,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [BoxShadow(color: AppColors.grey, blurRadius: 5.0)]
            ),
            child: SingleChildScrollView(
              child: GetBuilder<SignupController>(
                init: signupController,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomText( 
                        title: Strings.signup,
                        textSize: 16,
                        textColor: AppColors.black,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontPath.montserratSemiBole,
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: signupController.nameTextController,
                        style: const TextStyle(fontSize: 12, color: AppColors.black),
                        decoration: InputDecoration(
                          label: const Text(' ${Strings.name} '),
                          isDense: true,
                          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))),
                          hintStyle: const TextStyle(fontSize: 12, color: AppColors.grey),
                          prefixIcon: const Icon(Icons.person),
                          errorText: signupController.errorName.isEmpty
                          ? null
                          : signupController.errorName
                        ),
                        onChanged: (value) => signupController.onNameTextChange(),
                        onSubmitted: (value) => signupController.signupUser(),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: signupController.emailTextController,
                        style: const TextStyle(fontSize: 12, color: AppColors.black),
                        decoration: InputDecoration(
                          label: const Text(' ${Strings.email} '),
                          isDense: true,
                          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))),
                          hintStyle: const TextStyle(fontSize: 12, color: AppColors.grey),
                          prefixIcon: const Icon(Icons.email),
                          errorText: signupController.errorEmail.isEmpty
                          ? null
                          : signupController.errorEmail
                        ),
                        onChanged: (value) => signupController.onEmailTextChange(),
                        onSubmitted: (value) => signupController.signupUser(),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        obscureText: !signupController.showPassword,
                        controller:  signupController.passwordTextController,
                        style: const TextStyle(fontSize: 12, color: AppColors.black),
                        decoration: InputDecoration(
                          label: const Text(' ${Strings.password} '),
                          isDense: true,
                          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))),
                          hintStyle: const TextStyle(fontSize: 12, color: AppColors.grey),
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: InkWell(
                            onTap: () => signupController.passwordVisibility(),
                            child: Icon(
                              signupController.showPassword
                              ? Icons.remove_red_eye
                              : Icons.lock
                              , color: AppColors.black
                            ),
                          ),
                          errorText: signupController.errorPassword.isEmpty
                          ? null
                          : signupController.errorPassword
                        ),
                        onChanged: (value) => signupController.onPasswordTextChange(),
                        onSubmitted: (value) => signupController.signupUser(),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => signupController.signupUser(),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: const BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(6.0))
                          ),
                          child: const CustomText(
                            title: Strings.signup,
                            textSize: 12,
                            textColor: AppColors.white,
                            textAlign: TextAlign.center,
                            fontFamily: FontPath.montserratSemiBole,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                            title: Strings.signAccountMessage,
                            textSize: 12,
                            textColor: AppColors.grey
                          ),
                          InkWell(
                            onTap:() => Get.toNamed(Routes.loginScreen),
                            child: const CustomText(
                              title: Strings.login,
                              textColor: AppColors.blue,
                              textSize: 12
                            ) 
                          )
                        ],
                      )
                    ],
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}