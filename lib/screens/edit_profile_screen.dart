import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/widgets/edit_avatar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _dateController = TextEditingController();
  bool? _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
    _dateController.text = DateTime.now().toString();
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
    return Material(
      child: ColoredBox(
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 40,
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
                            size: 20,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 65),
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
                      TextFormField(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Username',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      TextFormField(),
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
                        obscureText: !_passwordVisible!,
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
                    ],
                  ),
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
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: TextButton(
                      onPressed: () {},
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
    );
  }
}
