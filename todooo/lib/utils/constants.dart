import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todooo/main.dart';
import 'package:todooo/utils/app_string.dart';

/// lottie asset address
String lottieURL = 'assets/lottie/1.json';

// empty title or subtitle textfiled warning
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppString.oopsMsg,
    subMsg: 'You must fill all fields',
    corner: 20,
    duration: 2000,
    padding: EdgeInsets.all(20),
  );
}

// nothing entered when userr try to edit or update the current task
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppString.oopsMsg,
    subMsg: 'You must edit the task then try to update it',
    corner: 20,
    duration: 3000,
    padding: EdgeInsets.all(20),
  );
}

// no task warning dialog for deleting
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: AppString.oopsMsg,
    message:
        'There is no task for delete! \n Try adding some and then try to delete it.',
    buttonText: 'Okay!',
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

// delete all task from db dialog
dynamic deleteAlltask(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
     title: AppString.areYouSure,
    message:
        "Do You really want to delete all tasks? You will no be able to undo this action!",
    confirmButtonText: "Yes",
    cancelButtonText: "No",
    onTapCancel: () {
      Navigator.pop(context);
    },
    onTapConfirm: () {
      // clear all box data using this command later on
      BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}
