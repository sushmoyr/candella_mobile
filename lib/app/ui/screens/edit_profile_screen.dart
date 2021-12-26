import 'dart:io';

import 'package:candella/app/data/controllers/profile_screen_controller.dart';
import 'package:candella/app/resources/constants/app_strings.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/ui/widgets/editable_card.dart';
import 'package:candella/app/ui/widgets/loader.dart';
import 'package:candella/app/ui/widgets/password_field.dart';
import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:ionicons/ionicons.dart';

class EditProfile extends GetView<ProfileScreenController> {
  EditProfile({Key? key}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.subtitle1;
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.black.withAlpha(0),
      ),
      body: Obx(
        () => Loader(
          isLoading: controller.loading.value,
          message: controller.status.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Obx(
                        () => (controller.coverImage.value != null)
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
                      ), //Cover Image
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
                        onTap: _uploadCoverPhoto,
                        iconSize: 20,
                        contentPadding: 0,
                        iconData: Ionicons.camera_outline,
                        mode: IconButtonMode.rounded,
                      ),
                    ),
                  ),
                  Obx(
                    () => ClipOval(
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
                        onTap: _uploadProfilePhoto,
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
                          footer: Obx(
                            () => (controller.loadingAuthUpdate.value)
                                ? Center(
                                    child: SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        onPressed: _handleUpdateAction,
                                        child: Text('Update'),
                                      ),
                                      TextButton(
                                        onPressed: _handleCancelAction,
                                        child: Text('Cancel'),
                                      )
                                    ],
                                  ),
                          ),
                          children: [
                            EditableCardItem.from(
                              defaultWidget: Text(
                                controller.user.value.email!,
                                style: textStyle,
                              ),
                              editableWidget: TextFormField(
                                controller: controller.email,
                                decoration: InputDecoration(labelText: 'Email'),
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
                        Obx(
                          () => EditableCard(
                            title: 'Update About Info',
                            children: [
                              EditableCardItem.from(
                                defaultWidget: Text(
                                  controller.name.value.text,
                                  style: textStyle,
                                ),
                                editableWidget: TextFormField(
                                  controller: controller.name,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                  ),
                                ),
                              ),
                              EditableCardItem.from(
                                defaultWidget: Text(
                                  controller.penName.text,
                                  style: textStyle,
                                ),
                                editableWidget: TextFormField(
                                  controller: controller.penName,
                                  decoration: InputDecoration(
                                    labelText: 'Pen Name',
                                  ),
                                ),
                              ),
                              EditableCardItem.from(
                                defaultWidget: Text(
                                  controller.bio.text,
                                  style: textStyle,
                                ),
                                editableWidget: TextFormField(
                                  controller: controller.bio,
                                  decoration: InputDecoration(
                                    labelText: 'Bio',
                                  ),
                                ),
                              ),
                              EditableCardItem.from(
                                defaultWidget: Text(
                                  controller.gender.text,
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
                                  decoration: InputDecoration(
                                    labelText: 'Gender',
                                  ),
                                  onChanged: (value) {
                                    controller.gender.text = value!;
                                  },
                                ),
                              ),
                              EditableCardItem.from(
                                defaultWidget: Text(
                                  controller.birthdate.value!,
                                  style: textStyle,
                                ),
                                editableWidget: InkWell(
                                  onTap: () async {
                                    var currentBirthday =
                                        controller.getBirthDate();
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
                                        Obx(() => Text(controller
                                                .birthdate.value ??
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
                        ),
                        EditableCard(
                          title: 'Update Contact Info',
                          children: [
                            EditableCardItem.from(
                              defaultWidget: Text(
                                controller.phone.text,
                                style: textStyle,
                              ),
                              editableWidget: TextFormField(
                                controller: controller.phone,
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                ),
                              ),
                            ),
                            EditableCardItem.from(
                              defaultWidget: Text(
                                controller.address.text,
                                style: textStyle,
                              ),
                              editableWidget: TextFormField(
                                controller: controller.address,
                                decoration: InputDecoration(
                                  labelText: 'Address',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Update',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            AppIconButton(
                                mode: IconButtonMode.rounded,
                                iconColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                elevation: 8,
                                onTap: _handleUpdateProfile,
                                iconData: Ionicons.arrow_forward)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleUpdateAction() async {
    printInfo(info: 'Update Button Clicked');
    var result = await controller.updateSignInInfo();
    _showSnackBar(result.message);
    printInfo(info: result.message);
  }

  void _handleCancelAction() {
    printInfo(info: 'Cancel Button Clicked');
  }

  void _handleUpdateProfile() async {
    printInfo(info: 'Updating profile info');
    var result = await controller.updateUser();

    _showSnackBar(result.message);
  }

  void _showSnackBar(String message) {
    var context = _scaffoldKey.currentContext;
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _uploadCoverPhoto() async {
    var picked = await ImagesPicker.pick(
        quality: 0.8,
        cropOpt: CropOption(
          aspectRatio: CropAspectRatio(3, 2),
        ));

    if (picked != null) {
      controller.coverImage.value = picked.first.path;
    }
  }

  void _uploadProfilePhoto() async {
    var picked = await ImagesPicker.pick(
        quality: 0.8,
        cropOpt: CropOption(
          aspectRatio: CropAspectRatio(1, 1),
        ));

    if (picked != null) {
      controller.profileImage.value = picked.first.path;
    }
  }
}
