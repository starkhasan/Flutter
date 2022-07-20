import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../../constants/app_colors.dart';
import '../../constants/font_path.dart';
import '../../constants/strings.dart';
import '../../custom_widgets/custom_text.dart';

class LoginScreen extends StatelessWidget{

  const LoginScreen({
    super.key
  });

  @override
  Widget build(BuildContext context){
    final loginController = Get.put(LoginController());
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
              child: GetBuilder<LoginController>(
                init: loginController,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomText( 
                        title: Strings.welcome,
                        textSize: 16,
                        textColor: AppColors.black,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontPath.montserratSemiBole,
                      ),
                      const SizedBox(height: 2.0),
                      const CustomText(
                        title: Strings.credentialMessage,
                        textColor: AppColors.black,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.normal,
                        fontFamily: FontPath.montserratSemiBole,
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: loginController.emailTextController,
                        style: const TextStyle(fontSize: 12, color: AppColors.black),
                        decoration: InputDecoration(
                          label: const Text(' ${Strings.email} '),
                          isDense: true,
                          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))),
                          hintStyle: const TextStyle(fontSize: 12, color: AppColors.grey),
                          prefixIcon: const Icon(Icons.email),
                          errorText: loginController.errorEmail.isEmpty
                          ? null
                          : loginController.errorEmail
                        ),
                        onChanged: (value) => loginController.onEmailTextChange(),
                        onSubmitted: (value) => loginController.loginUser(),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        obscureText: !loginController.showPassword,
                        controller:  loginController.passwordTextController,
                        style: const TextStyle(fontSize: 12, color: AppColors.black),
                        decoration: InputDecoration(
                          label: const Text(' ${Strings.password} '),
                          isDense: true,
                          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))),
                          hintStyle: const TextStyle(fontSize: 12, color: AppColors.grey),
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: InkWell(
                            onTap: () => loginController.passwordVisibility(),
                            child: Icon(
                              loginController.showPassword
                              ? Icons.remove_red_eye
                              : Icons.lock
                              , color: AppColors.black
                            )
                          ),
                          errorText: loginController.errorPassword.isEmpty
                          ? null
                          : loginController.errorPassword
                        ),
                        onChanged: (value) => loginController.onPasswordTextChange(),
                        onSubmitted: (value) => loginController.loginUser(),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => loginController.loginUser(),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: const BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(6.0))
                          ),
                          child: const CustomText(
                            title: Strings.login,
                            textSize: 12,
                            textColor: AppColors.white,
                            textAlign: TextAlign.center,
                            fontFamily: FontPath.montserratSemiBole,
                          ),
                        ),
                      ),
                      
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