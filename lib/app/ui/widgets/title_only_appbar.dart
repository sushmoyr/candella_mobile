import 'package:flutter/material.dart';

class TitleOnlyAppbar extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final Widget? trailing;
  final VoidCallback? onTap;
  const TitleOnlyAppbar(
      {Key? key, required this.title, this.style, this.trailing, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: style ?? Theme.of(context).textTheme.headline4,
          ),
        ),
        trailing ?? Container()
      ],
    );
  }
}
