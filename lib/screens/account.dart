import 'package:flutter/material.dart';
import 'package:my_app/screens/create.dart';

import '../models/todo.dart';

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
                                          margin: const EdgeInsets.only(top:10),
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
                                                  padding: const EdgeInsets.only(right:5),
                                                  transform:  Matrix4.translationValues(0.0, 2, 0.0),
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
                        IconButton(
                          padding: const EdgeInsets.only(bottom: 50),
                          iconSize: 40,
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
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
