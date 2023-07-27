import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/screens/create.dart';

import '../models/todo.dart';

final List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final todoList = Todo.todoList();

  @override
  void initState() {
    super.initState();
  }

  String? selectedValue;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          padding: const EdgeInsets.only(left: 15, right: 5),
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    height: 150,
                    width: 400,
                    child: SingleChildScrollView(
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2.5,
                                  // ignore: prefer_const_constructors
                                  color: Color.fromARGB(255, 255, 216, 86)),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/avatar.jpg'),
                              ),
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                          // ignore: prefer_const_constructors
                          Expanded(
                            child: SingleChildScrollView(
                              child: Row(
                                children: [
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 40),
                                            child: RichText(
                                              text: const TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: "Hello,",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  TextSpan(
                                                      text: " Minh Trí",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 255, 101, 18),
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            'Manage your tasks!',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 171, 171, 171),
                                              fontSize: 10,
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            width: 180,
                                            height: 30,
                                            child: TextFormField(
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: "Search",
                                                hintStyle: const TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromARGB(
                                                      255, 171, 171, 171),
                                                ),
                                                prefix: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  transform:
                                                      Matrix4.translationValues(
                                                          0.0, 2, 0.0),
                                                  child: const Icon(
                                                    Icons.search,
                                                    size: 13,
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // IconButton(
                          //   padding: const EdgeInsets.only(bottom: 50),
                          //   iconSize: 40,
                          //   icon: const Icon(Icons.more_vert),
                          //   onPressed: () => FirebaseAuth.instance.signOut(),
                          // ),
                          // Container(
                          //   padding: const EdgeInsets.only(bottom: 50),
                          //   child: DropdownButton<String>(
                          //     icon: const Icon(Icons.more_vert),
                          //     elevation: 16,
                          //     style: const TextStyle(color: Colors.deepPurple),
                          //     underline: Container(
                          //       height: 2,
                          //       color: Colors.deepPurpleAccent,
                          //     ),
                          //     items: list.map<DropdownMenuItem<String>>(
                          //         (String value) {
                          //       return DropdownMenuItem<String>(
                          //         value: value,
                          //         child: Text(value),
                          //       );
                          //     }).toList(),
                          //     onChanged: (String? value) {
                          //       // This is called when the user selects an item.
                          //       setState(() {
                          //         dropdownValue = value!;
                          //       });
                          //     },
                          //   ),
                          // )
                          DropdownButtonHideUnderline(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: DropdownButton2(
                                customButton: const Icon(
                                  Icons.more_vert,
                                  size: 40,
                                  color: Colors.black,
                                ),
                                customItemsHeights: null,
                                items: [
                                  ...MenuItems.firstItems.map(
                                    (item) => DropdownMenuItem<MenuItem>(
                                      value: item,
                                      child: MenuItems.buildItem(item),
                                    ),
                                  ),
                                  const DropdownMenuItem<Divider>(
                                      enabled: false, child: Divider()),
                                  ...MenuItems.secondItems.map(
                                    (item) => DropdownMenuItem<MenuItem>(
                                      value: item,
                                      child: MenuItems.buildItem(item),
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  MenuItems.onChanged(
                                      context, value as MenuItem);
                                },
                                itemHeight: 40,
                                dropdownWidth: 140,
                                dropdownPadding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: null,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Last added',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        return ItemTodo(
                          title: todoList[index].todoText,
                          task: todoList[index].testlist,
                          color: todoList[index].color,
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(5),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Tasks list',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    height: 350,
                    child: ListView.builder(
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        return ItemTodo(
                          title: todoList[index].todoText,
                          color: todoList[index].color,
                          task: todoList[index].testlist,
                          percent: '75%',
                        );
                      },
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateTodoScreen()),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 250,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: const Text(
                            'Create task',
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _addTodoItem(String toDo) {
  //   setState(() {
  //     todoList.add(Todo(
  //         id: DateTime.now().millisecondsSinceEpoch.toString(),
  //         todoText: toDo, color: toDo));
  //   });
  //   _todoController.clear();
  // }
}

class ItemTodo extends StatelessWidget {
  final String? title;
  final Color color;
  final String? percent;
  final String? task;
  const ItemTodo({
    super.key,
    this.title,
    required this.color,
    this.percent,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 160,
        margin: EdgeInsets.only(
          right: 10,
          bottom: percent != null ? 15 : 0,
        ),
        padding: const EdgeInsets.only(bottom: 1.0)
            .add(const EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 1.0,
              spreadRadius: 1.0, // blur radius
              offset: const Offset(0.0, 0.0),
            )
          ],
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            percent == null
                ? const SizedBox()
                : SizedBox(
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          child: CircularProgressIndicator(
                            value: 0.75,
                            backgroundColor: color.withOpacity(0.5),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                color.withOpacity(0.5)),
                          ),
                        ),
                        Center(
                          heightFactor: 2.2,
                          widthFactor: 1.6,
                          child: Text(
                            percent.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Text(
                      task ?? "",
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              height: 50,
              width: 5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, share, settings];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Home', icon: Icons.home);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Icon(item.icon, color: Colors.white, size: 22),
          const SizedBox(
            width: 10,
          ),
          Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
        //Do something
        break;
      case MenuItems.settings:
        //Do something
        break;
      case MenuItems.share:
        //Do something
        break;
      case MenuItems.logout:
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MainPage(
              isLogin: true,
            ),
          ),
        );
        break;
    }
  }
}
