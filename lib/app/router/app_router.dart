import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/add_event/screens/add_event.dart';
import 'package:hurricane_events/app/presentation/home/calendar/screens/calendar_screen.dart';
import 'package:hurricane_events/app/presentation/home/home.dart';
import 'package:hurricane_events/app/presentation/home/my_group/screens/group_detail_screen.dart';
import 'package:hurricane_events/app/presentation/home/my_group/screens/group_screen.dart';
import 'package:hurricane_events/app/presentation/home/settings/screens/settings.dart';
import 'package:hurricane_events/app/presentation/sign_up/screens/sign_up.dart';
import 'package:hurricane_events/app/presentation/splash/screens/splash.dart';
// import 'package:hurricane_events/app/presentation/timeline/screens/calendar_screen.dart';
import '../presentation/events/post_comment/post_comment.dart';
class AppRouter {
  /// A custom screen navigation handler that handles the animation of moving from one screen to another
  /// The current setting sets up the app to mimic the navigation on IOS devices on every of our app variant
  ///
  static _getPageRoute(
    Widget child, [
    String? routeName,
    dynamic args,
  ]) =>
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        settings: RouteSettings(
          name: routeName,
          arguments: args,
        ),
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(
            CurveTween(curve: curve),
          );
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );

  /// This is used to generate routes and manage routes in our flutter app.
  /// This supports stacking and persistence as we are using the named method.
  /// Therefore for we to stack pages on each other every page has to handle it's own data and state
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Splash.routeName:
        return _getPageRoute(const Splash());
      case SignUpScreen.routeName:
        return _getPageRoute(const SignUpScreen());
      case HomeScreen.routeName:
        return _getPageRoute(const HomeScreen());
      case CalendarSection.routeName:
        return _getPageRoute(const CalendarSection());
        // TODO : Dynamic Navigation to event details
      // case EventDetails.routeName:
      //   return _getPageRoute(const EventDetails(event: event))
      case SettingsScreen.routeName:
        return _getPageRoute(const SettingsScreen());
      case AddEvent.routeName:
        return _getPageRoute(const AddEvent());
      case GroupScreen.routeName:
        return _getPageRoute(const GroupScreen());
      case GroupDetailsScreen.routeName:
        return _getPageRoute(const GroupDetailsScreen());
        case PostComment.routeName:
        return _getPageRoute(const PostComment());
      default:
        return _getPageRoute(const Splash());
    }
  }
}
