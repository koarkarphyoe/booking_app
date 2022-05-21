import 'package:flutter/material.dart';
import '../data/model/data_models.dart';
import '../data/model/data_models_impl.dart';
import '../data/vos/data_vo.dart';
import '../data/vos/user_vo.dart';

class HomeBloc extends ChangeNotifier {
  final GlobalKey<ScaffoldState> drawer = GlobalKey();

  //State
  UserVO? mUser;
  String? token;
  List<DataVO>? currentMovie;
  List<DataVO>? comingSoonMovie;

  //Model
  DataModels userModels = DataModelsImpl();

  void openDrawer() {
    drawer.currentState!.openDrawer();
  }

  HomeBloc() {
    //NowPlayingMovie
    userModels.getNowShowingMovieFromDatabase()?.listen((nowShowingMovie) {
      currentMovie = nowShowingMovie;
      notifyListeners();
    });

    //CommingSoonMovie
    userModels.getComingSoonMovieFromDatabase()?.listen((comingsoonMovie) {
      comingSoonMovie = comingsoonMovie;
      notifyListeners();
    });

    //UserInfo
    userModels.getUserInfoFromDatabase()?.listen((userInfo) {
      mUser = userInfo;
      notifyListeners();
    });

    //Token
    userModels.getTokenFromDatabase()?.listen((databaseToken) {
      token = databaseToken;
      notifyListeners();
    });
  }

  void onTapLogOut() {
    userModels.logOut();
  }
}
