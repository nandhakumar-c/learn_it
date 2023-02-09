import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:learn_it/common/providers/backend_provider.dart';
import 'package:learn_it/common/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddCoursesPage extends StatefulWidget {
  const AddCoursesPage({super.key});

  @override
  State<AddCoursesPage> createState() => _AddCoursesPageState();
}

class _AddCoursesPageState extends State<AddCoursesPage> {
  TextEditingController? courseName;
  TextEditingController? courseDescription;
  String? _selectedDateTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    courseName = TextEditingController();
    courseDescription = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Courses Page"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              TextField(
                controller: courseName,
                decoration: InputDecoration(
                    label: Text("Course Name"), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: courseDescription,
                decoration: InputDecoration(
                    label: Text("Course Description"),
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText:
                        "${_selectedDateTime ?? "Selected Date and Time"}",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_month),
                      onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1980, 1, 1),
                            maxTime: DateTime(3000, 12, 31),
                            onConfirm: (dateTime) {
                          setState(() {
                            _selectedDateTime =
                                DateFormat("yyyy-MM-dd  HH-mm-ss")
                                    .format(dateTime);
                          });
                        }, locale: LocaleType.en);
                      },
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  child: Text("Add Course"),
                  onPressed: () async {
                    final provider = Provider.of<BackEndProvider>(context);
                    String id = await provider.payloadData!.user.id;
                    print("id $id");
                    String jwt = await provider.jwt;
                    var res = await http.post(
                        Uri.parse("${provider.getLocalhost()}/addCourse/$id"),
                        body: {
                          "course_name": courseName!.text,
                          "description": courseDescription!.text,
                          "schedule_date": _selectedDateTime
                        },
                        headers: {
                          "Authorization": jwt
                        });
                    print(res);
                  })
              /* Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${_selectedDateTime ?? "Selected Date and Time"}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1980, 1, 1),
                          maxTime: DateTime(3000, 12, 31),
                          onConfirm: (dateTime) {
                        setState(() {
                          _selectedDateTime = DateFormat("yyyy-MM-dd  HH-mm-ss")
                              .format(dateTime);
                        });
                      }, locale: LocaleType.en);
                    },
                    child: Text("Show Date Time Picker"),
                  ),
                ],
              )*/
            ]),
          ),
        ));
  }
}
