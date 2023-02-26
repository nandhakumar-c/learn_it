import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_it/addcourses_page/screens/addcourses_page.dart';
import 'package:learn_it/common/providers/backend_provider.dart';
import 'package:learn_it/common/widgets/colors.dart';
import 'package:learn_it/dashboard_page/providers/dashboard_provider.dart';
import 'package:learn_it/profile_page/screens/profile_page.dart';
import 'package:learn_it/startup_page/screens/startup_page.dart';
import 'package:learn_it/video_call_page/screens/video_call_screen.dart';
import 'package:provider/provider.dart';

import 'chatpage/screens/chat_screen.dart';
import 'common/widgets/color_scheme.dart';

//Integrate the WebRTC
//Add Chat Feature to the app
/*register

user_type
username
email
password
c_password  */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(MyApp());
}

// void main() {
//   runApp(const MyApp());
// }

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
              fontFamily: 'Inter',
              textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Inter'),
              useMaterial3: true,
              colorScheme: lightColorScheme),
          darkTheme: ThemeData(
              fontFamily: 'Inter',
              textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Inter'),
              useMaterial3: true,
              colorScheme: darkColorScheme),
          debugShowCheckedModeBanner: false,
          home: const SafeArea(child: StartupScreen())),
    );
  }
}


 /* theme: ThemeData(
            // ignore: deprecated_member_use
            // primaryColor: Colors.green,

            brightness: Brightness.light,
            // primarySwatch: Colors.blue,
            fontFamily: 'Inter',
            //fontFamily: GoogleFonts.crimsonPro().fontFamily,
            textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Inter'),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                fixedSize: Size.fromHeight(10),
              ),
            ),

            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(50), shape: StadiumBorder()),
            ),

            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                fixedSize: Size.fromHeight(50),
                shape: StadiumBorder(),
              ),
            ),
            scaffoldBackgroundColor: Color(0xFFF5FAFA),
            //Color.fromRGBO(245, 250, 250, 100)
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1985B3),
              secondary: Color(0xFFC1E5F5),
              tertiary: Color(0xFFF5FAFA),
            ),

            //colorSchemeSeed: const Color(0xFF1985B3),
            useMaterial3: true,
            inputDecorationTheme: const InputDecorationTheme(
              filled: true, //<-- SEE HERE
              fillColor: Colors.white, //<-- SEE HERE
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ), */