import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_it/chatpage/providers/chat_provider.dart';
import 'package:learn_it/common/providers/backend_provider.dart';
import 'package:learn_it/common/providers/sharedpref.dart';
import 'package:learn_it/dashboard_page/providers/dashboard_provider.dart';
import 'package:learn_it/video_call_page/providers/video_call_provider.dart';
import 'package:provider/provider.dart';

import 'common/routes/app_routes.dart';
import 'common/routes/app_routes_config.dart';
import 'common/widgets/color_scheme.dart';

//Integrate the WebRTC
//Add Chat Feature to the app
/*register

user_type
username
email
password
c_password  */
late String initialRoute;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await UserLoginDetails.init();

  runApp(const MyApp());
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDynamicLinks();
  }

  Future initDynamicLinks() async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      // Example of using the dynamic link to push the user to a different screen
      print("if block ${deepLink.path}");
      print("if block params ${deepLink.queryParameters['meetingId']}");
      Navigator.pushNamed(context, deepLink.path)
          .onError((error, stackTrace) => print("ERROR msg => $error"));
    }

    FirebaseDynamicLinks.instance.onLink.listen(
      (pendingDynamicLinkData) {
        // Set up the `onLink` event listener next as it may be received here
        final Uri deepLink = pendingDynamicLinkData.link;
        print(deepLink.path);
        // Example of using the dynamic link to push the user to a different screen
        Navigator.pushNamed(context, deepLink.path);
      },
    );

    /* dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.queryParameters;
      String? meetingId = queryParams['meetingId'];

      print("Query Params ====> $queryParams");
      if (queryParams.isNotEmpty) {
        Navigator.of(context)
            .pushNamed(dynamicLinkData.link.path, arguments: meetingId);
      } else {
        Navigator.of(context).pushNamed(AppRoutes.calendar);
      }
    }).onError((error) {
      print("Error ==>$error");
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BackEndProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashBoardProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VideoCallProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        )
      ],
      child: MaterialApp.router(
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF5FAFA),
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
        routeInformationParser:
            GoRouterConfig.returnRoutes().routeInformationParser,
        routerDelegate: GoRouterConfig.returnRoutes().routerDelegate,

        //initialRoute: getRoute(),
        // AppRoutes.onboardingscreen,
        //onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

getRoute() {
  String serverIp = "http://192.168.1.80:4000/api";
  print("LOGIN DATA ======= ${UserLoginDetails.getLoginData()}");
  print("JWT TOKEN ======= ${UserLoginDetails.getJwtToken()}");
  if (UserLoginDetails.getLoginData() == null ||
      UserLoginDetails.getJwtToken() == null) {
    return AppRoutes.onboardingscreen;
  } else {
    return AppRoutes.home;
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