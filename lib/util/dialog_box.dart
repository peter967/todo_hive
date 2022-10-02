import 'package:flutter/material.dart';
import 'package:todo_hive/util/my_button.dart';

class DialogBox extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var isValid = false;
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        content: SizedBox(
          height: 125,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  controller: controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    hintText: 'Add a new task',
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton(
                      text: 'Save',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          return onSave();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    MyButton(
                      text: 'Cancel',
                      onPressed: onCancel,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
