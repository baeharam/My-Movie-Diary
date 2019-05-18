
import 'package:meta/meta.dart';
import 'package:mymovie/models/actor_model.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/utils/app_database.dart';
import 'package:sembast/sembast.dart';

class DatabaseAPI {

  Database _db;
  Store _movieStore, _actorStore, _diaryStore;

  Future<void> initialization() async {
    _db = await AppDatabase.instance.database;
    _movieStore = _db.getStore(storeMovie);
    _actorStore = _db.getStore(storeActor);
    _diaryStore = _db.getStore(storeDiary);
  }

  /// [영화]
  Future<void> putMovie({@required MovieModel movie}) async {
    await _movieStore.put({movie.movieCode,movie.toMap()},movie.movieCode);
    List<Map<String,dynamic>> actorList = List<Map<String,dynamic>>();
    for(ActorModel actor in movie.actorList) {
      actorList.add(actor.toMap());
    }
    await _putActorList(actorList, movie.movieCode);
  }

  Future<bool> isExistingMovie({@required String movieCode}) async {
    Record record = await _movieStore.findRecord(Finder(filter: Filter.byKey(movieCode)));
    return record!=null ? true :false;
  }

  Future<MovieModel> getMovie({@required String movieCode}) async {
    Finder finder = Finder(filter: Filter.byKey(movieCode));
    Record record = await _movieStore.findRecord(finder);
    MovieModel movie =  MovieModel.fromMap(record.value as Map);
    List<Map<String,dynamic>> actorList = await _getActorList(movieCode);
    movie.addActorList(actorList);
    return movie;
  }

  /// [배우]
  Future<void> _putActorList(List<Map<String,dynamic>> actorList,String movieCode) async {
    await _actorStore.put({actorList},movieCode);
  }

  Future<dynamic> _getActorList(String movieCode) async {
    Finder finder = Finder(filter: Filter.byKey(movieCode));
    Record record = await _actorStore.findRecord(finder);
    return record.value;
  }

  /// [일기]
  Future<void> putDiary({@required DiaryModel diary}) async {
    await _diaryStore.put({diary.toMap()},diary.movieCode);
  }

  Future<DiaryModel> getDiary({@required String movieCode}) async {
    Finder finder = Finder(filter: Filter.byKey(movieCode));
    Record record = await _diaryStore.findRecord(finder);
    return DiaryModel.fromMap(record.value as Map);
  }

  Future<List<DiaryModel>> getAllDiary() async {
    return await _diaryStore.records.map((record) 
      => DiaryModel.fromMap(record.value as Map)).toList();
  }
}