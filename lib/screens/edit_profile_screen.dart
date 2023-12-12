// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/bloc/app_bloc.dart';
import 'package:my_app/bloc/user_bloc.dart';
import 'package:my_app/widgets/edit_avatar.dart';
import 'package:my_app/models/userRef.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _form = GlobalKey<FormState>();
  String fullname = "";

  UserRef? userRef;
  File? _imageFile;

  @override
  void initState() {
    super.initState();

    _dateController.text = DateTime.now().toString();
    if (AppBloc.userBloc.userRef != null) {
      userRef = AppBloc.userBloc.userRef;
      _dateController.text = userRef?.date ?? DateTime.now().toString();
      _emailController.text = userRef?.email ?? "";
      _nameController.text = userRef?.fullname ?? "";
      _phoneNumberController.text = userRef?.phoneNumber ?? "";
      fullname = userRef?.fullname ?? "User";
    } else {
      _dateController.text = '';
      fullname = 'User';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _dateController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusManager.instance.primaryFocus?.hasFocus ?? false) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Form(
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
                          EditAvatarWidget(
                            avatar: userRef?.avatar,
                            hanldePickedImage: (imagePicker) {
                              setState(() {
                                _imageFile = imagePicker;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  fullname.isEmpty ? "User" : fullname,
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
                              hintText: userRef!.email.toString(),
                            ),
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Full Name',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.3),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          TextFormField(
                            controller: _nameController,
                            onChanged: (val) {
                              setState(() {
                                fullname = val.isEmpty ? "User" : val;
                              });
                            },
                            validator: (username) {
                              if (username == null || username.isEmpty) {
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
                            'Phone number',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.3),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _phoneNumberController,
                            validator: (val) {
                              if (val == null ||
                                  val.isEmpty ||
                                  val.length < 9 ||
                                  val.length > 12) {
                                return "Enter Correct Phone Number";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Text(
                          //   'Password',
                          //   style: TextStyle(
                          //     color: Colors.black.withOpacity(0.3),
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 15,
                          //   ),
                          // ),
                          // TextFormField(
                          //   controller: _passwordController,
                          //   obscureText: !_passwordVisible!,
                          //   validator: (password) {
                          //     if (password!.isEmpty) {
                          //       return 'Please enter your password';
                          //     } else if (!RegExp(
                          //       "^(?=.*[A-Z]).*",
                          //     ).hasMatch(password)) {
                          //       return 'Should contain at least one upper case';
                          //     } else if (!RegExp(
                          //       "^(?=.*[a-z]).*",
                          //     ).hasMatch(password)) {
                          //       return 'Should contain at least one lower case';
                          //     } else if (!RegExp(
                          //       "^(?=.*[0-9]).*",
                          //     ).hasMatch(password)) {
                          //       return 'Should contain at least one digit';
                          //     } else if (!RegExp(
                          //       r"^(?=.*[!@#$%^&*(),.?:{}|<>]).*",
                          //     ).hasMatch(password)) {
                          //       return 'Should contain at least one Special character';
                          //     } else if (password.trim().length < 8) {
                          //       return 'Must be at least 8 characters in length';
                          //     }
                          //     return null;
                          //   },
                          //   decoration: InputDecoration(
                          //     suffixIcon: IconButton(
                          //       icon: Icon(
                          //         _passwordVisible!
                          //             ? Icons.visibility_outlined
                          //             : Icons.visibility_off_outlined,
                          //       ),
                          //       color: Colors.black.withOpacity(0.5),
                          //       onPressed: () {
                          //         setState(() {
                          //           _passwordVisible = !_passwordVisible!;
                          //         });
                          //       },
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
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
                    Center(
                      child: Container(
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.only(top: 20),
                        // padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Center(
                          child: TextButton(
                            onPressed: () async {
                              _form.currentState!.validate();

                              userRef = UserRef(
                                id: userRef?.id ?? "",
                                email: _emailController.text,
                                date: _dateController.text,
                                fullname: _nameController.text,
                                phoneNumber: _phoneNumberController.text,
                                avatar: userRef?.avatar ?? "",
                              );

                              AppBloc.userBloc.add(
                                UpdateUserEvent(
                                  userRef: userRef!,
                                  image: _imageFile,
                                ),
                              );
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
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
      ),
    );
  }
}
