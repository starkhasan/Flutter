import 'package:flutter/material.dart';
import 'package:flutter_desktop/utils/progress_dialog.dart';
import '../../constants/app_colors.dart';
import '../../constants/font_path.dart';
import '../../constants/strings.dart';
import '../../custom_widgets/custom_text.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget{

  const LoginScreen({
    super.key
  });

  @override
  Widget build(BuildContext context){
    final progressDialog = ProgressDialog(context, isDismissible: false);
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(0),child: AppBar()),
      body: Center(
        child: Container(
          width: Get.width * 0.30,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [BoxShadow(color: AppColors.grey, blurRadius: 5.0)]
          ),
          child: SingleChildScrollView(
            child: Column(
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
                const SizedBox(height: 20),
                TextField(
                  controller: TextEditingController(),
                  style: const TextStyle(fontSize: 12, color: AppColors.black),
                  decoration: const InputDecoration(
                    label: Text(' ${Strings.email} '),
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    hintStyle: TextStyle(fontSize: 12, color: AppColors.grey),
                    prefixIcon: Icon(Icons.email)
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  controller: TextEditingController(),
                  style: const TextStyle(fontSize: 12, color: AppColors.black),
                  decoration: const InputDecoration(
                    label: Text(' ${Strings.password} '),
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    hintStyle: TextStyle(fontSize: 12, color: AppColors.grey),
                    prefixIcon: Icon(Icons.password)
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    progressDialog.show();
                    await Future.delayed(const Duration(seconds: 5));
                    progressDialog.hide();
                  },
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
            ),
          ),
        ),
      ),
    );
  }
}