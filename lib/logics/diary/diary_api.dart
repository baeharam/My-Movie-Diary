
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:mymovie/logics/global/current_user.dart';
import 'package:mymovie/models/diary_model.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/utils/service_locator.dart';

class DiaryAPI {
  final Firestore _firestore = Firestore.instance;

  Future<void> completeDiary({@required DiaryModel diaryModel}) async{
    DocumentReference ref = _firestore
      .collection(fMovieDiaryCol)
      .document(sl.get<CurrentUser>().uid)
      .collection(diaryModel.movie.movieCode+'-'+diaryModel.movie.title)
      .document(diaryModel.movie.movieCode+'-'+diaryModel.movie.title);
    await _firestore.runTransaction((tx) async {
      await tx.set(ref,{
        fDiaryTitleField: diaryModel.title,
        fDiaryContentsField: diaryModel.contents,
        fDiaryRatingField: diaryModel.rating,
        fDiaryImageField: diaryModel.movie.mainPhoto
      });
    });
  }
}