import 'package:flutter/cupertino.dart';

import '../data/model/data_models_impl.dart';

class NewCardsBloc extends ChangeNotifier {
  DataModelsImpl mModel = DataModelsImpl();
  NewCardsBloc();
  void onTapCreateNewCard(
      String text, String text2, String text3, String text4) {
    _createNewCard(text, text2, text3, text4);
  }

  void _createNewCard(String text, String text2, String text3, String text4) {
    mModel.registerCardList(text, text2, text3, text4);
    notifyListeners();
  }
}
