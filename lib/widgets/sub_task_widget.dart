import 'package:flutter/material.dart';


class SubTaskWidget extends StatelessWidget {
  final TextEditingController subTaskController;
  const SubTaskWidget({
    super.key,
    required this.subTaskController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sub-task name',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 50,
          child: TextFormField(
            controller: subTaskController,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 1.0)
                  .add(const EdgeInsets.symmetric(horizontal: 10)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
