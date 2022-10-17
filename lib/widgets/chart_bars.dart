import 'package:flutter/material.dart';

class ChartBars extends StatelessWidget {
  final String label;
  final double amountValue;
  final double totalAmountPercentage;
  const ChartBars({
    super.key,
    required this.amountValue,
    required this.label,
    required this.totalAmountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        children: [
          SizedBox(
            height: constraint.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                amountValue.toStringAsFixed(0),
              ),
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraint.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: totalAmountPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        color: Theme.of(context).primaryColorLight,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                )
              ],
            ),
          ),
          // SizedBox(
          //   width: 30,
          //   height: 30,
          //   child: Stack(
          //     fit: StackFit.expand,
          //     children: [
          //       CircularProgressIndicator(
          //         value: totalAmountPercentage,
          //         backgroundColor: Theme.of(context).accentColor,
          //         color: Theme.of(context).primaryColorDark,
          //         strokeWidth: 7,
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraint.maxHeight * 0.15,
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
