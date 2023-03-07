import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:learn_it/common/providers/backend_provider.dart';
import 'package:learn_it/common/widgets/button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../common/utils/screen_size.dart';
import '../../video_call_page/utils/api.dart';

class AddCoursesPage extends StatefulWidget {
  const AddCoursesPage({super.key});

  @override
  State<AddCoursesPage> createState() => _AddCoursesPageState();
}

class _AddCoursesPageState extends State<AddCoursesPage> {
  int _index = 0;
  //Layout
  String _token = "";
  TextEditingController? courseName;
  TextEditingController? courseDescription;
  final _courseNameKey = GlobalKey<FormState>();
  final _courseDescriptionKey = GlobalKey<FormState>();
  late String _setTime, _setDate;

  late String _hour, _minute, _time;

  late String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await fetchToken(context);
      setState(() => _token = token);
    });
    courseName = TextEditingController();
    courseDescription = TextEditingController();
    _dateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());

    _timeController.text = DateFormat("HH:mm aa").format(DateTime.now());
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat("dd/MM/yyyy").format(selectedDate);
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = DateFormat("HH:mm aa").format(DateTime(
            selectedDate.day,
            selectedDate.month,
            selectedDate.year,
            picked.hour,
            picked.minute));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    dateTime = DateFormat.yMd().format(DateTime.now());

    // datepickerFunction() {
    //   DatePicker.showDateTimePicker(context,
    //       showTitleActions: true,
    //       minTime: DateTime(1980, 1, 1),
    //       maxTime: DateTime(3000, 12, 31), onConfirm: (dateTime) {
    //     setState(() {
    //       _selectedDateTime = dateTime.toIso8601String();
    //       displayDate = DateFormat("MMM dd, yyyy hh:mm a").format(dateTime);
    //     });
    //   }, locale: LocaleType.en);
    // }

    final provider = Provider.of<BackEndProvider>(context);
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text(
            "Add Course",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        body: Stepper(
          physics: NeverScrollableScrollPhysics(),
          elevation: 0,
          type: StepperType.horizontal,
          controlsBuilder: (context, details) {
            // print(details);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: SizeConfig.width! * 80,
                child: Row(
                  children: [
                    details.currentStep >= 1
                        ? Container(
                            alignment: Alignment.center,
                            width: SizeConfig.width! * 20,
                            child: OutlinedButton(
                                onPressed: () => details.onStepCancel!.call(),
                                child: const Icon(
                                  Icons.chevron_left,
                                )),
                          )
                        : SizedBox(),
                    details.currentStep >= 1
                        ? SizedBox(
                            width: 15,
                          )
                        : SizedBox(),
                    SizedBox(
                      width: details.currentStep >= 1
                          ? SizeConfig.width! * 55
                          : SizeConfig.width! * 80,
                      child: FilledButton(
                        onPressed: () async {
                          if (details.currentStep == 0) {
                            if (_courseNameKey.currentState!.validate()) {
                              details.onStepContinue!.call();
                            }
                          }
                          if (details.currentStep == 1) {
                            print("1 press");
                            if (_courseDescriptionKey.currentState!
                                .validate()) {
                              details.onStepContinue!.call();
                            }
                          }
                          if (details.currentStep == 2) {
                            print("2 press");
                            {
                              String id = provider.payloadData!.user.id;
                              //print("id at add courses ====> $id");
                              String jwt = provider.jwt;
                              String _selectedDateTime = DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime.hour,
                                      selectedTime.minute)
                                  .toIso8601String();
                              //print("date time $_selectedDateTime");
                              final meetingId = await createMeeting(_token);
                              var res = await http.post(
                                  Uri.parse(
                                      "${provider.getLocalhost()}/addCourse/$id"),
                                  body: {
                                    "course_name": courseName!.text,
                                    "description": courseDescription!.text,
                                    "schedule_date": "${_selectedDateTime}Z",
                                    "roomId": meetingId,
                                    "hostId": id
                                  },
                                  headers: {
                                    "Authorization": jwt
                                  });

                              print(res.body);
                            }
                          }
                        },
                        child: Text(
                            details.currentStep == 2 ? "Add" : "Continue",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          //margin: EdgeInsetsGeometry.infinity,
          currentStep: _index,
          onStepCancel: () {
            if (_index > 0) {
              setState(() {
                _index -= 1;
              });
            }
          },
          onStepContinue: () {
            if (_index < 2) {
              setState(() {
                _index += 1;
              });
            }
          },
          // onStepTapped: (int index) {
          //   setState(() {
          //     _index = index;
          //   });
          // },
          steps: <Step>[
            Step(
              title: Text(""),
              state: _index > 0 ? StepState.complete : StepState.disabled,
              isActive: _index >= 0 ? true : false,
              content: Container(
                height: SizeConfig.height! * 15,
                // alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   alignment: Alignment.center,
                    //   height: SizeConfig.height! * 15,
                    //   child: Lottie.asset(
                    //       "assets/lottie/person_profile_lottie.json"),
                    // ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      height: SizeConfig.height! * 4,
                      child: Text(
                        "Enter the course name",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    Form(
                      key: _courseNameKey,
                      child: TextFormField(
                        controller: courseName,
                        validator: (arg) {
                          if (arg!.length <= 3) {
                            return 'Name must be more than 3 charaters';
                          } else {
                            setState(() {});
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.book),
                            border: OutlineInputBorder(),
                            hintText: "More than 3 characters",
                            hoverColor: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Step(
              title: Text(""),
              label: Text(""),
              state: _index > 1 ? StepState.complete : StepState.disabled,
              isActive: _index >= 1 ? true : false,
              content: Container(
                height: SizeConfig.height! * 15,
                // alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   alignment: Alignment.center,
                    //   height: SizeConfig.height! * 15,
                    //   child: Lottie.asset("assets/lottie/email_lottie.json"),
                    // ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      height: SizeConfig.height! * 4,
                      child: Text(
                        "Enter the course description",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    Form(
                      key: _courseDescriptionKey,
                      child: TextFormField(
                        controller: courseDescription,
                        textInputAction: TextInputAction.next,
                        style: Theme.of(context).textTheme.bodyLarge,
                        validator: (value) {
                          if (value!.length > 300) {
                            return "Exceeded the limit of 300 characters";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.wysiwyg_rounded),
                            border: OutlineInputBorder(),
                            hintText: "Max of 300 characters",
                            hoverColor: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Step(
              title: Text(""),
              label: Text(""),
              state: _index <= 2 ? StepState.indexed : StepState.complete,
              isActive: _index >= 2 ? true : false,
              content: Container(
                height: SizeConfig.height! * 15,
                // alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   alignment: Alignment.center,
                    //   height: SizeConfig.height! * 15,
                    //   child: Lottie.asset(
                    //     "assets/lottie/password2_lottie.json",
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      height: SizeConfig.height! * 4,
                      child: Text(
                        "Select your course time",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(48),
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            width: SizeConfig.width! * 40,
                            height: SizeConfig.height! * 7,
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(48)),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _dateController,
                              onSaved: (String? val) {
                                _setDate = val!;
                              },
                              decoration: const InputDecoration(
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.only(top: 0.0)),
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(48),
                          onTap: () {
                            _selectTime(context);
                          },
                          child: Container(
                            //margin: EdgeInsets.only(top: 30),
                            width: SizeConfig.width! * 40,
                            height: SizeConfig.height! * 7,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(48)),
                            child: TextFormField(
                              //style: TextStyle(fontSize: 40),
                              textAlign: TextAlign.center,
                              onSaved: (String? val) {
                                _setTime = val!;
                              },
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _timeController,
                              decoration: InputDecoration(
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  // labelText: 'Time',
                                  contentPadding: EdgeInsets.all(5)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
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
                                final meetingId = await createMeeting(_token);
                                var res = await http.post(
                                    Uri.parse(
                                        "${provider.getLocalhost()}/addCourse/$id"),
                                    body: {
                                      "course_name": courseName!.text,
                                      "description": courseDescription!.text,
                                      "schedule_date": "${_selectedDateTime}Z",
                                      "roomId": meetingId,
                                      "hostId": id
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
        ); */
