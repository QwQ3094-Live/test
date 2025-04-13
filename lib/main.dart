import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/services.dart';
import 'package:test/pages/home.dart';
import 'package:test/pages/business.dart';
import 'package:test/pages/school.dart';

void main() {
  runApp(const App());
  
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        final lightColorScheme = lightDynamic ?? ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        );
        final darkColorScheme = darkDynamic ?? ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        );

        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: lightColorScheme,
            useMaterial3: true,
            sliderTheme: const SliderThemeData(year2023: false),
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            useMaterial3: true,
            sliderTheme: const SliderThemeData(year2023: false),
          ),
          themeMode: ThemeMode.system,
          home: const Main(title: 'Flutter Demo'),
        );
      },
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key, required this.title});

  final String title;

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const BusinessScreen(),
    const SchoolScreen(),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          NavigationDestination(
            icon: Icon(Icons.business),
            label: 'Business'
          ),
          NavigationDestination(
            icon: Icon(Icons.school),
            label: 'School'
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
    );
  }
}
