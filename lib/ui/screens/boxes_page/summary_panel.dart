import 'package:flutter/material.dart';

class SummaryPanel extends StatefulWidget {
  const SummaryPanel({super.key});

  @override
  State<SummaryPanel> createState() => _SummaryPanelState();
}

class _SummaryPanelState extends State<SummaryPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 179, 179, 179),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextPair("Nickname", "Rayquaza"),
            const Padding(padding: EdgeInsets.only(top: 6)),
            const TextPair("OT", "HIRAM"),
            const Padding(padding: EdgeInsets.only(top: 6)),
            const TextPair("Origin Game", "Ruby"),
            const Padding(padding: EdgeInsets.only(top: 6)),
            const TextPair("Species", "Rayquaza"),
            const Padding(padding: EdgeInsets.only(top: 6)),
            const TextPair("Form", ""),
            const Padding(padding: EdgeInsets.only(top: 6)),
            const TextPair("Appearance", ""),
            const Spacer(),
            Center(
                child: Image.network(
                    "https://img.pokemondb.net/sprites/black-white/anim/normal/rayquaza.gif")),
            const Spacer(),
            const TextPair("Filename", "Rayquaza.pku"),
          ],
        ),
      ),
    );
  }
}

class TextPair extends StatefulWidget {
  const TextPair(this.name, this.value, {super.key});

  final String name;
  final String value;

  @override
  State<TextPair> createState() => _TextPairState();
}

class _TextPairState extends State<TextPair> {
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
            child: Text("${widget.name}: "),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(widget.value),
        ),
      ],
    );
  }
}
