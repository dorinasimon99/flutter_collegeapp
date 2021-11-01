import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collegeapp/common/common_widgets.dart';
import 'package:flutter_collegeapp/common/local_storage.dart';
import 'package:flutter_collegeapp/courses/todos/todos_cubit.dart';
import 'package:flutter_collegeapp/models/CourseData.dart';
import 'package:flutter_collegeapp/models/TodoData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  late CourseData course;
  var _todoNameController = TextEditingController();
  String _selectedDate = "";

  @override
  void dispose(){
    _todoNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    course = ModalRoute.of(context)!.settings.arguments as CourseData;
    return Scaffold(
      appBar: header(context, isMenu: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Text(
            AppLocalizations.of(context)?.add_todo ?? 'Add todo',
              style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 40, color: Colors.black),
            ),
            TextFormField(
              controller: _todoNameController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)?.todo_name ?? 'Todo name',
                hintStyle: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Color(0xFF4F4F4F)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFC7E5C8)
                    )
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFC7E5C8)
                    )
                ),
              ),
              cursorColor: Color(0xFFC7E5C8),
              style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    _selectedDate,
                    style: TextStyle(fontFamily: 'Glory', fontSize: 20, color: Colors.black),
                  ),
                ),
                MaterialButton(
                  onPressed: () => _selectDate(context),
                  color: Color(0xFFC7E5C8),
                  child: Text(
                    AppLocalizations.of(context)?.add_deadline.toUpperCase() ?? 'ADD DEADLINE',
                    style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.black),
                  ),
                ),

              ],
            ),
            MaterialButton(
                  onPressed: () => _createTodo(),
                  color: Color(0xFFC7E5C8),
                  child: Text(
                    AppLocalizations.of(context)?.save.toUpperCase() ?? 'SAVE',
                    style: TextStyle(fontFamily: 'Glory-Semi', fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
      ),
      );
  }

  void _createTodo() async{
    var todo = TodoData(name: _todoNameController.text,
        done: false, owner: await LocalStorage.localStorage.readString(LocalStorage.SIGNED_IN_USER_NAME) ?? "",
        courseCode: course.courseCode, deadline: _selectedDate.isNotEmpty ? _selectedDate : null);
    BlocProvider.of<TodosCubit>(context)..createTodo(todo);
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year+5)
    );
    if(picked != null && picked != DateTime.now()){
      setState(() {
        _selectedDate = DateFormat('yyyy.MM.dd.').format(picked);
      });
    }
  }

}
