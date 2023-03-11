import 'package:go_router/go_router.dart';
import 'package:learn_it/common/models/conference_meeting_model.dart';
import 'package:learn_it/login_page/screens/login_screen.dart';
import 'package:learn_it/onboarding_page/screens/onboarding_screen.dart';
import 'package:learn_it/signup_page/screens/signup_page.dart';
import 'package:learn_it/signup_page/screens/user_selection_page.dart';
import 'package:learn_it/video_call_page/new_screens/conference_meeting_screen.dart';

import '../../homepage/screens/homepage.dart';
import '../models/userlogin_payload_model.dart';
import '../providers/sharedpref.dart';
import 'app_path_name.dart';
import 'app_routes_name.dart';

class GoRouterConfig {
  static GoRouter returnRoutes() {
    GoRouter router = GoRouter(
      initialLocation: AppPathName.onboardingpath,
      routes: [
        GoRoute(
          name: AppRouteName.onboardingscreen,
          path: AppPathName.onboardingpath,
          builder: (context, state) {
            if (UserLoginDetails.getLoginData() == null ||
                UserLoginDetails.getJwtToken() == null) {
              return const OnBoardingScreen();
            } else {
              final data = UserLoginDetails.getLoginData();
              String userType = payloadFromJson(data!).user.userType;
              return HomePage(userType: userType);
            }
            // return OnBoardingScreen();
          },
        ),
        GoRoute(
          name: AppRouteName.userSelection,
          path: AppPathName.userSelectionpath,
          builder: (context, state) {
            return const UserSelectionPage();
          },
        ),
        GoRoute(
          name: AppRouteName.home,
          path: AppPathName.homepath,
          builder: (context, state) {
            return HomePage(
              userType: state.params['userType']!,
            );
          },
        ),
        GoRoute(
          name: AppRouteName.conference,
          path: AppPathName.conferencepath,
          builder: (context, state) {
            final data = conferenceMeetingModelFromJson(state.params['data']!);
            return ConfereneceMeetingScreen(
              micEnabled: data.micEnabled,
              camEnabled: data.camEnabled,
              token: data.token,
              meetingId: data.meetingId,
              displayName: data.displayName,
            );
          },
        ),
        GoRoute(
          name: AppRouteName.signup,
          path: AppPathName.signuppath,
          builder: (context, state) {
            return SignUpPage(
              userType: state.params["userType"]!,
            );
          },
        ),
        GoRoute(
          name: AppRouteName.login,
          path: AppPathName.loginpath,
          builder: (context, state) {
            return const LoginPage();
          },
        )
      ],
      // redirect: (context, state) {
      //   if (UserLoginDetails.getLoginData() == null ||
      //       UserLoginDetails.getJwtToken() == null) {
      //     return AppRoutes.onboardingscreen;
      //   } else {
      //     return AppRoutes.home;
      //   }
      // },
    );

    return router;
  }
}
