import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CreateNewPlayListOverlay extends ModalRoute<void> {
  @override
  Color? get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => "";

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return const Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Center(
          child: CreateNewPlayListPage(),
        ),
      ),
    );
  }
}

class CreateNewPlayListPage extends StatelessWidget {
  const CreateNewPlayListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateNewPlayListPageStatus>(
      create: (_) => CreateNewPlayListPageStatus(context),
      child: Consumer<CreateNewPlayListPageStatus>(
        builder: (_, state, __) => SizedBox(
          width: 0.9.sw,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.w),
              color: const Color(0xFF161A26),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.height,
                  Text(
                    "Playlist name",
                    style: whiteTextStyle().copyWith(fontSize: 16.sp),
                  ),
                  TextField(
                    focusNode: state.playlistNode,
                    controller: state.playListController,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    style: whiteTextStyle(),
                    onChanged: state.changeName,
                    decoration: normalInputDecoration(hint: "Playlist name").copyWith(
                      errorText: state.playlistName.error != "" ? state.playlistName.error : null,
                    ),
                    autofocus: true,
                  ),
                  20.height,
                  Align(
                    alignment: Alignment.centerRight,
                    child: NormalButton(
                      image: "assets/images/save.png",
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        state.save();
                      },
                    ),
                  ),
                  30.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateNewPlayListPageStatus with ChangeNotifier {
  final BuildContext context;

  CreateNewPlayListPageStatus(this.context);

  ValidateItem _playlistName = ValidateItem("", "");

  ValidateItem get playlistName => _playlistName;

  final FocusNode playlistNode = FocusNode();
  final playListController = TextEditingController();

  void changeName(String value) {
    if (value.isEmpty) {
      _playlistName = ValidateItem("", "Playlist name is required!");
    } else {
      _playlistName = ValidateItem(value, "");
    }
    notifyListeners();
  }

  save() async {
    if (_playlistName.value.isEmpty) {
      _playlistName = ValidateItem("", "Playlist name is required!");
      notifyListeners();
      return;
    }
    _playlistName = ValidateItem(playlistName.value, "");
    notifyListeners();
    await HiveHelper.addNewPlayList(_playlistName.value);
    Helper.showToast("Created new playlist!", true);
    if (context.mounted) {
      Helper.finish(context);
    }
  }

  @override
  void dispose() {
    playlistNode.dispose();
    playListController.dispose();
    super.dispose();
  }
}
