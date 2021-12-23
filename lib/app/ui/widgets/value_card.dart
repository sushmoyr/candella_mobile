import 'package:flutter/material.dart';

class ValueCard extends StatelessWidget {
  final num value;
  final String name;
  final TextStyle? valueTextStyle;
  final TextStyle? nameTextStyle;
  final Axis? direction;
  final Widget? valueWidget;
  final Alignment? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onClick;

  const ValueCard({
    Key? key,
    this.value = 0,
    this.name = '',
    this.valueTextStyle,
    this.nameTextStyle,
    this.direction,
    this.alignment,
    this.padding,
    this.margin,
    this.valueWidget,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String modifiedValue = '$value';
    if (value >= 1000) {
      var newValue = value / 1000;
      modifiedValue = '${newValue}K';
    }
    return Container(
      alignment: alignment ?? Alignment.center,
      padding: padding ?? EdgeInsets.all(16),
      margin: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onClick,
        child: Wrap(
          direction: direction ?? Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              height: 36,
              child: (valueWidget != null)
                  ? Center(child: valueWidget!)
                  : Center(
                      child: Text(
                        modifiedValue,
                        style: valueTextStyle ??
                            Theme.of(context).textTheme.headline6,
                      ),
                    ),
            ),
            Text(
              name,
              style: nameTextStyle ?? Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
