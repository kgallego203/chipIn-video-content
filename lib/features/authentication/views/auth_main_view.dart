import 'package:chipin_video_content/features/authentication/views/login_view.dart';
import 'package:chipin_video_content/features/authentication/views/signup_view.dart';
import 'package:chipin_video_content/themes/palette.dart';
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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'chipIn',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Palette.primary100,
              ),
            ),
            Row(
              children: [
                Text(
                  'powered by ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Palette.neutral70,
                  ),
                ),
                Text(
                  'Flutter',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF02569B),
                  ),
                ),
                Text(
                  ' and ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Palette.neutral70,
                  ),
                ),
                Text(
                  'Appwrite',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Palette.primary300,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Palette.neutral0,
        toolbarHeight: 100,
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
        selectedItemColor: Palette.primary100,
        unselectedItemColor: Palette.neutral70,
        onTap: _onItemTapped,
      ),
    );
  }
}
