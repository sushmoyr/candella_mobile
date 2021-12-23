import 'dart:io';

import 'package:candella/app/data/controllers/create_content_controller.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:candella/app/ui/screens/error_page.dart';
import 'package:candella/app/ui/widgets/loader.dart';
import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:candella/app/ui/widgets/title_only_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:ionicons/ionicons.dart';

class CreateContentScreen extends GetView<CreateContentController> {
  CreateContentScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Obx(
        () => AnimatedCrossFade(
          firstChild: Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                (controller.message.value != null)
                    ? Text(
                        controller.message.value!,
                        style: Theme.of(context).textTheme.caption,
                      )
                    : Container()
              ],
            ),
          ),
          secondChild: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleOnlyAppbar(
                      title: 'Write something Creative',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(height: 1.5),
                      trailing: AppIconButton(
                        iconData: Ionicons.close_outline,
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    _contentForm(context),
                  ],
                ),
              ),
            ),
          ),
          crossFadeState: (controller.loading.value)
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: Duration(
            milliseconds: 300,
          ),
        ),
      ),
    );
  }

  Widget _contentForm(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width / 2;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: imageWidth,
              child: InkWell(
                onTap: _pickImage,
                child: Obx(() => (controller.coverImage.value.isEmpty)
                    ? Container(
                        width: imageWidth,
                        height: imageWidth,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                        child: Icon(
                          Ionicons.camera_outline,
                          size: imageWidth * 0.3,
                          color: Colors.grey.shade500,
                        ),
                      )
                    : Image.file(
                        File(controller.coverImage.value),
                      )),
              ),
            ),
          ),
          TextFormField(
            controller: controller.title,
            validator: validateRequiredField,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: controller.description,
            validator: validateRequiredField,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          SizedBox(height: 8),
          DropdownButtonFormField<Category>(
            decoration: InputDecoration(labelText: 'Category'),
            value: controller.selectedCategory.value,
            icon: const Icon(Icons.arrow_drop_down_outlined),
            elevation: 16,
            onChanged: (Category? newValue) {
              controller.selectCategory(newValue!);
            },
            items: controller.categories
                .map<DropdownMenuItem<Category>>((Category value) {
              return DropdownMenuItem<Category>(
                value: value,
                child: Text(value.name),
              );
            }).toList(),
          ),
          Obx(
            () => ChipContainer(
              actionText: 'Add Genre',
              data: controller.addedGenres
                  .map((element) => element.name)
                  .toList(),
              onAction: () {
                Get.toNamed(Routes.selectGenre);
              },
            ),
          ),
          /*
          TODO: Add More Content {Add alternate names, tags}
          TODO: Add Image Service
           */
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.all(8),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.topLeft,
            title: Text('More Options'),
            children: [
              Text(
                'Alternate Titles',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              Obx(() => Column(
                    children: controller.alternateTitles
                        .map((element) => Text(
                              element,
                              style: Theme.of(context).textTheme.bodyText1,
                            ))
                        .toList(growable: true),
                  )),
              TextFormField(
                controller: controller.alternateTextField,
                decoration: InputDecoration(
                  hintText: 'Add Alternate Title',
                  helperText:
                      'Keep this field empty if there is not any alternate titles',
                ),
                onFieldSubmitted: (data) {
                  controller.addAlternateTitle(data);
                },
              ),
              TextFormField(
                controller: controller.tagsTextField,
                decoration: InputDecoration(
                    labelText: 'Tags',
                    helperText: 'Tags are separated by space.'),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Metadata',
                style: Theme.of(context).textTheme.headline6,
              ),
              AppIconButton(
                onTap: _handleSubmitContent,
                iconData: Ionicons.arrow_forward,
                mode: IconButtonMode.rounded,
                iconColor: Theme.of(context).colorScheme.onPrimary,
                elevation: 8,
              )
            ],
          ),
          SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }

  void _pickImage() async {
    var picked = await ImagesPicker.pick(
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio(2, 3),
      ),
    );
    if (picked != null) {
      controller.coverImage.value = picked.first.path;
    }
  }

  void _handleSubmitContent() async {
    var state = _formKey.currentState;

    if (state != null && state.validate()) {
      if (controller.addedGenres.isEmpty) {
        ScaffoldMessenger.of(_scaffoldKey.currentContext!)
            .showSnackBar(SnackBar(
          content: Text('A genre must be specified'),
        ));
        return;
      }
      var result = await controller.postContent();

      if (!result.status) {
        Get.to(ErrorScreen());
      } else {
        Get.toNamed(Routes.addChapter);
      }
    }
  }

  String? validateRequiredField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required Field';
    }
  }
}

class ChipContainer extends StatelessWidget {
  final List<String> data;
  final String actionText;
  final VoidCallback onAction;

  const ChipContainer(
      {Key? key,
      required this.data,
      required this.actionText,
      required this.onAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> chipData = [];

    if (data.isNotEmpty) {
      chipData.addAll(data.map((e) => Chip(
            label: Text(e),
            elevation: 4,
          )));
    }

    chipData.add(
      ActionChip(
        elevation: 4,
        label: Text(actionText),
        avatar: Icon(Ionicons.add),
        onPressed: onAction,
      ),
    );
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chipData,
    );
  }
}
