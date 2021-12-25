import 'package:calculators/models/financing_type.dart';
import 'package:flutter/material.dart';

class FinancingTypeDropDown extends StatefulWidget {
  const FinancingTypeDropDown({
    Key? key,
    required this.initialValue,
    this.onChanged
  }) : super(key: key);

  final FinancingType initialValue;
  final Function? onChanged;

  @override
  State<FinancingTypeDropDown> createState() => _FinancingTypeDropDownState();
}

class _FinancingTypeDropDownState extends State<FinancingTypeDropDown> {
  late FinancingType value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton<FinancingType>(
      value: value,
      items: FinancingType.values
          .map((FinancingType financingType) =>
          DropdownMenuItem<FinancingType>(
              value: financingType,
              child: Text(FinancingTypeUtils(financingType).name)))
          .toList(),
      onChanged: (FinancingType? newValue) {
        if (newValue != null) {
          setState(() {
            value = newValue;
          });
        }
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
      },
    );
  }
}