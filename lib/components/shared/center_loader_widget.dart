import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/loader/gf_loader.dart';

class CenterLoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
        child: GFLoader()
    );
  }
}