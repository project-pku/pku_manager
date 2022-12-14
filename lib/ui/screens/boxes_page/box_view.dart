import 'package:flutter/material.dart';

class BoxView extends StatefulWidget {
  const BoxView(this.rows, this.cols, {super.key});

  final int rows;
  final int cols;

  @override
  State<BoxView> createState() => _BoxViewState();
}

class _BoxViewState extends State<BoxView> {
  static const int boxWidth = 68;
  static const int boxHeight = 56;
  static const _defaultBorder = BorderSide(color: Colors.black, width: 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
                "https://archives.bulbagarden.net/media/upload/9/94/Box_3_XD.png")),
        border: Border(right: _defaultBorder, bottom: _defaultBorder),
      ),
      child: SizedBox(
        width: (boxWidth * widget.cols).toDouble() + widget.cols + 1,
        height: (boxHeight * widget.rows).toDouble() + widget.rows + 1,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.cols,
            childAspectRatio: boxWidth / boxHeight,
          ),
          itemBuilder: (context, i) => GridTile(
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(top: _defaultBorder, left: _defaultBorder)),
              child: Image.network(
                  "https://raw.githubusercontent.com/msikma/pokesprite/master/pokemon-gen8/regular/venusaur.png"),
            ),
          ),
          itemCount: widget.rows * widget.cols,
        ),
      ),
    );
  }
}
