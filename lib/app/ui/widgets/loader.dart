import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key, required this.isLoading, this.child, this.message})
      : super(key: key);
  final bool isLoading;
  final Widget? child;
  final String? message;

  @override
  Widget build(BuildContext context) {
    print(isLoading);
    return (isLoading)
        ? Column(
            children: [
              CircularProgressIndicator(),
              (message != null)
                  ? Text(
                      message!,
                      style: Theme.of(context).textTheme.caption,
                    )
                  : Container()
            ],
          )
        : child ?? Container();
  }
}
