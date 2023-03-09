import 'package:flutter/material.dart';
import 'package:learn_it/addcourses_page/screens/addcourses_page.dart';
import 'package:learn_it/attendance_page/screens/attendance_page.dart';
import 'package:learn_it/chatpage/screens/chat_screen.dart';
import 'package:learn_it/common/models/conference_meeting_model.dart';
import 'package:learn_it/common/models/userlogin_payload_model.dart';
import 'package:learn_it/common/providers/sharedpref.dart';
import 'package:learn_it/common/widgets/loading.dart';
import 'package:learn_it/dashboard_page/screens/dashboard_page.dart';
import 'package:learn_it/homepage/screens/homepage.dart';
import 'package:learn_it/login_page/screens/forgot_password.dart';
import 'package:learn_it/login_page/screens/login_screen.dart';
import 'package:learn_it/login_page/screens/otp_screen.dart';
import 'package:learn_it/login_page/screens/reset_password.dart';
import 'package:learn_it/onboarding_page/screens/onboarding_screen.dart';
import 'package:learn_it/profile_page/screens/profile_page.dart';
import 'package:learn_it/schedule_page/screens/schedule_page.dart';
import 'package:learn_it/signup_page/screens/signup_page.dart';
import 'package:learn_it/signup_page/screens/user_selection_page.dart';
import 'package:learn_it/video_call_page/screens/videosdk_screen.dart';

import '../../dashboard_page/screens/preview_screen.dart';
import '../../video_call_page/new_screens/conference_meeting_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboardingscreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => OnBoardingScreen(),
        );

      case AppRoutes.userSelection:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => UserSelectionPage(),
        );
      case AppRoutes.signup:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SignUpPage(
            userType: args,
          ),
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => LoginPage(),
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ForgotPasswordScreen(),
        );
      case AppRoutes.verifyOtp:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => OtpScreen(
            email: args,
          ),
        );
      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ResetPasswordScreen(),
        );
      case AppRoutes.videoCall:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => VideoCallScreen(),
        );
      case AppRoutes.chatscreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ChatScreen(),
        );
      case AppRoutes.dashboardpage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => DashBoardPage(),
        );
      case AppRoutes.calendar:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => TodaySchedulePage(),
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ProfilePage(),
        );
      case AppRoutes.attendance:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => AttendancePage(),
        );
      case AppRoutes.addcourses:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => AddCoursesPage(),
        );
      case AppRoutes.conference:
        final args =
            conferenceMeetingModelFromJson(settings.arguments as String);
        return MaterialPageRoute(
          builder: (context) => ConfereneceMeetingScreen(
            token: args.token,
            meetingId: args.meetingId,
            displayName: args.displayName,
            micEnabled: args.micEnabled,
            camEnabled: args.camEnabled,
          ),
        );
      case AppRoutes.home:
        if (UserLoginDetails.getLoginData() == null) {
          final args = settings.arguments as String;

          return MaterialPageRoute(
            settings: settings,
            builder: (context) => HomePage(
              userType: args,
            ),
          );
        } else {
          final data = UserLoginDetails.getLoginData();
          String userType = payloadFromJson(data!).user.userType;
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => HomePage(
              userType: userType,
            ),
          );
        }
      case AppRoutes.preview:
        final args = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => PreviewScreen(
                  meetingId: args,
                ));
      case AppRoutes.waiting:
        return MaterialPageRoute(builder: (context) => LoadingScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => LoadingScreen(),
        );
    }
  }

  // buildpage(Widget child, {RouteSettings? settings}) {
  //   MaterialPageRoute(
  //     settings: settings,
  //     builder: (context) => child,
  //   );
  // }
}
