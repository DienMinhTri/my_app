import 'package:flutter/material.dart';

class ItemTodo extends StatelessWidget {
  final String? title;
  final Color color;
  final String? percent;
  final String? countTask;
  final Function()? onTap;
  const ItemTodo({
    super.key,
    this.title,
    required this.color,
    this.percent,
    this.countTask,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateColor.resolveWith((states) => Colors.white),
      onTap: onTap,
      child: Container(
        width: percent != null ? null : 160,
        margin: EdgeInsets.only(
          right: 5,
          left: 5,
          bottom: percent != null ? 15 : 0,
        ),
        padding: const EdgeInsets.only(bottom: 1.0).add(
          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(percent != null ? 15 : 30),
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
                : Stack(
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
                      "${countTask ?? "0"} tasks",
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
