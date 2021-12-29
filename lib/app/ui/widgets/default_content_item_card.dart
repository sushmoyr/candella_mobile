import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/data/models/genre.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class DefaultContentItemCard extends StatelessWidget {
  final Content content;
  final VoidCallback onItemClick;
  final VoidCallback? onAuthorClick;
  final double? elevation;

  const DefaultContentItemCard({
    Key? key,
    required this.content,
    required this.onItemClick,
    this.onAuthorClick,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                EndPoints.host + content.coverImage,
                fit: BoxFit.cover,
              ),
              flex: 2,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    content.category.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.overline,
                  ),
                  ListTile(
                    horizontalTitleGap: 4,
                    contentPadding: EdgeInsets.zero,
                    onTap: onAuthorClick,
                    leading: ClipOval(
                      child: CircleAvatar(
                        radius: 16,
                        child: Image.network(
                            EndPoints.host + content.author.profileImage),
                      ),
                    ),
                    title: (content.author.penName.isNotEmpty)
                        ? Text(content.author.penName)
                        : Text(content.author.name),
                  ),
                  Text(
                    content.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    _getGenreText(content.genre),
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
              flex: 3,
            ),
          ],
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
