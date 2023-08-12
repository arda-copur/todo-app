// ignore_for_file: prefer_const_constructors, unused_element, unused_local_variable

import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Not Defteri App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> todos = [];

  TextEditingController _textEditingController = TextEditingController();

   DateTime? selectedDateTime;
  
  

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void addTodo() {
    String todo = _textEditingController.text;
    if (todo.isNotEmpty && selectedDateTime != null) {
      setState(() {
        todos.add(todo + " - " + selectedDateTime.toString());
        selectedDateTime = null; //seçimi sıfırla
      });
      _textEditingController.clear();
    }
  }

  void removeTodoAtIndex(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDateTime() async {
      final DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now(),);
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
        });
      }
    }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Center(child: Text('Yapılacaklar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),)),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: const DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1616272963049-da2d8efc0c57?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YnJvd24lMjBhZXN0aGV0aWN8ZW58MHx8MHx8fDA%3D&w=1000&q=80"),
            fit: BoxFit.cover,
            ),
          ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: 'Yeni görev gir',
                        filled: true,
                        fillColor: Colors.brown[400],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                         contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      
                    ),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () { 
                      if (selectedDateTime != null) {
                        addTodo();
                      }   else {
                        _selectDateTime();
                      } 
                    },
                    
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.brown[400]), 
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                    child: Text('Ekle', style: TextStyle(color: Colors.black87),),
                    
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  final todoText = todo.split("-")[0];
                  final titleText = todo.split(" - ")[1];
                  bool isComplete = false;
                  return Container(        
                    decoration: BoxDecoration(color: Colors.brown[200], border: Border.all(color: Colors.brown), 
                    borderRadius: BorderRadius.circular(28)
                    ),margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(todoText),
                      subtitle: Text(titleText),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [ 
                          InkWell(
                            child: IconButton(
                               icon: Container(
                                                   decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                color: Colors.brown[100]
                                ),
                            child: Icon(
                                  Icons.delete,
                                color: Colors.red
                                  ),
                                          ),
                                     onPressed: () => removeTodoAtIndex(index),        
                                                   ),
                          ),
                        InkWell(
                          child: IconButton(
                               icon: Container(
                           decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                color: Colors.brown[100]
                                ),
                            child: Icon(
                                  Icons.check,
                                color: Colors.green,
                                  ),
                                          ),
                                     onPressed: () {
                                   setState(() {
                                 removeTodoAtIndex(index);
                                            });
                              },
                           ),
                        ),
                        ],
              ),
               
                    ),
          
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
