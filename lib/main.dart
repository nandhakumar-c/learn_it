import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
          // ignore: deprecated_member_use
          primaryColor:Colors.green ,
        
      
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.inter().fontFamily,
          //fontFamily: GoogleFonts.crimsonPro().fontFamily,
          textTheme:
              GoogleFonts.interTextTheme(Theme.of(context).textTheme),
          scaffoldBackgroundColor: Color(0xFFF5FAFA),
          //Color.fromRGBO(245, 250, 250, 100)
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF1985B3),
            secondary:Color(0xFFC1E5F5),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        home: const SafeArea(child: StartupScreen())
      ),
    );
  }
}
