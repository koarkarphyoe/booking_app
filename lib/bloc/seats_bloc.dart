import 'package:flutter/material.dart';

import '../data/model/data_models_impl.dart';
import '../data/vos/movie_seat_list_vo.dart';

class SeatsBloc extends ChangeNotifier {
  //Model
  DataModelsImpl mModel = DataModelsImpl();
  //State
  List<List<MovieSeatListVO>>? allSeatPlanList;
  List<MovieSeatListVO>? seatListForRow;
  int? rowNumbersListForGridView;
  List<String> selectedSeat = [];
  double totalSelectedSeatPrice = 0.0;

  SeatsBloc(int cinemaId, String yMd) {
    mModel.getMovieSeat(cinemaId, yMd).then(
      (value) {
        //Method 2
        allSeatPlanList = value;
        rowNumbersListForGridView = allSeatPlanList?.first.length;
        seatListForRow = allSeatPlanList?.expand((element) => element).toList();
        notifyListeners();
      },
    );
  }

  void onTapSeat(String seatName) {
    _selectedSeat(seatName);
  }

  void _selectedSeat(String? seatName) {
    //Method 1
    seatListForRow?.map((e) {
      if (e.seatName != "" && e.type == "available" && e.seatName == seatName) {
        if (e.isSelected == true) {
          e.isSelected = false;
          selectedSeat.remove(e.seatName);
          totalSelectedSeatPrice -= e.price!.toDouble();
        } else {
          e.isSelected = true;
          selectedSeat.add(e.seatName.toString());
          totalSelectedSeatPrice += e.price!.toDouble();
        }
      }
    }).toList();
    notifyListeners();
  }
}
