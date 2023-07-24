import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screens/account.dart';
import 'package:my_app/services/auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 100),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                ],
              ),
              const Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Lorem ipsum dolor consectetur.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 144, 140, 140),
                      ),
                    ),
                    Text(
                      "Egestas arcu tortor purus.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 144, 140, 140),
                      ),
                    ),
                    Text(
                      "Libero sit arcu sed.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 144, 140, 140),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 80),
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          decoration: InputDecoration(
                            hintText: 'Username, Phone Number',
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 183, 182, 182),
                            ),
                            contentPadding: const EdgeInsets.only(bottom: 1.0)
                                .add(
                                    const EdgeInsets.symmetric(horizontal: 10)),
                            suffixIcon: const Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          validator: (val) => val!.length < 6
                              ? 'Enter an password 6+ chars long'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 183, 182, 182),
                            ),
                            contentPadding: const EdgeInsets.only(bottom: 1.0)
                                .add(
                                    const EdgeInsets.symmetric(horizontal: 10)),
                            suffixIcon: const Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 70),
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Color.fromARGB(255, 144, 140, 140),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final User? result = await _authService
                          .loginWithEmailAndPassword(email, password);

                      if (result == null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: const Text('Đăng nhập thất bại'),
                            actions: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.blue,
                                    ),
                                    child: const Text(
                                      'Đã hiểu',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AccountScreen(),
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 310,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 255, 101, 18),
                    ),
                    child: const Text(
                      'Log In',
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
              const Padding(padding: EdgeInsets.only(top: 20)),
              Row(children: <Widget>[
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: const Divider(
                        color: Color.fromARGB(255, 245, 84, 15),
                        height: 30,
                        indent: 35,
                        thickness: 2,
                      )),
                ),
                const Text("Or login with"),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: const Divider(
                        color: Color.fromARGB(255, 245, 84, 15),
                        height: 30,
                        endIndent: 32,
                        thickness: 2,
                      )),
                ),
              ]),
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
                            color: const Color.fromARGB(255, 194, 194, 194)),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 0.5,
                            spreadRadius: 0.5, // blur radius
                            offset: const Offset(1.0, 2.0),
                          )
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
                          )),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 194, 194, 194)),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 0.5,
                            spreadRadius: 0.5, // blur radius
                            offset: const Offset(1.0, 2.0),
                          )
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
                          )),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 194, 194, 194)),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 0.5,
                            spreadRadius: 0.5, // blur radius
                            offset: const Offset(1.0, 2.0),
                          )
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
                          )),
                    ),
                  ],
                ),
              ),
              // RichText(
              //   text: TextSpan(
              //     children: [
              //       const TextSpan(
              //           text: 'Already a user? ',
              //           style: TextStyle(color: Colors.black)),
              //       TextSpan(
              //         text: 'Login',
              //         style: const TextStyle(
              //           color: Colors.blue,
              //           decoration: TextDecoration.underline,
              //         ),
              //         recognizer: TapGestureRecognizer()
              //           ..onTap = () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => const AccountScreen()),
              //             );
              //           },
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
