import 'package:flutter/material.dart';
import 'package:myapp/Util/my_botton.dart';
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({super.key, required this.controller,
  required this.onSave,
  required this.onCancel,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          //get user input
          TextField(
            controller: controller,
            decoration: InputDecoration(border: OutlineInputBorder(
            ),
        hintText: "Add a new task",
          ),
          ),
          // buttons -> save + cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //save button
              MyBotton(text:"Save",onPressed: onSave),

              const SizedBox(width: 8),

              //cancel button
              MyBotton(text:"Cancel", onPressed: onCancel),
            ],

          ),

        ]),
      ),
    );
  }
}
