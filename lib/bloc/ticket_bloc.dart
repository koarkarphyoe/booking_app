import 'package:flutter/material.dart';
import 'package:student_app/data/model/data_models_impl.dart';
import 'package:student_app/network/requests/checkout_request.dart';

import '../data/model/data_models.dart';
import '../data/vos/data_vo.dart';
import '../data/vos/voucher_vo.dart';

class TicketBloc extends ChangeNotifier {
  //Model
  DataModels mDataModel = DataModelsImpl();
  //State
  VoucherVO? voucher;
  DataVO? mMovie;

  TicketBloc(CheckoutRequest checkoutRequest) {
    mDataModel.checkOut(checkoutRequest)?.then((value) {
      voucher = value.data;
      mDataModel
          .getMovieDetailsFromDatabase(voucher!.movieId!.toInt())
          .listen((value) {
        mMovie = value;
        notifyListeners();
      });
      notifyListeners();
    });
  }
}
