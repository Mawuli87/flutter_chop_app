import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/common/widgets/custom_textField.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';

enum Auth { sigin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

//sign up user connected to auth_service class
  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

//sign in user connected to auth_service class
  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to Flutter Node.js",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            ListTile(
              tileColor: _auth == Auth.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Sign Up",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  }),
            ),
            if (_auth == Auth.signup)
              Container(
                padding: const EdgeInsets.all(6.0),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(children: [
                    CustomTextField(
                      controller: _nameController,
                      hintText: "Enter name",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Enter email",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Enter password",
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        text: "Sign up",
                        onTap: () {
                          if (_signUpFormKey.currentState!.validate()) {
                            signUpUser();
                          }
                        })
                  ]),
                ),
              ),
            if (_auth == Auth.sigin)
              Container(
                padding: const EdgeInsets.all(6.0),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signInFormKey,
                  child: Column(children: [
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Enter email",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Enter password",
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        text: "Sign In",
                        onTap: () {
                          if (_signInFormKey.currentState!.validate()) {
                            signInUser();
                          }
                        })
                  ]),
                ),
              ),
            ListTile(
              tileColor: _auth == Auth.sigin
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Sign In",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.sigin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
