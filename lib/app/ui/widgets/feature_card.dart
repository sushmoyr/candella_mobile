import 'dart:ui';

import 'package:candella/app/data/models/FeaturedContent/featured_content_model.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({
    Key? key,
    required this.content,
    required this.onItemClicked,
  }) : super(key: key);
  final FeaturedContent content;
  final Function(FeaturedContent) onItemClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(16),
        elevation: 8,
        child: InkWell(
          onTap: () {
            printInfo(info: 'clicked');
            onItemClicked(content);
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.network(
                  EndPoints.host + content.coverImage,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            content.title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            content.author.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            content.description,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text('Category: ${content.category.name}')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
