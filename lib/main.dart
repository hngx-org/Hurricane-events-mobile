import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/home/settings/provider/settings_provider.dart';
import 'package:hurricane_events/app/presentation/events/post_comment/post_comment.dart';
import 'package:hurricane_events/app/router/app_router.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/theme/events_text_theme.dart';
import 'package:hurricane_events/domain/providers/global_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> main() async {
  //This is the main entry point of the app. This is where services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  ///The error widget is a UI render builder that is used for managing error views
  ///in debug mode and release modes.
  ///There are various funny scenarios where errors happen in an app and suddenly there's
  ///a grey area on the device, this looka upleasant, This aims to replace that with a pleasing view
  ///instead and in debug mode gives us the real RSOD(Red screen of death) or the error causing the UI failure.
  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = kDebugMode;
    if (inDebug) {
      return ErrorWidget(details.exception);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          kDebugMode ? details.exception.toString() : "Oops, something happened, try again.",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  };

  /// This wraps our main app function with a multiprovider which can take in as much provider as we
  /// use in our app.
  /// We are wrapping it at the top level because we want our providers to be available all through the app
  /// For a provider to be valid here it must be added in the _providers list
  runApp(
    MultiProvider(
      providers: _providers,
      child: const EventsApp(),
    ),
  );
}

final _providers = <SingleChildWidget>[
  ///Example
  ///ChangeNotifierProvider<TestProvider>(create: (_) => TestProvider())
  ChangeNotifierProvider<SettingsProvider>(create: (_) => SettingsProvider()),
  ChangeNotifierProvider(
    create: (_) => GlobalProvider.instance,
  )
];

class EventsApp extends StatelessWidget {
  const EventsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events App',
      debugShowCheckedModeBanner: false,

      /// This is where we get access to the navigation key to be used for several thingsin our app
      /// Navigation purposes,
      /// getting global buildcontext context to use generally in the app.
      navigatorKey: BaseNavigator.key,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(),

        /// This is where we added our own custom theme extensions to the app.
        /// We can add ranging from text theme to button theme, to all sorts,
        /// But we decided on only text theme for the project
        /// You can follow the fallback for definitions
        extensions: const [EventsTextTheme.fallback()],
      ),
      builder: (context, child) {
        /// This is where we impose our UI restrictions on the app using mediaQuery
        /// We restricted the scale as well as the pixelRatio to conform to that of the apps
        /// irrespective of the device
        final mediaQuery = MediaQuery.of(context);
        final scale = mediaQuery.textScaleFactor.clamp(0.85, 0.9);
        final pixelRatio = mediaQuery.devicePixelRatio.clamp(1.0, 1.0);

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: scale,
            devicePixelRatio: pixelRatio,
          ),
          child: child!,
        );
      },

      /// Follow Definitions
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: Splash.routeName,
    );
  }
}
