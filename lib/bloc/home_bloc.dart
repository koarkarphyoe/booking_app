import 'package:flutter/cupertino.dart';

import '../data/model/data_models.dart';
import '../data/model/data_models_impl.dart';
import '../data/vos/data_vo.dart';
import '../data/vos/user_vo.dart';

class HomeBloc extends ChangeNotifier {
  //State
  UserVO? mUser;
  String? token;
  List<DataVO>? currentMovie;
  List<DataVO>? comingSoonMovie;

  //Model
  DataModels userModels = DataModelsImpl();

  HomeBloc() {
    //NowPlayingMovie
    userModels.getNowShowingMovieFromDatabase()?.listen((nowShowingMovie) {
      currentMovie = nowShowingMovie;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    //CommingSoonMovie
    userModels.getComingSoonMovieFromDatabase()?.listen((comingsoonMovie) {
      comingSoonMovie = comingsoonMovie;
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));

    //UserInfo
    userModels.getUserInfoFromDatabase()?.listen((userInfo) {
      mUser = userInfo;
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));

    //Token
    userModels.getTokenFromDatabase()?.listen((databaseToken) {
      token = databaseToken;
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));
  }
}
