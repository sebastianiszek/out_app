import 'package:flutter/material.dart';
import '../../home_body/components/card_components/price.dart';

class FilterDialogBody extends StatefulWidget {
  const FilterDialogBody(
      {Key? key, required this.priceFilter, required this.onFilterChanged})
      : super(key: key);
  final List<bool> priceFilter;
  final Function(List<bool>) onFilterChanged;

  @override
  State<FilterDialogBody> createState() => _FilterDialogBodyState();
}

class _FilterDialogBodyState extends State<FilterDialogBody> {
  List<bool> priceFilter = [true, true, true, false, true];

  @override
  void initState() {
    super.initState();
    priceFilter = widget.priceFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 5),
          child: Row(
            children: const [
              Text(
                'Only Show Places',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 0, bottom: 0),
          child: Row(
            children: [
              Checkbox(
                onChanged: (value) {
                  setState(() {
                    priceFilter[3] = value!;
                    widget.onFilterChanged(priceFilter);
                  });
                },
                value: priceFilter[3],
              ),
              Text('With Available Tables',
                  style: Theme.of(context).textTheme.bodyText1),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 0, bottom: 0),
          child: Row(
            children: [
              Checkbox(
                onChanged: (value) {
                  setState(() {
                    priceFilter[4] = value!;
                    widget.onFilterChanged(priceFilter);
                  });
                },
                value: priceFilter[4],
              ),
              Text('That are opened',
                  style: Theme.of(context).textTheme.bodyText1),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 5),
          child: Row(
            children: const [
              Text(
                'Filter based on price: ',
              ),
            ],
          ),
        ),
        for (var i = 0; i < 3; i += 1)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 0, bottom: 0),
            child: Row(
              children: [
                Checkbox(
                  onChanged: (value) {
                    setState(() {
                      priceFilter[i] = value!;
                      widget.onFilterChanged(priceFilter);
                    });
                  },
                  value: priceFilter[i],
                ),
                Text(getPriceFromInt(i + 1),
                    style: Theme.of(context).textTheme.bodyText1),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ),
      ],
    );
  }
}
