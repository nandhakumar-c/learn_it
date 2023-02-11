import 'package:flutter/gestures.dart';
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
  String? displayDate;
  @override
  void initState() {
    super.initState();
    courseName = TextEditingController();
    courseDescription = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    datepickerFunction() {
      DatePicker.showDateTimePicker(context,
          showTitleActions: true,
          minTime: DateTime(1980, 1, 1),
          maxTime: DateTime(3000, 12, 31), onConfirm: (dateTime) {
        setState(() {
          _selectedDateTime = dateTime.toIso8601String();
          displayDate = DateFormat("MMM dd, yyyy hh:mm a").format(dateTime);
        });
      }, locale: LocaleType.en);
    }

    final provider = Provider.of<BackEndProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Courses Page"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: height * 0.675,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.elliptical(width * 0.05, width * 0.05)),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 66, 165, 255),
                        Color.fromARGB(255, 133, 200, 255)
                      ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
                      color: Colors.blue[300]),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Course Title
                          Container(
                            height: height * 0.04,
                            width: width * 0.3,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromARGB(255, 9, 43, 101),
                                  Color.fromARGB(180, 14, 96, 195),
                                ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              "Course Title",
                              style: TextStyle(
                                  fontSize: width * 0.05, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            height: height * 0.06,
                            width: width,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(
                                        width * 0.03, width * 0.03)),
                                color: Colors.white),
                            child: TextField(
                              controller: courseName,
                              style: TextStyle(
                                fontSize: width * 0.045,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter your course title here",
                                hintStyle: TextStyle(
                                  fontSize: width * 0.045,
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),

                          //Course Description
                          Container(
                            height: height * 0.04,
                            width: width * 0.45,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromARGB(255, 9, 43, 101),
                                  Color.fromARGB(180, 14, 96, 195),
                                ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              "Course Description",
                              style: TextStyle(
                                  fontSize: width * 0.05, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            height: height * 0.2,
                            width: width,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.elliptical(
                                  width * 0.03, width * 0.03)),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: courseDescription,
                              style: TextStyle(
                                fontSize: width * 0.045,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter your course description here",
                                hintStyle: TextStyle(
                                  fontSize: width * 0.045,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          //Course Time
                          Container(
                            height: height * 0.04,
                            width: width * 0.3,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromARGB(255, 9, 43, 101),
                                  Color.fromARGB(180, 14, 96, 195),
                                ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              "Course Time",
                              style: TextStyle(
                                  fontSize: width * 0.05, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            height: height * 0.06,
                            width: width,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 10, right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(
                                        width * 0.03, width * 0.03)),
                                color: Colors.white),
                            child: Row(
                              children: [
                                displayDate != null
                                    ? Text(
                                        displayDate.toString(),
                                        style: TextStyle(
                                            fontSize: width * 0.05,
                                            color: Colors.grey),
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            "Pick a date from there",
                                            style: TextStyle(
                                                fontSize: width * 0.05,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: width * 0.01,
                                          ),
                                          const SizedBox(
                                            child: Icon(
                                              Icons.arrow_circle_right_outlined,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                const Spacer(),
                                Container(
                                  height: height * 0.05,
                                  width: height * 0.05,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color.fromARGB(255, 9, 43, 101),
                                      Color.fromARGB(180, 14, 96, 195)
                                    ]),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(width * 0.03),
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.calendar_month,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    onPressed: datepickerFunction,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),

                          //Add Courses Button
                          LearnItButton(
                              text: "Add Course",
                              onPressed: () async {
                                String id = provider.payloadData!.user.id;
                                //print("id at add courses ====> $id");
                                String jwt = provider.jwt;
                                //print("date time $_selectedDateTime");
                                var res = await http.post(
                                    Uri.parse(
                                        "${provider.getLocalhost()}/addCourse/$id"),
                                    body: {
                                      "course_name": courseName!.text,
                                      "description": courseDescription!.text,
                                      "schedule_date": "${_selectedDateTime}Z"
                                    },
                                    headers: {
                                      "Authorization": jwt
                                    });

                                print(res.body);
                              })
                        ]),
                  ),
                ),
              )
            ],
          ),
        )

        /*body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              TextField(
                controller: courseName,
                decoration: const InputDecoration(
                    label: Text("Course Name"), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: courseDescription,
                decoration: const InputDecoration(
                    label: Text("Course Description"),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: _selectedDateTime ?? "Selected Date and Time",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1980, 1, 1),
                            maxTime: DateTime(3000, 12, 31),
                            onConfirm: (dateTime) {
                          setState(() {
                            _selectedDateTime = dateTime.toIso8601String();
                          });
                        }, locale: LocaleType.en);
                      },
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  child: const Text("Add Course"),
                  onPressed: () async {
                    String id = provider.payloadData!.user.id;
                    //print("id at add courses ====> $id");
                    String jwt = provider.jwt;
                    //print("date time $_selectedDateTime");
                    var res = await http.post(
                        Uri.parse("${provider.getLocalhost()}/addCourse/$id"),
                        body: {
                          "course_name": courseName!.text,
                          "description": courseDescription!.text,
                          "schedule_date": "${_selectedDateTime}Z"
                        },
                        headers: {
                          "Authorization": jwt
                        });

                    print(res.body);
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
        )*/
        );
  }
}
