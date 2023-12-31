// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/bloc/app_bloc.dart';
import 'package:my_app/bloc/todo_bloc.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/screens/account_screen.dart';
import 'package:my_app/widgets/item_priority_widget.dart';
import 'package:my_app/widgets/sub_task_widget.dart';
import 'package:my_app/widgets/text_style_widget.dart';
import 'package:sizer/sizer.dart';

class CreateTodoScreen extends StatefulWidget {
  final Todo? todo;
  const CreateTodoScreen({
    super.key,
    this.todo,
  });

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final TextEditingController _dateController = TextEditingController();
  final _taskNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  int status = 1;

  final List<TextEditingController> _listSubTaskController = [];
  Todo? todo;
  final List<String> priorities = ['High', 'Medium', 'Low'];

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      todo = widget.todo;
      _dateController.text = todo?.date ?? DateTime.now().toString();
      _taskNameController.text = todo?.todoText ?? "";
      status = todo?.status ?? 0;
      _descriptionController.text = todo?.description ?? "";
      for (final subtask in todo?.subTask ?? []) {
        final subTaskController = TextEditingController();
        subTaskController.text = subtask;
        _listSubTaskController.add(subTaskController);
      }
    } else {
      _dateController.text = '';
      final subTaskController = TextEditingController();
      _listSubTaskController.add(subTaskController);
    }
  }

  _handleAddSubTask() {
    final subTaskController = TextEditingController();
    _listSubTaskController.add(subTaskController);
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2001),
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
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: _key,
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Text(
                              '${widget.todo != null ? 'Edit' : 'Create'} new task',
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleWidget(
                          title: 'Main task name',
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 52.sp,
                          child: TextFormField(
                            validator: (val) {
                              if (val?.isEmpty ?? true) {
                                return "Please enter task name";
                              }

                              return null;
                            },
                            controller: _taskNameController,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(bottom: 1.0).add(
                                const EdgeInsets.symmetric(horizontal: 10),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const TitleWidget(
                          title: 'Due date',
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 52.sp,
                              child: TextFormField(
                                readOnly: true,
                                enabled: true,
                                validator: (val) {
                                  if (val?.isEmpty ?? true) {
                                    return "Please enter due date";
                                  }

                                  return null;
                                },
                                onTap: () {
                                  print("hihi");
                                  _selectDate(context);
                                },
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                controller: _dateController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 1.0).add(
                                    const EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                  suffixIcon: Align(
                                    widthFactor: 1.0,
                                    heightFactor: 1.0,
                                    child: IconButton(
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                      icon: const Icon(Icons.calendar_month),
                                      color: Color.fromRGBO(255, 115, 0, 1),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const TitleWidget(
                          title: 'Choose priority',
                        ),
                        SizedBox(height: 5.sp),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly, // <-- SEE HERE
                          children: List.generate(
                            priorities.length,
                            (index) => ItemPriority(
                              onPress: () {
                                setState(() {
                                  status = index;
                                });
                              },
                              title: priorities[index],
                              color: status == index
                                  ? index == 2
                                      ? Colors.greenAccent
                                      : index == 0
                                          ? Colors.redAccent
                                          : Colors.orangeAccent
                                  : Colors.white,
                            ),
                          ),
                        ),
                        Column(
                          children: List.generate(
                            _listSubTaskController.length,
                            (index) => SubTaskWidget(
                              subTaskController: _listSubTaskController[index],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  _handleAddSubTask();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(240, 178, 44, 1),
                                ),
                                child: const Text(
                                  'Add sub-task',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const TitleWidget(
                              title: 'Description',
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            TextFormField(
                              controller: _descriptionController,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLength: 100,
                              maxLines: 3,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (!_formKey.currentState!.validate())
                                    return;

                                  todo = Todo(
                                    id: todo?.id ??
                                        DateTime.now()
                                            .microsecondsSinceEpoch
                                            .toString(),
                                    todoText: _taskNameController.text,
                                    date: _dateController.text,
                                    status: status,
                                    countTask: _listSubTaskController.length,
                                    subTask: _listSubTaskController
                                        .map((controller) => controller.text)
                                        .toList(),
                                    description: _descriptionController.text,
                                    userId: todo?.userId ??
                                        AppBloc.userBloc.userRef?.id,
                                  );

                                  if (widget.todo == null) {
                                    AppBloc.todoBloc
                                        .add(CreateTodoEvent(todo: todo!));
                                  } else {
                                    AppBloc.todoBloc
                                        .add(UpdateTodoEvent(todo: todo!));
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AccountScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 22,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 252, 113, 0),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${widget.todo != null ? 'Edit' : 'Add'} task',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  for (final controller
                                      in _listSubTaskController) {
                                    controller.clear();
                                  }
                                  _taskNameController.clear();
                                  _dateController.clear();
                                  _descriptionController.clear();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 30,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA8A8A8),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Clear',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
