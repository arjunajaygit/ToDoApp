import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/Util/dialog_box.dart';
import 'package:myapp/data/databse.dart';

import '../Util/todo_tile.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDatabse db = ToDoDatabse();

  @override
  void initState() {
    // if this is the 1st time ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
  }


// text  controller
final _controller = TextEditingController();


  //checkbox was tapped

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }
// save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create a new task
  void createNewTask() {
    showDialog(context: context, builder: (context) {
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
        );
        },
    );
  }

//delete task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Center(child: Text("TO DO")),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(onPressed: createNewTask,backgroundColor: Colors.yellow,
      child: Icon(Icons.add),),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(taskName: db.toDoList[index][0], taskCompleted: db.toDoList[index][1], onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        }

      )
    );
  }
}
