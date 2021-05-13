import 'package:flutter/cupertino.dart';

class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CupertinoActivityIndicator(
        radius: 15,
      ),
    );
  }
}
