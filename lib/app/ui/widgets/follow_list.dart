import 'package:candella/app/data/models/follow_user.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowList extends StatelessWidget {
  final List<FollowUser> data;

  const FollowList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: Text('No Following User'),
      );
    } else {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, i) {
            FollowUser user = data[i];
            return ListTile(
              leading: ClipOval(
                child: CircleAvatar(
                  child: Image.network(EndPoints.host + user.profileImage),
                ),
              ),
              title: Text(user.name),
              subtitle: Text(user.penName),
              onTap: () {
                Get.toNamed(
                  Routes.visitProfile,
                  parameters: {
                    'id': user.id,
                  },
                );
              },
            );
          });
    }
  }
}
