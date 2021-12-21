import 'package:candella/app/data/controllers/create_content_controller.dart';
import 'package:candella/app/data/models/genre.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:candella/app/ui/widgets/loader.dart';
import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:candella/app/ui/widgets/title_only_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CreateContentScreen extends GetView<CreateContentController> {
  CreateContentScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
    );
  }

  Widget _contentForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller.title,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: controller.description,
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
        ],
      ),
    );
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
