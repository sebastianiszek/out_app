import 'package:flutter/material.dart';
import 'package:out_app/shared/shared_components/input.dart';

class TopSection extends StatefulWidget {
  const TopSection(
      {Key? key,
      required this.onSearchValueChanged,
      required this.onFilterPressed})
      : super(key: key);
  final Function(String) onSearchValueChanged;
  final VoidCallback onFilterPressed;

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: TextFormField(
                    decoration: getOutInputDecoration(
                        const Color(0xFFDEE0FF), const Color(0xFF000965)),
                    onChanged: (String value) {
                      widget.onSearchValueChanged(value);
                    }),
              ),
            ],
          )),
          Column(
            children: [
              FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Colors.black,
                onPressed: () {
                  widget.onFilterPressed();
                },
                child: const Icon(Icons.filter_list_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
