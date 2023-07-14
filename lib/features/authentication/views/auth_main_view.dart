import 'package:chipin_video_content/features/authentication/views/login_view.dart';
import 'package:chipin_video_content/features/authentication/views/signup_view.dart';
import 'package:flutter/material.dart';

class AuthMainView extends StatefulWidget {
  const AuthMainView({super.key});

  @override
  State<AuthMainView> createState() => _AuthMainViewState();
}

class _AuthMainViewState extends State<AuthMainView> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    LoginView(),
    SignUpView()
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
        title: const Text(
          'chipIn',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Sign Up',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
