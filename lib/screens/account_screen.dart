import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/screens/create_todo_screen.dart';
import 'package:my_app/widgets/item_todo.dart';
import 'package:my_app/widgets/menu_items.dart';

final List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final todoList = Todo.todoList();
  List<dynamic> data = [];

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
                          countTask: (todoList[index].toDoList ?? [])
                              .length
                              .toString(),
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
                          countTask: (todoList[index].toDoList ?? [])
                              .length
                              .toString(),
                          percent: '75%',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateTodoScreen(
                                  todo: todoList[index],
                                ),
                              ),
                            );
                          },
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
                              builder: (context) => const CreateTodoScreen(),
                            ),
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
}