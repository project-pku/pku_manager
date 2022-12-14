import 'package:flutter/material.dart';

class NavOverlay extends StatefulWidget {
  const NavOverlay(this.pageList, this.navDestList, {super.key});

  final List<Widget> pageList;
  final List<NavigationRailDestination> navDestList;

  @override
  State<NavOverlay> createState() => _NavOverlayState();
}

class _NavOverlayState extends State<NavOverlay> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
              backgroundColor: const Color.fromARGB(255, 33, 33, 33),
              unselectedLabelTextStyle: const TextStyle(color: Colors.grey),
              selectedIndex: _selectedIndex,
              groupAlignment: -0.95,
              unselectedIconTheme:
                  const IconThemeData(size: 30, color: Colors.grey),
              selectedIconTheme:
                  const IconThemeData(size: 40, color: Colors.grey),
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              // trailing: Expanded(
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Padding(
              //       padding: const EdgeInsets.only(bottom: 8.0),
              //       child: IconButton(
              //         icon: const Icon(Icons.help),
              //         onPressed: () {
              //           setState(() {
              //             _selectedIndex = 4;
              //           });
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              destinations: widget.navDestList),
          //fill out entire area left over by navbar
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: widget.pageList,
            ),
          )
        ],
      ),
    );
  }
}

class NavOverlayItem {
  final NavigationRailDestination navRailDest;
  final Widget navRailPage;

  const NavOverlayItem(this.navRailDest, this.navRailPage);
}
