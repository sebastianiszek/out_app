import 'package:flutter/material.dart';

Icon getTableIcon(int places, double size) {
  if (places == 0) {
    return Icon(
      Icons.table_restaurant,
      color: const Color(0xFFBA1B1B),
      size: size,
    );
  } else {
    return Icon(
      Icons.table_restaurant,
      color: const Color(0xFF78536C),
      size: size,
    );
  }
}
