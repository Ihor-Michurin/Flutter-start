import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/namedNavigation': (context) => const NamedNavigationPage(),
        '/parameterizedWidget': (context) =>
        const ParameterizedWidgetPage(arguments: {}),
        '/nestedNavigation': (context) => const NestedNavigationPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WidgetByClassNamePage()),
                );
              },
              child: const Text('Go to widget by class name'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/namedNavigation');
              },
              child: const Text('Go to named navigation widget'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/parameterizedWidget',
                  arguments: {'param1': 'Hello', 'param2': 'World'},
                );
              },
              child: const Text('Go to parameterized widget'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/nestedNavigation');
              },
              child: const Text('Go to nested navigation'),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetByClassNamePage extends StatelessWidget {
  const WidgetByClassNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget by class name'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back'),
        ),
      ),
    );
  }
}

class NamedNavigationPage extends StatelessWidget {
  const NamedNavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Named Navigation'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back'),
        ),
      ),
    );
  }
}

class ParameterizedWidgetPage extends StatelessWidget {
  final Map<String, dynamic> arguments;

  const ParameterizedWidgetPage({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parameterized Widget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Parameter 1: ${arguments['param1']}'),
            Text('Parameter 2: ${arguments['param2']}'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {'result': 'OK'});
              },
              child: const Text('Return result'),
            ),
          ],
        ),
      ),
    );
  }
}

class NestedNavigationPage extends StatefulWidget {
  const NestedNavigationPage({Key? key}) : super(key: key);

  @override
  _NestedNavigationPageState createState() => _NestedNavigationPageState();
}

class _NestedNavigationPageState extends State<NestedNavigationPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const NestedPage1(),
    const NestedPage2(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested Navigation'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Page 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Page 2',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class NestedPage1 extends StatelessWidget {
  const NestedPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Nested Page 1'),
    );
  }
}

class NestedPage2 extends StatelessWidget {
  const NestedPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Nested Page 2'),
    );
  }
}