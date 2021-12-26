import 'package:flutter/material.dart';

enum IconButtonMode { rounded, original }

class AppIconButton extends StatelessWidget {
  final IconButtonMode mode;
  final VoidCallback onTap;
  final IconData iconData;
  final double? iconSize;
  final double? contentPadding;
  final Color? color;
  final Color? iconColor;
  final double? elevation;
  final bool addBorder;
  final double buttonSize;

  const AppIconButton({
    Key? key,
    this.mode = IconButtonMode.original,
    required this.onTap,
    required this.iconData,
    this.iconSize,
    this.color,
    this.contentPadding,
    this.elevation,
    this.iconColor,
    this.addBorder = false,
    this.buttonSize = 54,
  }) : super(key: key);

  Widget _getIconButton(context) {
    return IconButton(
      constraints: BoxConstraints(
        maxWidth: buttonSize,
        maxHeight: buttonSize,
        minHeight: buttonSize,
        minWidth: buttonSize,
      ),
      onPressed: onTap,
      iconSize: iconSize ?? 24.0,
      icon: Icon(
        iconData,
        color: iconColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mode == IconButtonMode.original) {
      return _getIconButton(context);
    } else {
      return Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(Radius.circular((iconSize ?? 24) * 2)),
        elevation: elevation ?? 0,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(contentPadding ?? 0),
            child: _getIconButton(context),
            decoration: BoxDecoration(
              color: color ?? Theme.of(context).primaryColor,
              border: (addBorder) ? Border.all(width: 0.8) : null,
              borderRadius: BorderRadius.all(
                Radius.circular((iconSize ?? 24) * 2),
              ),
            ),
          ),
        ),
      );
    }
  }
}
