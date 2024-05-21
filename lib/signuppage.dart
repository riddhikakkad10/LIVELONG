import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livelong_flutter/home.dart';
import 'package:livelong_flutter/uihelper.dart';
import 'workout_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String gender = '';

  double calculateBMI(int height, int weight) {
    final heightInMeters = height / 100.0;
    final bmi = weight / (heightInMeters * heightInMeters);
    return bmi;
  }

  signUp() async {
    if (emailController.text == "" ||
        passwordController.text == "" ||
        nameController.text == "" ||
        ageController.text == "" ||
        gender == "" ||
        heightController.text == "" ||
        weightController.text == "") {
      UiHelper.CustomAlertBox(context, "Enter all required fields");
    } else {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Calculate BMI
        double bmi = calculateBMI(
          int.parse(heightController.text),
          int.parse(weightController.text),
        );

        // Store user information in Firestore with BMI
        FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set({
          'name': nameController.text,
          'email': emailController.text,
          'age': int.parse(ageController.text),
          'gender': gender,
          'height': int.parse(heightController.text),
          'weight': int.parse(weightController.text),
          'bmi': bmi,
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 10),
                  Text(
                    "Hello, ${nameController.text}",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            UiHelper.CustomTextField(
              nameController,
              "Name",
              Icons.person,
              false,
              TextInputType.text,
              false,
            ),
            UiHelper.CustomTextField(
              emailController,
              "Email",
              Icons.mail,
              false,
              TextInputType.emailAddress,
              false,
            ),
            UiHelper.CustomTextField(
              passwordController,
              "Password",
              Icons.password,
              true,
              TextInputType.text,
              true,
            ),
            UiHelper.CustomTextField(
              ageController,
              "Age",
              Icons.date_range,
              false,
              TextInputType.number,
              false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                Text('Male'),
                Radio(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                Text('Female'),
                Radio(
                  value: 'Transgender',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                Text('Transgender'),
              ],
            ),
            UiHelper.CustomTextField(
              heightController,
              "Height (cm)",
              Icons.height,
              false,
              TextInputType.number,
              false,
            ),
            UiHelper.CustomTextField(
              weightController,
              "Weight (kg)",
              Icons.line_weight,
              false,
              TextInputType.number,
              false,
            ),
            SizedBox(height: 30),
            UiHelper.CustomButton(
                  () {
                signUp();
              },
              "Sign Up",
            ),
          ],
        ),
      ),
    );
  }
}