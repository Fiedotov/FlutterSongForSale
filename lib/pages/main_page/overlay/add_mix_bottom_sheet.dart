// ignore_for_file: non_constant_identifier_names

import 'package:Effexxion/hive/mix_hive.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddMixBottomSheet extends StatelessWidget {
  final MixHive music;
  final double volume;
  final double mix_A_volume;
  final double mix_B_volume;
  final double mix_C_volume;
  final double mix_D_volume;
  final double mix_E_volume;
  final double mix_F_volume;

  const AddMixBottomSheet({
    super.key,
    required this.music,
    required this.volume,
    required this.mix_A_volume,
    required this.mix_B_volume,
    required this.mix_C_volume,
    required this.mix_D_volume,
    required this.mix_E_volume,
    required this.mix_F_volume,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddMixStatus>(
      create: (_) => AddMixStatus(
        context,
        music,
        volume,
        mix_A_volume,
        mix_B_volume,
        mix_C_volume,
        mix_D_volume,
        mix_E_volume,
        mix_F_volume,
      ),
      child: Consumer<AddMixStatus>(
        builder: (_, state, __) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
            color: const Color(0xFF161A26),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.height,
                Text(
                  "Mix name",
                  style: whiteTextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
                ),
                TextField(
                  focusNode: state.mixNameNode,
                  controller: state.mixNameController,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  style: whiteTextStyle(),
                  onChanged: state.changeMixTitle,
                  decoration: normalInputDecoration(hint: "Mix name").copyWith(
                    errorText: state.mixName.error != "" ? state.mixName.error : null,
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
    );
  }
}

class AddMixStatus with ChangeNotifier {
  final BuildContext context;
  final MixHive music;
  final double volume;
  final double mixA;
  final double mixB;
  final double mixC;
  final double mixD;
  final double mixE;
  final double mixF;

  AddMixStatus(
    this.context,
    this.music,
    this.volume,
    this.mixA,
    this.mixB,
    this.mixC,
    this.mixD,
    this.mixE,
    this.mixF,
  );

  ValidateItem _mixName = ValidateItem("", "");

  ValidateItem get mixName => _mixName;

  final FocusNode mixNameNode = FocusNode();
  final mixNameController = TextEditingController();

  void changeMixTitle(String value) {
    if (value.isEmpty) {
      _mixName = ValidateItem("", "Mix name is required!");
    } else {
      _mixName = ValidateItem(value, "");
    }
    notifyListeners();
  }

  save() async {
    if (_mixName.value.isEmpty) {
      _mixName = ValidateItem(mixName.value, "Mix name is required!");
      notifyListeners();
      return;
    }
    _mixName = ValidateItem(mixName.value, "");
    notifyListeners();
    int newID = await HiveHelper.addNewMix(music, mixName.value, volume, mixA, mixB, mixC, mixD, mixE, mixF);
    if (context.mounted) {
      Helper.finish(context, newID);
    }
  }

  @override
  void dispose() {
    mixNameController.dispose();
    mixNameNode.dispose();
    super.dispose();
  }
}
