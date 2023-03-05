import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/src/presentation/app_colors.dart';
import 'package:notes/src/presentation/common_widgets/drop_down_menu/custom_dropdownmenu.dart';
import 'package:notes/src/presentation/common_widgets/drop_down_menu/drop_down_menu.dart';
class BuildAppBar extends StatefulWidget {
   const BuildAppBar( {
    super.key,
  });


  @override
  State<BuildAppBar> createState() => _BuildAppBarState();

}

class _BuildAppBarState extends State<BuildAppBar> with SingleTickerProviderStateMixin{
  late OverlayState overlayState;
  OverlayEntry? overlayEntry;
  AnimationController? animationController;
  Animation<double>? animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    overlayState = Overlay.of(context);
    animationController =
        AnimationController( duration: const Duration(milliseconds: 250), vsync: this);
    animation =
        CurveTween(curve: Curves.fastOutSlowIn).animate(animationController!);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Notes',
              style: GoogleFonts.acme(
                color: AppColors.darkBrown,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: _appBarActions(),
          ),
        ],
      ),
    );
  }

  void buildDropDownMenu () async
  {
    overlayEntry=OverlayEntry(builder: (appContext){
      return  Material(color: Colors.transparent,
        child: FadeTransition(opacity: animation!,
      child: CustomDropDownMenuWidget(onClose: removeHighlightOverlay,
            ),),);
    },);
    animationController!.addListener(() {
      overlayState.setState(() {});
    });
    overlayState.insert(overlayEntry!);
    animationController!.forward();

  }
  void removeHighlightOverlay() {
    animationController?.reverse();
    overlayEntry?.remove();
    overlayEntry = null;
  }
  @override
  void dispose() {
    // Make sure to remove OverlayEntry when the widget is disposed.
    removeHighlightOverlay();
    super.dispose();
  }
  List<Widget> _appBarActions() {
    return  [
      //DropDownMenuWidget(),
      IconButton(icon: const Icon(Icons.more_horiz,color: AppColors.darkBrown,), onPressed: buildDropDownMenu,iconSize: 36,),
      const SizedBox(width: 10),
    ];
  }
}
