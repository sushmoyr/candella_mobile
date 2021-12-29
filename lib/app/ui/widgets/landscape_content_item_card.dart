import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:flutter/material.dart';

class LandscapeContentItemCard extends StatelessWidget {
  final Content content;
  final VoidCallback onClick;

  const LandscapeContentItemCard({
    Key? key,
    required this.content,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(EndPoints.host + content.coverImage),
      title: Text(
        content.title,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
