import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/home/calendar/screens/calendar_screen.dart';
import 'package:hurricane_events/app/presentation/home/my_group/provider/my_group_provider.dart';
import 'package:hurricane_events/app/presentation/home/my_group/screens/group_screen.dart';
import 'package:hurricane_events/app/presentation/home/settings/screens/settings.dart';
import 'package:hurricane_events/app/presentation/home/timeline/screens/timeline.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:hurricane_events/data/services/local_storage/local_storage.dart';
import 'package:hurricane_events/domain/providers/events_provider.dart';
import 'package:hurricane_events/domain/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _local = AppStorage.instance;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final local = _local.getId();
      if (local != null) {
        BaseNavigator.currentContext.read<UserProvider>().getUserDetails();
        BaseNavigator.currentContext.read<EventProvider>().getEvents();
        Provider.of<MyGroupProvider>(context, listen: false).getGroups();
      }
    });
  }

  int currentIndex = 0;

  final List<Widget> screens = [
    const TimelineScreen(),
    const GroupScreen(),
    const CalendarSection(),
    const SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
