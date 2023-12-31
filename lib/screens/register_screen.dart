import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/services/utils.dart';
import 'package:my_app/widgets/text_form_field_register.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onClickedSignIn;

  const RegisterScreen({
    super.key,
    required this.onClickedSignIn,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 120),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Sign Up!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Text(
                        " Create your account",
                        style: TextStyle(
                          color: Color.fromARGB(255, 144, 140, 140),
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        " and begin a fitness journey",
                        style: TextStyle(
                          color: Color.fromARGB(255, 144, 140, 140),
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        " for optimal health",
                        style: TextStyle(
                          color: Color.fromARGB(255, 144, 140, 140),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormFieldCustom(
                          obscureText: false,
                          controller: emailController,
                          hintText: 'Email',
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                        ),
                        TextFormFieldCustom(
                          obscureText: true,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            } else if (!RegExp("^(?=.*[A-Z]).*")
                                .hasMatch(value)) {
                              return 'Should contain at least one upper case';
                            } else if (!RegExp("^(?=.*[a-z]).*")
                                .hasMatch(value)) {
                              return 'Should contain at least one lower case';
                            } else if (!RegExp("^(?=.*[0-9]).*")
                                .hasMatch(value)) {
                              return 'Should contain at least one digit';
                            } else if (!RegExp(
                              r"^(?=.*[!@#$%^&*(),.?:{}|<>]).*",
                            ).hasMatch(value)) {
                              return 'Should contain at least one Special character';
                            } else if (value.trim().length < 8) {
                              return 'Must be at least 8 characters in length';
                            }
                            return null;
                          },
                          hintText: 'Password',
                        ),
                        TextFormFieldCustom(
                          obscureText: true,
                          controller: confirmPasswordController,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Enter min. 6 characters'
                                  : passwordController.text != value
                                      ? "Not Match"
                                      : null,
                          hintText: 'Confirm PassWord',
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: InkWell(
                    onTap: signUp,
                    child: Container(
                      height: 40,
                      width: 310,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 255, 101, 18),
                      ),
                      child: const Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                        child: const Divider(
                          color: Color.fromARGB(255, 245, 84, 15),
                          height: 30,
                          indent: 35,
                          thickness: 2,
                        ),
                      ),
                    ),
                    const Text("Or signup with"),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: const Divider(
                          color: Color.fromARGB(255, 245, 84, 15),
                          endIndent: 32,
                          thickness: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 194, 194, 194),
                          ),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 0.5,
                              spreadRadius: 0.5, // blur radius
                              offset: const Offset(1.0, 2.0),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              backgroundImage:
                                  AssetImage('assets/images/google.png'),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 194, 194, 194),
                          ),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 0.5,
                              spreadRadius: 0.5, // blur radius
                              offset: const Offset(1.0, 2.0),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              backgroundImage:
                                  AssetImage('assets/images/facebook.png'),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 194, 194, 194),
                          ),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 0.5,
                              spreadRadius: 0.5, // blur radius
                              offset: const Offset(1.0, 2.0),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              backgroundImage:
                                  AssetImage('assets/images/apple-logo.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Already a user? ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 149, 149, 149),
                        ),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Utils().showSnackBar(e.message);
    }

    GlobalKey<NavigatorState>()
        .currentState!
        .popUntil((route) => route.isFirst);
  }
}
