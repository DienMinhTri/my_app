import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/repository/user_res.dart';
import 'package:my_app/screens/account_screen.dart';
import 'package:my_app/screens/my_profile_screen.dart';
import 'package:my_app/widgets/edit_avatar.dart';
import 'package:my_app/models/userRef.dart';

class EditProfileScreen extends StatefulWidget {
  final UserRef? userRef;

  const EditProfileScreen({
    super.key,
    this.userRef,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _dateController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameUserController = TextEditingController();
  final _secondNameUserController = TextEditingController();
  final _passwordController = TextEditingController();

  UserRef? userRef;

  bool? _passwordVisible;
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameUserController.dispose();
    _secondNameUserController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
    _dateController.text = DateTime.now().toString();
    if (widget.userRef != null) {
      userRef = widget.userRef;
      _dateController.text = userRef?.date ?? DateTime.now().toString();
      _emailController.text = userRef?.email ?? "";
      _firstNameUserController.text = userRef?.firstName ?? "";
      _secondNameUserController.text = userRef?.secondName ?? "";
      _passwordController.text = userRef?.password ?? "";
    } else {
      _dateController.text = '';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      final String str = DateFormat('dd/MM/yyyy').format(date);
      setState(() {
        _dateController.text = str;
      });
    }
  }

  Future addUserDetails(
    String firstName,
    String secondName,
    String email,
    String password,
  ) async {
    await FirebaseFirestore.instance.collection('users').add(
      {
        'first name': firstName,
        'second name': secondName,
        'email': email,
        'password': password,
      },
    );
  }

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Material(
        child: ColoredBox(
          color: Colors.white,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 85),
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20)
                        .add(const EdgeInsets.symmetric(horizontal: 30)),
                    child: Column(
                      children: [
                        const EditAvatarWidget(),
                        const SizedBox(
                          width: 15,
                        ),
                        Center(
                          child: Column(
                            children: [
                              const Text(
                                "Điền Minh Trí",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Mobile Developer",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email Address',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        TextFormField(
                          controller: _emailController,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: user!.email.toString(),
                          ),
                          validator: (email) {
                            if (email!.isEmpty ||
                                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(email)) {
                              return "Enter Correct Email Address";
                            } else {
                              return null;
                            }
                          },
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'First Name',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        TextFormField(
                          controller: _firstNameUserController,
                          validator: (username) {
                            if (username!.isEmpty ||
                                !RegExp(r'^[a-z A-Z]+$').hasMatch(username)) {
                              return "Enter Correct Name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Second Name',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        TextFormField(
                          controller: _secondNameUserController,
                          validator: (username) {
                            if (username!.isEmpty ||
                                !RegExp(r'^[a-z A-Z]+$').hasMatch(username)) {
                              return "Enter Correct Name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible!,
                          validator: (password) {
                            if (password!.isEmpty) {
                              return 'Please enter your password';
                            } else if (!RegExp(
                              "^(?=.*[A-Z]).*",
                            ).hasMatch(password)) {
                              return 'Should contain at least one upper case';
                            } else if (!RegExp(
                              "^(?=.*[a-z]).*",
                            ).hasMatch(password)) {
                              return 'Should contain at least one lower case';
                            } else if (!RegExp(
                              "^(?=.*[0-9]).*",
                            ).hasMatch(password)) {
                              return 'Should contain at least one digit';
                            } else if (!RegExp(
                              r"^(?=.*[!@#$%^&*(),.?:{}|<>]).*",
                            ).hasMatch(password)) {
                              return 'Should contain at least one Special character';
                            } else if (password.trim().length < 8) {
                              return 'Must be at least 8 characters in length';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible!
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              color: Colors.black.withOpacity(0.5),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible!;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Birth Date (Optional)',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          controller: _dateController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.calendar_month,
                              ),
                              color: Colors.black.withOpacity(0.5),
                              onPressed: () {
                                setState(() {
                                  _selectDate(context);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 40),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          _form.currentState!.validate();
                          userRef = UserRef(
                            email: user?.email.toString(),
                            firstName: _firstNameUserController.text,
                            secondName: _secondNameUserController.text,
                            password: _passwordController.text,
                            date: _dateController.text,
                          );
                          if (widget.userRef == null) {
                            UserRes().createUser(userRef!);
                          } else {
                            UserRes()
                                .updateUser(widget.userRef?.id ?? "", userRef!);
                          }
                          ;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyProfileScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
