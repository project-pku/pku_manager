import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../view_models/box_page_vm.dart';
import 'box_panel.dart';

final summaryPanelStateProvider =
    StateNotifierProvider<SummaryPanelStateNotifier, SummaryPanelState>(
        ((ref) => ref.watch(boxPageVMProvider).summaryPanelN));

class SummaryPanel extends ConsumerWidget {
  const SummaryPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: const Color.fromARGB(255, 179, 179, 179),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextPair("Nickname", ref.watch(summaryPanelStateProvider).nickname),
            const Padding(padding: EdgeInsets.only(top: 6)),
            TextPair("OT", ref.watch(summaryPanelStateProvider).ot),
            const Padding(padding: EdgeInsets.only(top: 6)),
            TextPair(
                "Origin Game", ref.watch(summaryPanelStateProvider).originGame),
            const Padding(padding: EdgeInsets.only(top: 6)),
            TextPair("Species", ref.watch(summaryPanelStateProvider).species),
            const Padding(padding: EdgeInsets.only(top: 6)),
            TextPair("Form", ref.watch(summaryPanelStateProvider).form),
            const Padding(padding: EdgeInsets.only(top: 6)),
            TextPair(
                "Appearance", ref.watch(summaryPanelStateProvider).appearance),
            const Spacer(),
            Center(
                child: Image.network(
                    "https://img.pokemondb.net/sprites/black-white/anim/normal/rayquaza.gif")),
            const Spacer(),
            TextPair("Filename", "Rayquaza.pku"),
          ],
        ),
      ),
    );
  }
}

class TextPair extends StatelessWidget {
  TextPair(String name, String value, {Key? key})
      : this.widgetValue(name, Text(value), key: key);
  const TextPair.widgetValue(this.name, this.value, {super.key});

  final String name;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100.0,
          height: 24.0,
          padding: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: const Color.fromARGB(255, 227, 227, 227),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text("$name: "),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: value,
        ),
      ],
    );
  }
}
