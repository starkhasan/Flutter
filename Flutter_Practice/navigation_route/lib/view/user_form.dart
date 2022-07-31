import 'package:flutter/material.dart';
import 'package:navigation_route/utils/helper.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  UserRegistrationState createState() => UserRegistrationState();
}

class UserRegistrationState extends State<UserRegistration> with Helper{
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var dobController = TextEditingController();
  var fatherController = TextEditingController();
  var motherController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('User Registration')),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  hintText: 'Full Name', label: Text('Full Name')),
            ),
            TextField(
              controller: ageController,
              textInputAction: TextInputAction.next,
              decoration:
                  const InputDecoration(hintText: 'Age', label: Text('Age')),
            ),
            TextField(
              controller: dobController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  hintText: 'DOB', label: Text('Enter your DOB')),
            ),
            TextField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration:
                  const InputDecoration(hintText: 'Email', label: Text('Email')),
            ),
            TextField(
              controller: mobileController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  hintText: 'Mobile', label: Text('Mobile')),
            ),
            TextField(
              controller: fatherController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  hintText: 'Father Name', label: Text('Father Name')),
            ),
            TextField(
              controller: motherController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  hintText: 'Mother Name', label: Text('Mother Name')),
            ),
            TextField(
              controller: addressController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  hintText: 'Address', label: Text('Address')),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(validation(nameController.text, ageController.text, dobController.text, emailController.text, mobileController.text, fatherController.text, motherController.text, addressController.text)){
                  Navigator.pushNamed(context, '/user_details',arguments: {
                    'name': nameController.text,
                    'age': ageController.text,
                    'dob': dobController.text,
                    'email': emailController.text,
                    'mobile': mobileController.text,
                    'father': fatherController.text,
                    'mother': motherController.text,
                    'address': addressController.text
                  });
                }
              },
              child: const Text("Submit Details")
            )
          ],
        ),
      ),
    );
  }

  bool validation(String name, String age, String dob, String email, String mobile, String fatherName, String motherName, String address){
    if(name.isEmpty){
      showSnackBar('please provide the name', context);
      return false;
    } else if(age.isEmpty){
      showSnackBar('please provide age', context);
      return false;
    } else if(dob.isEmpty){
      showSnackBar('please provide dob', context);
      return false;
    } else if(email.isEmpty){
      showSnackBar('please provide the email', context);
      return false;
    } else if(mobile.isEmpty){
      showSnackBar('please provide mobile number', context);
      return false;
    } else if(fatherName.isEmpty){
      showSnackBar('please provide father name', context);
      return false;
    } else if(motherName.isEmpty){
      showSnackBar('please provide mother name', context);
      return false;
    } else if(address.isEmpty){
      showSnackBar('please provide address', context);
      return false;
    }
    return true;
  }


}
