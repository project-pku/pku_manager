import 'package:flutter/material.dart';
import 'package:pku_manager/ui/nav_overlay.dart';
import 'package:pku_manager/ui/screens/boxes_page/boxes_page.dart';
import 'package:pku_manager/ui/screens/settings_page.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  static const pageList = <Widget>[
    BoxPage(false),
    BoxPage(true),
    SettingsPage(),
  ];

  static const navDestList = <NavigationRailDestination>[
    NavigationRailDestination(
      icon: Icon(Icons.catching_pokemon_outlined),
      selectedIcon: Icon(Icons.catching_pokemon),
      label: Text('Boxes'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.backpack_outlined),
      selectedIcon: Icon(Icons.backpack),
      label: Text('Bag'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.settings),
      label: Text('Settings'),
      // padding: EdgeInsets.only(
      // top: MediaQuery.of(context).size.height / 1.8),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pkuManager Demo',
      theme: ThemeData(
        // colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
        primarySwatch: Colors.cyan,
      ),
      home: const NavOverlay(pageList, navDestList),
    );
  }
}
