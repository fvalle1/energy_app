import 'package:energy/consumption.dart';
import 'package:energy/power.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Energy consumption',
      theme: CupertinoThemeData(primaryColor: CupertinoColors.activeGreen),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.bolt_fill),
          label: 'Power',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.battery_charging),
          label: 'Consumption',
        )
      ]),
      tabBuilder: (context, index) {
        switch (index) {
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return const ConsumptionPage(title: 'Power consumption');
              },
            );
          default:
            return CupertinoTabView(
              builder: (context) {
                return const PowerPage(title: 'Power production');
              },
            );
        }
      },
    );
  }
}
