import 'package:flutter/material.dart';
import 'package:out_app/user_side/home_body/components/card_components/price.dart';

class RestaurantTablesHead extends StatelessWidget {
  const RestaurantTablesHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText1,
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.table_rows_outlined,
                    size: 20,
                  ),
                ),
                TextSpan(text: ' ' + "4" + '  •  ' + "opened"),
              ],
            ),
          ),
          Text(getPriceFromInt(2)),
        ]);
  }
}
