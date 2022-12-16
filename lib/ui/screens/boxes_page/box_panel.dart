import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:pku_manager/main.dart';
import 'package:pku_manager/ui/screens/boxes_page/summary_panel.dart';
import '../../../view_models/box_page_vm.dart';
import 'box_view.dart';

final boxPageVMProvider = Provider(((ref) => BoxPageVM(pkucm)));
final boxPanelInfoStateProvider =
    StateNotifierProvider<BoxPanelInfoStateNotifier, BoxPanelInfoState>(
        ((ref) => ref.watch(boxPageVMProvider).boxInfoN));

class BoxPanel extends StatelessWidget {
  const BoxPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Row(
          children: const [
            Spacer(),
            BoxPanelInfo(),
            Spacer(),
            Center(child: BoxView(5, 6)),
            Spacer()
          ],
        ),
        const Spacer(),
      ],
    );
  }
}

class BoxPanelInfo extends ConsumerWidget {
  const BoxPanelInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 10,
      children: [
        const TextPair.widgetValue("Box Name", BoxSelector()),
        TextPair(
            "Collection", ref.watch(boxPanelInfoStateProvider).collectionName),
        TextButton(onPressed: () => {}, child: const Text("Refresh Box")),
      ],
    );
  }
}

class BoxSelector extends ConsumerWidget {
  const BoxSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 100,
      child: DropdownButton(
        isExpanded: true,
        focusNode:
            FocusNode(canRequestFocus: false), //wont retain focus on click
        isDense: true,
        style: const TextStyle(fontSize: 14, color: Colors.black),
        value: ref.watch(boxPanelInfoStateProvider).currentBoxID,
        items: ref
            .watch(boxPanelInfoStateProvider)
            .boxNames
            .mapIndexed((index, boxName) => DropdownMenuItem(
                value: index,
                child: Text(boxName, overflow: TextOverflow.ellipsis)))
            .toList(),
        onChanged: (int? value) {
          if (value != null) {
            ref.read(boxPageVMProvider).changeBox(value);
          }
        },
      ),
    );
  }
}
