import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/data/models/genre.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class LandscapeContentItemCard extends StatelessWidget {
  final Content content;
  final Function(Content)? onClick;
  final double? elevation;

  const LandscapeContentItemCard({
    Key? key,
    required this.content,
    required this.onClick,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        clipBehavior: Clip.antiAlias,
        elevation: elevation ?? 0,
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
        child: InkWell(
          onTap: () {
            if (onClick != null) {
              onClick!(content);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 2,
                child: Image.network(
                  EndPoints.host + content.coverImage,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    ListTile(
                      horizontalTitleGap: 4,
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      onTap: () {
                        printInfo(info: content.author.name);
                        Get.toNamed(
                          Routes.visitProfile,
                          parameters: {
                            'id': content.author.id,
                          },
                        );
                      },
                      title: Text(
                        content.author.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      leading: ClipOval(
                        child: CircleAvatar(
                          radius: 16,
                          child: Image.network(
                              EndPoints.host + content.author.profileImage),
                        ),
                      ),
                    ),
                    Text(
                      _getGenreText(content.genre),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Icon(
                              Ionicons.eye_outline,
                              size: 20,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Text(
                              content.views.toString(),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Icon(
                              Ionicons.chatbox_outline,
                              size: 20,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Text(
                              content.totalReviews.toString(),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getGenreText(List<Genre> genres) {
    String res = '';

    for (int i = 0; i < genres.length; i++) {
      res += genres[i].name;
      if (i + 1 != genres.length) {
        res += ', ';
      }
    }

    return res;
  }
}
