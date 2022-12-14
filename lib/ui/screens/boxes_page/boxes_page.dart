import 'package:flutter/material.dart';
import 'package:pku_manager/ui/screens/boxes_page/box_panel.dart';
import 'package:pku_manager/ui/screens/boxes_page/summary_panel.dart';

class BoxPage extends StatefulWidget {
  const BoxPage(this.saveLoaded, {super.key});

  final bool saveLoaded;

  @override
  State<BoxPage> createState() => _BoxPageState();
}

class _BoxPageState extends State<BoxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SizedBox(
            width: 280,
            child: SummaryPanel(),
          ),
          Expanded(
            child: Column(
              children: [
                const Expanded(child: BoxPanel()),
                if (widget.saveLoaded) const Expanded(child: BoxPanel()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
