import 'package:flutter/material.dart';

import '../out_app_icons.dart';

Icon getTableIcon(int places, double size) {
  if (places == 0) {
    return Icon(
      OutApp.table_restaurant,
      color: const Color(0xFFBA1B1B),
      size: size,
    );
  } else {
    return Icon(
      OutApp.table_restaurant,
      color: const Color(0xFF78536C),
      size: size,
    );
  }
}
