import 'dart:io';

import 'package:candella/app/data/controllers/profile_screen_controller.dart';
import 'package:candella/app/resources/constants/app_strings.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class EditProfile extends GetView<ProfileScreenController> {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.subtitle1;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.black.withAlpha(0),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  (controller.coverImage.value != null)
                      ? Image.file(
                          File(controller.coverImage.value!),
                        )
                      : Image.network(
                          controller.user.value.coverImage,
                          loadingBuilder: (context, widget, loading) {
                            if (loading == null) {
                              return widget;
                            }
                            return Image.asset(
                              StringRes.defaultCoverImage,
                            );
                          },
                        ),
                  SizedBox(
                    height: 64,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 16,
                  bottom: 80,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: AppIconButton(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.5),
                    onTap: () {},
                    iconSize: 20,
                    contentPadding: 0,
                    iconData: Ionicons.camera_outline,
                    mode: IconButtonMode.rounded,
                  ),
                ),
              ),
              ClipOval(
                child: CircleAvatar(
                  child: (controller.profileImage.value != null)
                      ? Image.file(File(controller.profileImage.value!))
                      : Image.network(
                          controller.user.value.profileImage,
                          loadingBuilder: (context, child, loading) {
                            if (loading == null) {
                              return child;
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                  radius: 64,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: AppIconButton(
                    addBorder: true,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.5),
                    onTap: () {},
                    iconSize: 20,
                    contentPadding: 0,
                    iconData: Ionicons.camera_outline,
                    mode: IconButtonMode.rounded,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    //Auth info card
                    EditableCard(
                      title: 'Update Sign-in Info',
                      onCancelClick: _handleCancelAction,
                      onUpdateClick: _handleUpdateAction,
                      children: [
                        EditableCardItem.from(
                          defaultWidget: Text(
                            controller.user.value.email!,
                            style: textStyle,
                          ),
                          editableWidget: TextFormField(
                            controller: controller.email,
                          ),
                        ),
                        EditableCardItem.from(
                          defaultWidget: Container(),
                          editableWidget: PasswordFormField(
                            controller: controller.oldPassword,
                            labelText: 'Old Password',
                          ),
                        ),
                        EditableCardItem.from(
                          defaultWidget: Container(),
                          editableWidget: PasswordFormField(
                            controller: controller.newPassword,
                            labelText: 'New Password',
                          ),
                        ),
                        EditableCardItem.from(
                          defaultWidget: Container(),
                          editableWidget: PasswordFormField(
                            controller: controller.confirmPassword,
                            labelText: 'Confirm Password',
                          ),
                        ),
                      ],
                    ),
                    //About Info Card
                    EditableCard(
                      title: 'Update About Info',
                      onCancelClick: _handleCancelAction,
                      onUpdateClick: _handleUpdateAction,
                      children: [
                        EditableCardItem.from(
                          defaultWidget: Text(
                            controller.user.value.name,
                            style: textStyle,
                          ),
                          editableWidget: TextFormField(
                            readOnly: true,
                            controller: controller.name,
                          ),
                        ),
                        EditableCardItem.from(
                          defaultWidget: Text(
                            controller.user.value.penName ??
                                StringRes.noPenName,
                            style: textStyle,
                          ),
                          editableWidget: TextFormField(
                            controller: controller.penName,
                          ),
                        ),
                        EditableCardItem.from(
                          defaultWidget: Text(
                            controller.user.value.bio ?? StringRes.noBio,
                            style: textStyle,
                          ),
                          editableWidget: TextFormField(
                            controller: controller.bio,
                          ),
                        ),
                        EditableCardItem.from(
                          defaultWidget: Text(
                            controller.user.value.gender,
                            style: textStyle,
                          ),
                          editableWidget: DropdownButtonFormField<String>(
                            items: [
                              DropdownMenuItem(
                                child: Text(Gender.male),
                                value: Gender.male,
                              ),
                              DropdownMenuItem(
                                child: Text(Gender.female),
                                value: Gender.female,
                              ),
                              DropdownMenuItem(
                                child: Text(Gender.notSpecified),
                                value: Gender.notSpecified,
                              ),
                            ],
                            value: controller.user.value.gender,
                            onChanged: (value) {
                              controller.gender.text = value!;
                            },
                          ),
                        ),
                        EditableCardItem.from(
                          defaultWidget: Text(
                            controller.user.value.birthdate,
                            style: textStyle,
                          ),
                          editableWidget: InkWell(
                            onTap: () async {
                              var currentBirthday = controller.getBirthDate();
                              var dateTime = await showDatePicker(
                                context: context,
                                initialDate: currentBirthday,
                                firstDate: DateTime(1700),
                                lastDate: DateTime(2011),
                              );
                              if (dateTime != null) {
                                controller.birthdate.value =
                                    "${dateTime.day}/${dateTime.month}/${dateTime.year}";
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 0.5),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx(() => Text(controller.birthdate.value ??
                                      controller.user.value.birthdate)),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(Ionicons.calendar_clear_outline),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    EditableCard(
                        title: 'Update Contact Info',
                        children: [
                          EditableCardItem.from(
                            defaultWidget: Text(
                              controller.user.value.phone ?? StringRes.noPhone,
                              style: textStyle,
                            ),
                            editableWidget: TextFormField(
                              controller: controller.phone,
                            ),
                          ),
                          EditableCardItem.from(
                            defaultWidget: Text(
                              controller.user.value.address ??
                                  StringRes.noAddress,
                              style: textStyle,
                            ),
                            editableWidget: TextFormField(
                              controller: controller.address,
                            ),
                          ),
                        ],
                        onUpdateClick: _handleUpdateAction,
                        onCancelClick: _handleCancelAction),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleUpdateAction() {
    printInfo(info: 'Update Button Clicked');
  }

  void _handleCancelAction() {
    printInfo(info: 'Cancel Button Clicked');
  }
}

enum EditableCardState { edit, view }

class EditableCard extends StatefulWidget {
  final String title;
  final List<EditableCardItem> children;
  final VoidCallback onUpdateClick;
  final VoidCallback onCancelClick;
  final bool enabled = true;

  const EditableCard(
      {Key? key,
      required this.title,
      required this.children,
      required this.onUpdateClick,
      required this.onCancelClick})
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
        if (isEditing)
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: (widget.enabled) ? widget.onUpdateClick : null,
                child: Text('Update'),
              ),
              SizedBox(
                width: 16,
              ),
              TextButton(
                onPressed: (widget.enabled) ? widget.onCancelClick : null,
                child: Text('Cancel'),
              ),
            ],
          ),
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

class PasswordFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;

  const PasswordFormField(
      {Key? key,
      required this.controller,
      this.hintText,
      this.labelText,
      this.helperText})
      : super(key: key);

  final TextEditingController controller;

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool obSecure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obSecure,
      decoration: InputDecoration(
          suffixIcon: (obSecure)
              ? AppIconButton(
                  onTap: () {
                    setState(() {
                      obSecure = !obSecure;
                    });
                  },
                  iconData: Icons.visibility,
                )
              : AppIconButton(
                  onTap: () {
                    setState(() {
                      obSecure = !obSecure;
                    });
                  },
                  iconData: Icons.visibility_off,
                ),
          labelText: widget.labelText,
          helperText: widget.helperText,
          hintText: widget.hintText),
    );
  }
}
