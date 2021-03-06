
import 'package:meta/meta.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/models/actor_model.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/utils/app_database.dart';
import 'package:mymovie/utils/service_locator.dart';
import 'package:sembast/sembast.dart';

class DatabaseAPI {

  Database _db;
  Store _movieStore, _actorStore, _diaryStore;

  Database get db => _db;

  Future<void> initialization() async {
    _db = await AppDatabase.instance.database;
    _movieStore = _db.getStore(storeMovie);
    _actorStore = _db.getStore(storeActor);
    _diaryStore = _db.getStore(sl.get<CurrentUser>().diaryStore);

    assert(_db!=null);
    assert(_movieStore!=null);
    assert(_actorStore!=null);
    assert(_diaryStore!=null);
  }

  /// [영화]
  Future<void> putMovie({@required MovieModel movie}) async {
    await _movieStore.put(movie.toMap(),movie.movieCode);
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
    MovieModel movie =  MovieModel.fromMap(record.value);
    List<dynamic> actorList = await _getActorList(movieCode);
    List<Map<String,dynamic>> realActorList = List<Map<String,dynamic>>();
    for(dynamic actor in actorList) {
      realActorList.add(actor as Map<String,dynamic>);
    }
    movie.addActorList(realActorList);
    return movie;
  }

  /// [배우]
  Future<void> _putActorList(List<Map<String,dynamic>> actorList,String movieCode) async {
    await _actorStore.put(actorList,movieCode);
  }

  Future<dynamic> _getActorList(String movieCode) async {
    Finder finder = Finder(filter: Filter.byKey(movieCode));
    Record record = await _actorStore.findRecord(finder);
    return record.value;
  }

  /// [일기]
  Future<void> addDiary({@required DiaryModel diary}) async {
    await _diaryStore.put(diary.toMap(),diary.movieCode);
  }

  Future<void> addAllDiary({@required List<DiaryModel> diaryList}) async {
    for(DiaryModel diary in diaryList) {
      await addDiary(diary: diary);
    }
  }

  Future<void> deleteDiary({@required DiaryModel diary}) async {
    await _diaryStore.delete(diary.movieCode);
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

  Future<void> updateDiary({@required DiaryModel diary}) async {
    await _diaryStore.update(diary.toMap(), diary.movieCode);
  }

  Future<bool> isDiaryCached() async {
    return !(await _diaryStore.records.isEmpty);
  }
}