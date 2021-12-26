import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

enum EditableCardState { edit, view }

class EditableCard extends StatefulWidget {
  final String title;
  final List<EditableCardItem> children;
  final Widget? footer;
  final bool enabled = true;

  const EditableCard(
      {Key? key, required this.title, required this.children, this.footer})
      : super(key: key);

  @override
  State<EditableCard> createState() => _EditableCardState();
}

class _EditableCardState extends State<EditableCard> {
  bool isEditing = false;

  void _cycleCard() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            AppIconButton(
                onTap: _cycleCard,
                iconData: (isEditing)
                    ? Ionicons.close_outline
                    : Ionicons.pencil_outline)
          ],
        ),
        SizedBox(height: 16),
        ...List.from(
          widget.children.map(
            (e) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: e.useWidget((isEditing)
                  ? EditableCardState.edit
                  : EditableCardState.view),
            ),
          ),
        ),
        (isEditing && widget.footer != null) ? widget.footer! : Container()
      ],
    );
  }
}

class EditableCardItem {
  Widget defaultWidget;
  Widget editableWidget;

  EditableCardItem.from(
      {required this.defaultWidget, required this.editableWidget});

  Widget useWidget(EditableCardState state) =>
      (state == EditableCardState.view) ? defaultWidget : editableWidget;
}
