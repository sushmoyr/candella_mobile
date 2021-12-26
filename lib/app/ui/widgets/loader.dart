import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key, required this.isLoading, this.child, this.message})
      : super(key: key);
  final bool isLoading;
  final Widget? child;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8),
                (message != null)
                    ? Text(
                        message!,
                        style: Theme.of(context).textTheme.caption,
                      )
                    : Container()
              ],
            ),
          )
        : child ?? Container();
  }
}
