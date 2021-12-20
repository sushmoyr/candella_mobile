import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final IconData? collapsedStateIcon;
  final IconData? expandStateIcon;
  final List<Widget> children;
  final int? defaultItemCount;
  final double elevation;
  final double radius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final CrossAxisAlignment childrenAlignment;

  const ExpandableCard(
      {Key? key,
      required this.title,
      this.collapsedStateIcon,
      this.expandStateIcon,
      required this.children,
      this.defaultItemCount,
      this.titleStyle,
      this.elevation = 0,
      this.padding = const EdgeInsets.all(16),
      this.childrenAlignment = CrossAxisAlignment.start,
      this.margin,
      this.radius = 0})
      : super(key: key);

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool isExpanded = false;
  late List<Widget> children = widget.children;
  @override
  Widget build(BuildContext context) {
    int itemCount = 0;
    if (widget.defaultItemCount == null) {
      itemCount = (widget.children.length <= 2) ? widget.children.length : 2;
    }

    int take;

    if (isExpanded) {
      take = widget.children.length;
    } else {
      take = widget.defaultItemCount ?? itemCount;
    }

    return GestureDetector(
      onTap: _setExpansion,
      child: Material(
        clipBehavior: Clip.antiAlias,
        elevation: widget.elevation,
        child: AnimatedContainer(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          padding: widget.padding,
          curve: Curves.decelerate,
          duration: Duration(seconds: 3),
          child: Column(
            crossAxisAlignment: widget.childrenAlignment,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: widget.titleStyle,
                  ),
                  Icon((isExpanded)
                      ? widget.expandStateIcon ?? Icons.arrow_drop_up_outlined
                      : widget.collapsedStateIcon ?? Icons.arrow_drop_down)
                ],
              ),
              Column(
                crossAxisAlignment: widget.childrenAlignment,
                children: widget.children.take(take).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _setExpansion() {
    setState(() {
      print('Set expansion from');
      print(isExpanded);
      isExpanded = !isExpanded;
      print('to $isExpanded');
    });
  }
}
