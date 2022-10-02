import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_hive/data/local_data.dart';
import 'package:todo_hive/util/dialog_box.dart';
import 'package:todo_hive/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //ref box
  final _myBox = Hive.box('mybox');
  final _controller = TextEditingController();
  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.getData();
    }

    super.initState();
  }

  ToDoData db = ToDoData();
  void checkBoxChanged(
    bool? value,
    int index,
  ) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });

    db.updateData();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);

      _controller.clear();
    });
    Navigator.of(this.context).pop();
    db.updateData();
  }

  void createNewTask() {
    showDialog(
      context: this.context,
      builder: (context) => DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     onPressed: null,
        //     icon: Icon(
        //       Icons.image,
        //       color: Colors.amber,
        //     ),
        //   ),
        // ],
        title: const Center(
            child: Text(
          'To Do',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.amberAccent,
          ),
        )),
        elevation: 0.3,
        backgroundColor: Colors.black38,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          createNewTask();
          _controller.clear();
        },
        child: const Icon(
          Icons.add,
          color: Colors.amber,
        ),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (
          context,
          index,
        ) =>
            ToDoTile(
          taskName: db.toDoList[index][0],
          taskCompleted: db.toDoList[index][1],
          onChange: (value) => checkBoxChanged(
            value,
            index,
          ),
          deleteFunction: (context) => deleteTask(index),
        ),
      ),
    );
  }
}
