import 'package:go_router/go_router.dart';
import 'package:learn_it/common/models/conference_meeting_model.dart';
import 'package:learn_it/common/routes/app_routes.dart';
import 'package:learn_it/onboarding_page/screens/onboarding_screen.dart';
import 'package:learn_it/signup_page/screens/user_selection_page.dart';
import 'package:learn_it/video_call_page/new_screens/conference_meeting_screen.dart';

import '../../homepage/screens/homepage.dart';
import '../providers/sharedpref.dart';
import 'app_routes_name.dart';

class GoRouterConfig {
  static GoRouter returnRoutes() {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: AppRouteName.onboardingscreen,
          path: "/",
          builder: (context, state) {
            return OnBoardingScreen();
          },
        ),
        GoRoute(
          name: AppRouteName.userSelection,
          path: "/userSelection",
          builder: (context, state) {
            return UserSelectionPage();
          },
        ),
        GoRoute(
          name: AppRouteName.home,
          path: "/home/:userType",
          builder: (context, state) {
            return HomePage(
              userType: state.params['userType']!,
            );
          },
        ),
        GoRoute(
          name: AppRouteName.conference,
          path: "/conferencescreen/:data",
          builder: (context, state) {
            final data =
                conferenceMeetingModelFromJson(state.params['userType']!);
            return ConfereneceMeetingScreen(
              micEnabled: data.micEnabled,
              camEnabled: data.camEnabled,
              token: data.token,
              meetingId: data.meetingId,
              displayName: data.displayName,
            );
          },
        ),
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
