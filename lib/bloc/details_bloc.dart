import 'package:flutter/cupertino.dart';

import '../data/model/data_models.dart';
import '../data/model/data_models_impl.dart';
import '../data/vos/casts_vo.dart';
import '../data/vos/data_vo.dart';

class DetailsBloc extends ChangeNotifier {
  DataModels movieModels = DataModelsImpl();
  DataVO? movieDetails;
  List<CastsVO>? castImage;

  DetailsBloc(int movieId) {
    movieModels.getMovieDetailsFromDatabase(movieId).listen((value) {
      movieDetails = value;
      castImage = value?.casts;
      notifyListeners();
    });
  }
}
