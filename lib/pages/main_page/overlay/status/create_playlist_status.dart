import 'package:flutter/material.dart';

class CreatePlaylistStatus with ChangeNotifier {
  final BuildContext context;
  final int mixID;

  CreatePlaylistStatus(this.context, this.mixID);
}
