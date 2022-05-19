import 'package:flutter/cupertino.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/network/requests/checkout_request.dart';
import '../data/vos/card_vo.dart';
import '../general_functions.dart';

class CardsBloc extends ChangeNotifier {
  DataModelsImpl mDataModel = DataModelsImpl();
  CheckoutRequest checkoutRequest = CheckoutRequest();

  List<CardVO>? cardList;
  CardVO? selectedCard;

  CardsBloc() {
    mDataModel.getUserInfoFromDatabase()?.listen((value) {
      cardList = value?.cards;
      selectedCard = cardList?.first;
      notifyListeners();
    });
  }
  void onTapCreateCheckOutVOForApiRequest(
      String? time,
      int? timeSlotsId,
      int? movieDetailsId,
      String? selectedSeatName,
      List<dynamic> finalSelectedSnackListResult) {
    _createCheckOutVOForApiRequest(time, timeSlotsId, movieDetailsId,
        selectedSeatName, finalSelectedSnackListResult);
  }

  void _createCheckOutVOForApiRequest(
      String? time,
      int? timeSlotsId,
      int? movieDetailsId,
      String? selectedSeatName,
      List<dynamic> finalSelectedSnackListResult) {
    checkoutRequest.cardId = selectedCard?.id;
    checkoutRequest.bookingDate = Functions().formatDate(time!);
    checkoutRequest.cinemaDayTimeslotId = timeSlotsId;
    checkoutRequest.movieId = movieDetailsId;
    checkoutRequest.seatNumber = selectedSeatName.toString();
    checkoutRequest.snacks = finalSelectedSnackListResult;
    // This step is to confirm Json object is working or not in Postman
    // encodedJson = jsonEncode(checkoutRequest);
    // print(encodedJson);
    notifyListeners();
  }
}
