import 'package:flutter/material.dart';
import 'box_panel.dart';
import 'summary_panel.dart';

class BoxPage extends StatelessWidget {
  const BoxPage(this.saveLoaded, {super.key});

  final bool saveLoaded;

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
                if (saveLoaded) const Expanded(child: BoxPanel()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
