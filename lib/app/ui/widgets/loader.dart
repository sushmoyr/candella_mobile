import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key, required this.isLoading, this.child})
      : super(key: key);
  final bool isLoading;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    print(isLoading);
    return (isLoading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : child ?? Container();
  }
}
