
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/models/actor_model.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/models/movie_model.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/utils/service_locator.dart';

class FirebaseAPI {
  final Firestore firestore = Firestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> setUID() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    sl.get<CurrentUser>().uid = user.uid;
  }

  /// [API 호출 + 크롤링한 영화 데이터 저장]]
  Future<void> storeMovie({@required MovieModel movie}) async{
    debugPrint('서버에 영화 저장 중...');

    DocumentReference movieDocRef = firestore.collection(fMovieCol)
      .document(movie.docName);
    CollectionReference actorColRef = firestore.collection(fMovieCol)
      .document(movie.docName)
      .collection(fMovieActorSubCol);

    WriteBatch writeBatch = firestore.batch();

    writeBatch.setData(movieDocRef, {
      fMovieLinkField: movie.link,
      fMovieCodeField: movie.movieCode,
      fMovieThumbnailField: movie.thumbnail,
      fMovieTitleField: movie.title,
      fMoviePubdateField: movie.pubDate,
      fMovieMainDirectorField: movie.mainDirector,
      fMovieMainActorField: movie.mainActor,
      fMovieUserRatingField: movie.userRating,
      fMovieDescriptionField: movie.description,
      fMovieMainPhotoField: movie.mainPhoto,
      fMovieStillcutListField: movie.stillcutList,
      fMovieTrailerListField: movie.trailerList
    });

    for(ActorModel actor in movie.actorList) {
      DocumentReference actorDocRef = actorColRef.document(actor.docName);
      writeBatch.setData(actorDocRef, {
        fActorNameField: actor.name,
        fActorLevelField: actor.level,
        fActorThumbnailField: actor.thumbnail,
        fActorRoleField: actor.role
      });
    }

    await writeBatch.commit();
  }

  Future<void> updateDiary({@required DiaryModel diaryModel}) async {
    debugPrint('서버에 일기 업데이트 중...');

    DocumentReference userRef = firestore
      .collection(fDiaryCol)
      .document(sl.get<CurrentUser>().uid);

    DocumentReference diaryRef = firestore
      .collection(fDiaryCol)
      .document(sl.get<CurrentUser>().uid)
      .collection(fDiarySubCol)
      .document(diaryModel.docName);

    WriteBatch batch = firestore.batch();

    batch.updateData(diaryRef, {
      fDiaryTitleField: diaryModel.diaryTitle,
      fDiaryContentsField: diaryModel.diaryContents,
      fDiaryRatingField: diaryModel.diaryRating
    });
    batch.updateData(userRef, {fRecentUpdatedTimeField: diaryModel.diaryUpdatedTime});

    await batch.commit();
  }

  Future<void> addDiary({@required DiaryModel diaryModel}) async{
    debugPrint('서버에 일기 저장 중...');

    DocumentReference userRef = firestore
      .collection(fDiaryCol)
      .document(sl.get<CurrentUser>().uid);

    DocumentReference diaryRef = firestore
      .collection(fDiaryCol)
      .document(sl.get<CurrentUser>().uid)
      .collection(fDiarySubCol)
      .document(diaryModel.docName);

    WriteBatch batch = firestore.batch();

    batch.setData(diaryRef, {
      fDiaryTitleField: diaryModel.diaryTitle,
      fDiaryContentsField: diaryModel.diaryContents,
      fDiaryRatingField: diaryModel.diaryRating,
      fDiaryMovieMainPhotoField: diaryModel.movieMainPhoto,
      fDiaryMovieCodeField: diaryModel.movieCode,
      fDiaryMoviePubDateField: diaryModel.moviePubDate,
      fDiaryMovieStillcutListField: diaryModel.movieStillCutList,
      fDiaryMovieTitleField: diaryModel.movieTitle
    });

    batch.setData(userRef, {
      fRecentUpdatedTimeField: diaryModel.diaryUpdatedTime
    });

    await batch.commit();
  }

  Future<void> deleteDiary({@required DiaryModel diary}) async {
    debugPrint('서버에서 일기 제거 중');

    DocumentReference userRef = firestore
      .collection(fDiaryCol)
      .document(sl.get<CurrentUser>().uid);

    DocumentReference diaryRef = firestore
      .collection(fDiaryCol)
      .document(sl.get<CurrentUser>().uid)
      .collection(fDiarySubCol)
      .document(diary.docName);

    WriteBatch batch = firestore.batch();

    batch.delete(diaryRef);
    batch.setData(userRef, {fRecentUpdatedTimeField: diary.diaryUpdatedTime});

    await batch.commit();
  }

  Future<QuerySnapshot> fetchDiarySnapshot() async {
    QuerySnapshot diarySnapshot = await sl.get<FirebaseAPI>().firestore
      .collection(fDiaryCol)
      .document(sl.get<CurrentUser>().uid)
      .collection(fDiarySubCol)
      .getDocuments();
    
    return diarySnapshot;
  }

}