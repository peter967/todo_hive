// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class ToDoTile extends StatefulWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChange;
  Function(BuildContext context)? deleteFunction;

  ToDoTile({
    Key? key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChange,
    required this.deleteFunction,
  }) : super(key: key);

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Shake! delete task ;)',
              style: TextStyle(
                color: Colors.amber,
              ),
            ),
          ),
        );
        setState(() {
          widget.deleteFunction!(context);
        });
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 600,
      shakeCountResetTime: 5000,
      shakeThresholdGravity: 2.7,
    );

    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 14, bottom: 1),
      child: Dismissible(
        resizeDuration: Duration(milliseconds: 200),
        direction: DismissDirection.startToEnd,
        background: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.delete_forever_sharp,
              color: Colors.amber,
            )),
        onDismissed: (direction) {
          widget.deleteFunction!(context);
        },
        key: UniqueKey(),
        child: Container(
          height: 60,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                value: widget.taskCompleted,
                onChanged: widget.onChange,
                activeColor: Colors.black,
              ),
              Expanded(
                child: Text(
                  widget.taskName,
                  style: TextStyle(
                    overflow: TextOverflow.fade,
                    decoration: widget.taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
