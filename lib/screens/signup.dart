import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screens/Login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                    padding: EdgeInsets.only(left: 20, bottom: 50),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                ],
              ),
              const Text(
                'Sign Up!',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 80),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Username, Phone Number',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 183, 182, 182),
                          ),
                          contentPadding: const EdgeInsets.only(bottom: 1.0)
                              .add(const EdgeInsets.symmetric(horizontal: 10)),
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
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 183, 182, 182),
                          ),
                          contentPadding: const EdgeInsets.only(bottom: 1.0)
                              .add(const EdgeInsets.symmetric(horizontal: 10)),
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
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 183, 182, 182),
                          ),
                          contentPadding: const EdgeInsets.only(bottom: 1.0)
                              .add(const EdgeInsets.symmetric(horizontal: 10)),
                          suffixIcon: const Align(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
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
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const AccountScreen()),
                    // );
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
                const Text("Or signup with"),
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
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Already a user? ',
                        style: TextStyle(
                            color: Color.fromARGB(255, 149, 149, 149))),
                    TextSpan(
                      text: 'Login',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 149, 149),
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
