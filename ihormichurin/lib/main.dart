import 'package:flutter/material.dart';

void main() {
  runApp(MyApp.withFullName('Ihor Michurin'));
}

mixin Greetable {
  void greet() {
    print('Hello!');
  }
}

class Person {
  Person({required this.firstName, required this.lastName});

  String firstName;
  String lastName;
}

class MyApp extends StatelessWidget with Greetable {
  final Person person = Person(firstName: 'Ihor', lastName: 'Michurin')..lastName ??= 'Michurin';

  MyApp({this.firstName = '', this.lastName = ''});

  factory MyApp.fromDefault() {
    return MyApp();
  }

  factory MyApp.withFullName(String fullName, {String? firstName, String? lastName}) {
    final names = fullName.split(' ');
    return MyApp(
      firstName: firstName ?? names[0],
      lastName: lastName ?? (names.length > 1 ? names[1] : ''),
    );
  }

  final String firstName;
  final String lastName;

  @override
  Widget build(BuildContext context) {
    final list = [1, 2, 3, 4, 5];
    final map = {'first': 1, 'second': 2, 'third': 3};

    assert(list.isNotEmpty, 'List is empty');
    assert(map.isNotEmpty, 'Map is empty');

    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('First Name: ${person.firstName}'),
              Text('Last Name: ${person.lastName}'),
              Text('Input First Name: $firstName'),
              Text('Input Last Name: $lastName'),
              ElevatedButton(
                onPressed: () {
                  list.add(6);
                  map['fourth'] = 4;
                },
                child: Text('Add to List and Map'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
