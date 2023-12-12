import 'dart:async';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/app_bloc.dart';
import 'package:my_app/bloc/todo_bloc.dart';
import 'package:my_app/bloc/user_bloc.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/models/userRef.dart';
import 'package:my_app/screens/create_todo_screen.dart';
import 'package:my_app/widgets/drawerController.dart';
import 'package:my_app/widgets/item_todo.dart';
import 'package:sizer/sizer.dart';

final List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String? selectedValue;
  Timer? _debounce;
  String searchKey = "";
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      key: _key,
      endDrawer: DrawerWidget(),
      body: GestureDetector(
        onTap: () {
          if (FocusManager.instance.primaryFocus?.hasFocus ?? false) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            UserRef? userRef;

            if (state is GetDoneUserState) {
              userRef = state.userRef;
            }

            if (userRef == null) return SizedBox();

            return SingleChildScrollView(
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
                                      color: Color(0xFFFFD856),
                                    ),
                                    image: DecorationImage(
                                      image: userRef.avatar.isNotEmpty
                                          ? NetworkImage(userRef.avatar)
                                              as ImageProvider<Object>
                                          : AssetImage(
                                              'assets/images/avatar.jpg',
                                            ),
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 40,
                                                    ),
                                                    child: RichText(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: "Hello, ",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: userRef
                                                                    .fullname
                                                                    .isNotEmpty
                                                                ? userRef
                                                                    .fullname
                                                                : "User",
                                                            style: TextStyle(
                                                              color: Color(
                                                                0xFFFF6512,
                                                              ),
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
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
                                                        const EdgeInsets.only(
                                                      top: 10,
                                                    ),
                                                    width: 180,
                                                    height: 30,
                                                    child: TextFormField(
                                                      controller:
                                                          _searchController,
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                      onChanged: (val) {
                                                        setState(() {
                                                          searchKey = val;
                                                        });
                                                        if (_debounce
                                                                ?.isActive ??
                                                            false)
                                                          _debounce?.cancel();
                                                        _debounce = Timer(
                                                            const Duration(
                                                              milliseconds:
                                                                  1000,
                                                            ), () {
                                                          AppBloc.todoBloc.add(
                                                            SearchTodosEvent(
                                                              searchKey:
                                                                  searchKey,
                                                            ),
                                                          );
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Search",
                                                        hintStyle:
                                                            const TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                              Color(0xFFABABAB),
                                                        ),
                                                        prefixIconConstraints:
                                                            BoxConstraints(
                                                          maxWidth: 40.sp,
                                                        ),
                                                        prefixIcon: Container(
                                                          width: 9.sp,
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: 7.sp,
                                                            right: 4.sp,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                'assets/icons/ic_search.png',
                                                              ),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                        suffixIconConstraints:
                                                            BoxConstraints(
                                                          maxWidth: 40.sp,
                                                        ),
                                                        suffixIcon: searchKey
                                                                .isEmpty
                                                            ? null
                                                            : GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    searchKey =
                                                                        "";
                                                                    _searchController
                                                                        .clear();
                                                                  });
                                                                  AppBloc
                                                                      .todoBloc
                                                                      .add(
                                                                    SearchTodosEvent(
                                                                      searchKey:
                                                                          searchKey,
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 9.sp,
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 2.sp,
                                                                    right: 8.sp,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .close_rounded,
                                                                    size: 9.sp,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
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
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 8,
                        ),
                        BlocBuilder<TodoBloc, TodoState>(
                          builder: (context, state) {
                            List<Todo> listTodo = [];
                            String searchKey = "";
                            if (state is GetDoneTodoState) {
                              listTodo = state.todos ?? [];
                              searchKey = state.searchKey;
                            }

                            return listTodo.length < 2 || searchKey.isNotEmpty
                                ? SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                        child: CarouselSlider.builder(
                                          options: CarouselOptions(
                                            height: 80,
                                            autoPlay: true,
                                            viewportFraction: 0.85,
                                            autoPlayInterval:
                                                Duration(seconds: 3),
                                          ),
                                          itemCount: min(listTodo.length, 5),
                                          itemBuilder:
                                              (context, index, realIndex) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 4.sp,
                                              ),
                                              child: ItemTodo(
                                                title: listTodo[index].todoText,
                                                color: listTodo[index].color,
                                                percent: '75%',
                                                countTask: listTodo[index]
                                                    .subTask
                                                    ?.length
                                                    .toString(),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CreateTodoScreen(
                                                        todo: listTodo[index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                          },
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
                          child: BlocBuilder<TodoBloc, TodoState>(
                            builder: (context, state) {
                              List<Todo> listTodo = [];
                              if (state is GetDoneTodoState) {
                                listTodo = state.todos ?? [];
                              }

                              return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: listTodo.length,
                                padding:
                                    EdgeInsets.only(bottom: 40.sp, top: 15.sp),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onLongPress: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: Colors.white,
                                          surfaceTintColor: Colors.white,
                                          title: const Text(
                                            'Are you sure want to delete it?',
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                context,
                                                'Cancel',
                                              ),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                AppBloc.todoBloc.add(
                                                  DeleteTodoEvent(
                                                    todoId:
                                                        listTodo[index].id ??
                                                            "",
                                                    context: context,
                                                  ),
                                                );
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
                                              builder: (context) =>
                                                  CreateTodoScreen(
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
            );
          },
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.,
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
    );
  }
}
