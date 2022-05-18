import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:student_app/data/model/data_models_impl.dart';

import '../data/vos/payment_method_vo.dart';
import '../data/vos/snack_vo.dart';

class SnacksBloc extends ChangeNotifier {
  //Model
  DataModelsImpl mDataModel = DataModelsImpl();
  //State
  List<SnackVO>? snackList;
  List<SnackVO>? selectedSnackList = [];
  List<PaymentMethodVO>? paymentMethodList;

  //need to assign default value when migrate to Bloc
  double? subtotal=0;

  //for selectedSnackId and Qty List
  List selectedSnackListToString = [];
  List finalSelectedSnackListResult = [];

  SnacksBloc() {

    mDataModel.getSnackListFromDatabase().listen((value) {
      snackList = value;
      notifyListeners();
    });

    mDataModel.getPaymentListFromDatabase().listen((event) {
      paymentMethodList = event;
      notifyListeners();
    });
  }

  void onTapSelectedSnackAndQty(
      SnackVO e, int? snackId, String? signName) {
    _selectedSnackListAndQty(e, snackId, signName);
  }

  void _selectedSnackListAndQty(
      SnackVO e, int? snackId, String? signName) {
    if (e.id == snackId) {
      if (signName == "+") {
        e.quantity = e.quantity! + 1;
        subtotal =
            (subtotal! + e.price!.toDouble());
        selectedSnackList?.add(e);
        // convert each item to a string by using JSON encoding and remove duplicate objects
        selectedSnackListToString =
            selectedSnackList!.map((e) => jsonEncode(e)).toSet().toList();
        finalSelectedSnackListResult =
            selectedSnackListToString.map((e) => jsonDecode(e)).toList();
        // print(finalSelectedSnackListResult);
        notifyListeners();
      } else if (signName == "-" && e.quantity! > 0) {
        e.quantity = e.quantity! - 1;
        subtotal = (subtotal! - e.price!.toDouble());
        selectedSnackList?.remove(e);
        // convert each item to a string by using JSON encoding and remove duplicate objects
        selectedSnackListToString =
            selectedSnackList!.map((e) => jsonEncode(e)).toSet().toList();
        finalSelectedSnackListResult =
            selectedSnackListToString.map((e) => jsonDecode(e)).toList();
        // print(finalSelectedSnackListResult);
        notifyListeners();
      } else if (e.quantity == 0) {
        e.quantity = 0;
      }
    }
    notifyListeners();
  }
}
