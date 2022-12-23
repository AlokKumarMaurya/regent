 import 'package:flutter/material.dart';


class CustomListTile extends StatelessWidget {
  Widget? leadingWidget;
  Widget titleWidget;
  Function handle_tap;
   CustomListTile({Key? key,required this.titleWidget, this.leadingWidget,required this.handle_tap()}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListTile(
        onTap: ()=>handle_tap(),
        minLeadingWidth: 00.00,
        leading: leadingWidget??Container(width: 0,),
        title: titleWidget,
      ),
    );
  }
}
