import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pku_manager/main.dart';
import 'package:pku_manager/ui/screens/boxes_page/summary_panel.dart';
import '../../../notifiers/box_page_vm.dart';
import 'box_view.dart';

final boxPageVMProvider = Provider(((ref) => BoxPageVM(pkucm)));
final boxInfoProvider =
    StateNotifierProvider<BoxInfoStateNotifier, BoxInfoState>(
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
        TextPair("Box Name", ref.watch(boxInfoProvider).currentBoxName),
        TextPair("Collection", ref.watch(boxInfoProvider).collectionName),
        TextButton(
            onPressed: () => ref.read(boxPageVMProvider).changeBox(1),
            child: const Text("Choose Box")),
        TextButton(onPressed: () => {}, child: const Text("Refresh Box")),
      ],
    );
  }
}
