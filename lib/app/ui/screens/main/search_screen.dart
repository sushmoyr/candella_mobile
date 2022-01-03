import 'package:candella/app/data/controllers/search_controller.dart';
import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:candella/app/ui/widgets/default_content_item_card.dart';
import 'package:candella/app/ui/widgets/landscape_content_item_card.dart';
import 'package:candella/app/ui/widgets/title_only_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TitleOnlyAppbar(title: 'Search'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                margin: EdgeInsets.only(top: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                ),
                child: TextField(
                  onSubmitted: _searchSubmit,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    icon: Icon(Ionicons.search_outline),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Obx(
                    () => SearchResult(
                      data: controller.searchResult.value,
                      message: controller.message.value,
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

  void _searchSubmit(String s) {
    s.printInfo();
    controller.search(s);
  }
}

class SearchResult extends StatelessWidget {
  final List<Content> data;
  final String message;

  const SearchResult(
      {Key? key, required this.data, this.message = 'Search Content'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (data.isEmpty)
        ? SizedBox(
            height: MediaQuery.of(context).size.height - 60,
            child: Center(
              child: Text(message),
            ),
          )
        : ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, idx) {
              if (data[idx].category.id == Category.photography.id ||
                  data[idx].category.id == Category.journal.id) {
                return LandscapeContentItemCard(
                  content: data[idx],
                  onClick: _onContentClick,
                );
              } else {
                return DefaultContentItemCard(
                    content: data[idx], onItemClick: _onContentClick);
              }
            },
          );
  }

  void _onContentClick(Content content) {
    Get.toNamed(
      Routes.content,
      arguments: {
        "content": content,
      },
    );
  }
}
