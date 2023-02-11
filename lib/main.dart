import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_it/addcourses_page/screens/addcourses_page.dart';
import 'package:learn_it/common/providers/backend_provider.dart';
import 'package:learn_it/common/widgets/colors.dart';
import 'package:learn_it/homepage/providers/dashboard_provider.dart';
import 'package:learn_it/profile_page/screens/profile_page.dart';
import 'package:learn_it/startup_page/screens/startup_page.dart';
import 'package:provider/provider.dart';
/*register

user_type
username
email
password
c_password  */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BackEndProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashBoardProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Palette.kToDark,
          fontFamily: GoogleFonts.crimsonPro().fontFamily,
          textTheme:
              GoogleFonts.crimsonTextTextTheme(Theme.of(context).textTheme),
          scaffoldBackgroundColor: Colors.grey[100],
          colorScheme: ColorScheme.light(
            primary: Color.fromARGB(255, 9, 43, 101),
            secondary: Color.fromARGB(180, 9, 43, 101),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        home: const SafeArea(child: AddCoursesPage()),
      ),
    );
  }
}
