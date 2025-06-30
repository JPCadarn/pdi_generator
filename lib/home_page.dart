import 'package:flutter/material.dart';
import 'package:pdi_generator/my_chat.dart';

import 'chats.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    MyChat(),
    Chats(),
  ];
  final List<NavigationDrawerDestination> _drawerDestinations = [
    NavigationDrawerDestination(icon: Icon(Icons.psychology), label: Text('Gerar PDI')),
    NavigationDrawerDestination(icon: Icon(Icons.list), label: Text('Visualizar PDIs')),
  ];
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Gerador de PDI'),
      ),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() { _selectedIndex = index; });
          Navigator.pop(context);
        },
        children: _drawerDestinations,
      ),
      body: _pages[_selectedIndex],
    );
  }
}
