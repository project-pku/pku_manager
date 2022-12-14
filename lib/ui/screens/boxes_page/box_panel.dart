import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pku_manager/main.dart';
import 'package:pku_manager/ui/screens/boxes_page/summary_panel.dart';
import '../../../notifiers/box_panel_notifier.dart';
import 'box_view.dart';

final boxPanelStateProvider =
    StateNotifierProvider<BoxPanelNotifier, BoxPanelState>(
        ((ref) => BoxPanelNotifier(pkucm)));

class BoxPanel extends StatelessWidget {
  const BoxPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Row(
          children: [
            const Spacer(),
            Wrap(
              direction: Axis.vertical,
              spacing: 10,
              children: [
                Consumer(
                    builder: ((context, ref, child) => TextPair(
                        "Box Name", ref.watch(boxPanelStateProvider).boxName))),
                Consumer(
                    builder: ((context, ref, child) => TextPair("Collection",
                        ref.watch(boxPanelStateProvider).collectionName))),
                TextButton(
                    onPressed: () => pkucm.pkuCollection.currentBoxID++,
                    child: const Text("Choose Box")),
                TextButton(
                    onPressed: () => {}, child: const Text("Refresh Box")),
              ],
            ),
            const Spacer(),
            const Center(child: BoxView(5, 6)),
            const Spacer()
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
