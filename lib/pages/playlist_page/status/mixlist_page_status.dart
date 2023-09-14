import 'package:Effexxion/utils/helper.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/material.dart';

class MixListPageStatus with ChangeNotifier {
  final BuildContext context;

  MixListPageStatus(this.context);

  onRemoveMix(int mixId) {
    HiveHelper.removeMix(mixId);
    Helper.showToast("Deleted successfully!", true);
  }
}
