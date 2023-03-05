
import 'package:flutter/cupertino.dart';

class CupertirnoMenuActionWidget extends StatelessWidget {
  const CupertirnoMenuActionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        width: double.infinity,
        child:CupertinoContextMenu(
          actions:[
            CupertinoContextMenuAction(
              onPressed: (){

              },
              trailingIcon: CupertinoIcons.share,
              child:const Text("Share"),
            ),
            CupertinoContextMenuAction(
              onPressed: (){

              },
              trailingIcon: CupertinoIcons.down_arrow,
              child:const Text("Save To Gallery"),
            ),
            CupertinoContextMenuAction(
              onPressed: (){
              },
              isDestructiveAction: true,
              trailingIcon: CupertinoIcons.delete,
              child: const Text("Delete"),
            )
          ],
          child:Container(),
        ),
      ),
    );
}}
