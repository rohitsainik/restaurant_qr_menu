import 'package:flutter/material.dart';

class VegComponent extends StatelessWidget {
  final double? size;
  final bool? isAvailableToday;

  VegComponent({this.size = 20, this.isAvailableToday});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          border: Border.all(
              color: isAvailableToday == false ? Colors.grey : Colors.green)),
      child: Icon(Icons.circle,
          size: size! - 2,
          color: isAvailableToday == false ? Colors.grey : Colors.green),
    );
  }
}

class NonVegComponent extends StatelessWidget {
  final double? size;
  final bool? isAvailableToday;

  NonVegComponent({this.size = 20, this.isAvailableToday});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          border: Border.all(
              color: isAvailableToday == false ? Colors.grey : Colors.red)),
      child: Icon(Icons.circle,
          size: size! - 2,
          color: isAvailableToday == false ? Colors.grey : Colors.red),
    );
  }
}
