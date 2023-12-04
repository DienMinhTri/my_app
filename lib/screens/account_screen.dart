import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/repository/todo_repository.dart';
import 'package:my_app/screens/create_todo_screen.dart';
import 'package:my_app/screens/my_profile_screen.dart';
import 'package:my_app/screens/settings_screen.dart';
import 'package:my_app/screens/statistic_todo_chart.dart';
import 'package:my_app/widgets/drawerController.dart';
import 'package:my_app/widgets/item_todo.dart';

final List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
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
      endDrawerEnableOpenDragGesture: false,
      key: _key,
      endDrawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
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
                                color: Color.fromARGB(255, 255, 216, 86),
                              ),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/avatar.jpg'),
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Row(
                                children: [
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
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
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: " Minh Trí",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        101,
                                                        18,
                                                      ),
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            'Manage your tasks!',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                255,
                                                171,
                                                171,
                                                171,
                                              ),
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
                                                    255,
                                                    171,
                                                    171,
                                                    171,
                                                  ),
                                                ),
                                                prefix: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 5,
                                                  ),
                                                  transform:
                                                      Matrix4.translationValues(
                                                    0.0,
                                                    2,
                                                    0.0,
                                                  ),
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
                                                    18,
                                                  ),
                                                ),
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
                          IconButton(
                            onPressed: () {
                              _key.currentState!.openEndDrawer();
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              size: 40,
                            ),
                          )
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
                    child: FutureBuilder<List<Todo>?>(
                      future: TodoReposity().getTodo(),
                      builder: (context, snapshot) {
                        final List<Todo> listTodo = snapshot.data ?? [];

                        if (listTodo.isEmpty) return const SizedBox();

                        return CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 80,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                          ),
                          itemCount: listTodo.length,
                          itemBuilder: (context, index, realIndex) {
                            return ItemTodo(
                              title: listTodo[index].todoText,
                              color: listTodo[index].color,
                              countTask:
                                  listTodo[index].subTask?.length.toString(),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateTodoScreen(
                                      todo: listTodo[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
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
                    height: 450,
                    child: FutureBuilder<List<Todo>?>(
                      future: TodoReposity().getTodo(),
                      builder: (context, snapshot) {
                        final List<Todo> listTodo = snapshot.data ?? [];

                        if (listTodo.isEmpty) return const SizedBox();

                        return ListView.builder(
                          itemCount: listTodo.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onLongPress: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      'Are you sure want to delete it?',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            TodoReposity().deleteTodo(
                                              id: snapshot.data?[index].id ??
                                                  "",
                                            );
                                          });
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: GestureDetector(
                                child: ItemTodo(
                                  title: listTodo[index].todoText,
                                  color: listTodo[index].color,
                                  countTask: listTodo[index]
                                      .subTask
                                      ?.length
                                      .toString(),
                                  percent: '75%',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CreateTodoScreen(
                                          todo: listTodo[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateTodoScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 32,
        ),
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.yellow,
        shape: CircleBorder(),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: EdgeInsets.symmetric(vertical: 5),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.home,
                color: Colors.amber,
              ),
              style: ButtonStyle(
                iconSize: MaterialStatePropertyAll(30),
              ),
            ),
            IconButton(
              padding: EdgeInsets.symmetric(vertical: 5)
                  .add(EdgeInsets.only(right: 30)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StatisticTodoScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.bar_chart_sharp,
                color: Colors.amber,
              ),
              style: ButtonStyle(
                iconSize: MaterialStatePropertyAll(30),
              ),
            ),
            IconButton(
              padding: EdgeInsets.symmetric(vertical: 5)
                  .add(EdgeInsets.only(left: 30)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.account_box_sharp,
                color: Colors.amber,
              ),
              style: ButtonStyle(
                iconSize: MaterialStatePropertyAll(30),
              ),
            ),
            IconButton(
              padding: EdgeInsets.symmetric(vertical: 5),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfileScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.settings,
                color: Colors.amber,
              ),
              style: ButtonStyle(
                iconSize: MaterialStatePropertyAll(30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
