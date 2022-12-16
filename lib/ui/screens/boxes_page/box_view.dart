import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../view_models/box_page_vm.dart';
import 'box_panel.dart';

final boxViewStateProvider =
    StateNotifierProvider<BoxViewStateNotifier, BoxViewState>(
        ((ref) => ref.watch(boxPageVMProvider).boxViewN));

class BoxView extends ConsumerWidget {
  static const int boxWidth = 68;
  static const int boxHeight = 56;
  static const _defaultBorder = BorderSide(color: Colors.black, width: 1);
  const BoxView(this.rows, this.cols, {super.key});

  final int rows;
  final int cols;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
                "https://archives.bulbagarden.net/media/upload/9/94/Box_3_XD.png")),
        border: Border(right: _defaultBorder, bottom: _defaultBorder),
      ),
      child: SizedBox(
        width: (boxWidth * cols).toDouble() + cols + 1,
        height: (boxHeight * rows).toDouble() + rows + 1,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            childAspectRatio: boxWidth / boxHeight,
          ),
          itemBuilder: (context, i) => GridTile(
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(top: _defaultBorder, left: _defaultBorder)),
              child: getSpriteAtIndex(ref, i),
            ),
          ),
          itemCount: rows * cols,
        ),
      ),
    );
  }

  Image? getSpriteAtIndex(WidgetRef ref, int i) {
    String? url = ref.watch(boxViewStateProvider).spriteUrls[i];
    if (url != null) {
      return Image.network(url);
    }
    return null;
  }
}
