import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/repository/todo_repository.dart';
import 'package:my_app/screens/account_screen.dart';
import 'package:my_app/widgets/item_priority_widget.dart';
import 'package:my_app/widgets/sub_task_widget.dart';
import 'package:my_app/widgets/text_style_widget.dart';

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

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      todo = widget.todo;
      _dateController.text = todo?.date ?? DateTime.now().toString();
      _taskNameController.text = todo?.todoText ?? "";
      status = todo?.status ?? 0;
      _descriptionController.text = todo?.description ?? "";
      for (var subtask in (todo?.subTask ?? [])) {
        final subTaskController = TextEditingController();
        subTaskController.text = subtask;
        _listSubTaskController.add((subTaskController));
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
      String str = DateFormat('dd/MM/yyyy').format(date);
      setState(() {
        _dateController.text = str;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '${widget.todo != null ? 'Edit' : 'Create'} new task',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const TitleWidget(
                title: 'Main task name',
              ),
              Container(
                alignment: Alignment.center,
                height: 50,
                child: TextFormField(
                  controller: _taskNameController,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 1.0)
                        .add(const EdgeInsets.symmetric(horizontal: 10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const TitleWidget(
                title: 'Due date',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: TextFormField(
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      controller: _dateController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 1.0)
                            .add(const EdgeInsets.symmetric(horizontal: 10)),
                        suffixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: IconButton(
                            onPressed: () {
                              _selectDate(context);
                            },
                            icon: const Icon(Icons.calendar_month),
                            color: const Color.fromARGB(255, 255, 115, 0),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
              const TitleWidget(
                title: 'Choose priority',
              ),
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
                          ? index == 0
                              ? Colors.redAccent
                              : index == 2
                                  ? Colors.greenAccent
                                  : Colors.orangeAccent
                          : Colors.white,
                    ),
                  )),
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
                            const Color.fromARGB(255, 240, 178, 44),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      todo = Todo(
                        id: "",
                        todoText: _taskNameController.text,
                        date: _dateController.text,
                        status: status,
                        countTask: _listSubTaskController.length,
                        subTask: _listSubTaskController
                            .map((controller) => controller.text)
                            .toList(),
                        description: _descriptionController.text,
                      );

                      TodoReposity().createTodo(todo!);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 22,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 252, 113, 0),
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
                      for (var controller in _listSubTaskController) {
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
                        color: const Color.fromARGB(255, 168, 168, 168),
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
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        iconSize: 40,
        icon: const Icon(Icons.navigate_before),
        tooltip: 'Go to the next page',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AccountScreen()),
          );
        },
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          iconSize: 40,
          icon: const Icon(Icons.more_vert),
          tooltip: 'Show Snackbar',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')));
          },
        ),
      ],
    );
  }
}
