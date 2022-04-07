import 'package:flutter/material.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/logo_black.png', scale: 1),
              IconButton(
                color: const Color(0xFF77767F),
                iconSize: 32,
                onPressed: () {
                  // Respond to button press
                },
                icon: const Icon(Icons.notifications),
              )
            ],
          ),
        ))
      ],
    );
  }
}
