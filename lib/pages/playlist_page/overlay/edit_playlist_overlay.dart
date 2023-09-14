import 'package:Effexxion/hive/playlist_hive.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditPlaylistOverlay extends ModalRoute<void> {
  final int playlistId;
  final bool isPlaying;

  EditPlaylistOverlay({required this.playlistId, required this.isPlaying});

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
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Center(
          child: EditPlaylistPage(playlistId: playlistId, isPlaying: isPlaying),
        ),
      ),
    );
  }
}

class EditPlaylistPage extends StatelessWidget {
  final int playlistId;
  final bool isPlaying;

  const EditPlaylistPage({super.key, required this.playlistId, required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditPlaylistPageState>(
      create: (_) => EditPlaylistPageState(context, playlistId),
      child: Consumer<EditPlaylistPageState>(
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
                    style: whiteTextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
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
                  30.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isPlaying
                          ? Container()
                          : NormalButton(
                              image: "assets/images/close.png",
                              onPressed: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                state.delete();
                              },
                            ),
                      NormalButton(
                        image: "assets/images/save.png",
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          state.save();
                        },
                      ),
                    ],
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

class EditPlaylistPageState with ChangeNotifier {
  final BuildContext context;
  final int playlistId;

  EditPlaylistPageState(this.context, this.playlistId) {
    _initState();
  }

  _initState() {
    PlayListHive? hive = HiveHelper.getPlayListById(playlistId);
    if (hive != null) {
      _playlistName = ValidateItem(hive.title, "");
      playListController.text = hive.title;
      notifyListeners();
    } else {
      Helper.showToast("Invalid Request!", false);
      Helper.finish(context);
    }
  }

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

  save() {
    if (_playlistName.value.isEmpty) {
      _playlistName = ValidateItem("", "Playlist name is required!");
      notifyListeners();
      return;
    }
    _playlistName = ValidateItem(playlistName.value, "");
    notifyListeners();
    HiveHelper.updatePlayListTitle(_playlistName.value, playlistId);
    Helper.showToast("Success!", true);
    Helper.finish(context);
  }

  onYesHandler() {
    HiveHelper.deletePlayListById(playlistId);
    Helper.showToast("Deleted Successfully!", true);
    if (context.mounted) {
      Helper.finish(context);
    }
  }

  delete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Warning"),
          content: const Text("Do you really want to delete this Playlist!"),
          actions: [
            TextButton(
              onPressed: () {
                Helper.finish(context);
                onYesHandler();
              },
              child: const Text("YES"),
            ),
            TextButton(
              onPressed: () {
                Helper.finish(context);
              },
              child: const Text("NO"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    playlistNode.dispose();
    playListController.dispose();
    super.dispose();
  }
}
