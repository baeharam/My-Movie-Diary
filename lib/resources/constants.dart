// API Management
const String naverMovieHosthUrl = 'openapi.naver.com';
const String naverMovieAPIUrl = '/v1/search/movie.json';
const String naverAPIClientID = 'of6amSIPekcLSUPuzL9x';
const String naverAPIClientSecret = '7aBjhtIGe8';
const String naverAPIIDPart = 'X-Naver-Client-Id';
const String naverAPISecretPart = 'X-Naver-Client-Secret';

// Gnereal HTML tag/attributes
const String aTag = 'a';
const String imgTag = 'img';
const String spanTag = 'span';
const String srcAttributes = 'src';
const String titleAttributes = 'title';
const String hrefAttributes = 'href';

// Naver Movie Crawling
const String movieBasicUrl = 'https://movie.naver.com';
const String movieRealPhotoUrl = 'https://movie.naver.com/movie/bi/mi/photoViewPopup.nhn?movieCode=';
const String movieSubPhotosUrl = 'https://movie.naver.com/movie/bi/mi/photo.nhn?code=';
const String movieActorUrl = 'https://movie.naver.com/movie/bi/mi/detail.nhn?code=';
const String movieLineUrl1 = 'https://movie.naver.com/movie/bi/mi/script.nhn?code=';
const String movieLineUrl2 = '&order=best&nid=';

const String movieDescriptionClass = 'con_tx';
const String movieSubPhotosClass = 'gallery_group';
const String movieTrailerClass = 'video_thumb';
const String movieOneLineClass = 'one_line';

const String movieActorAreaClass = 'lst_people';
const String movieActorThumbnailClass = 'p_thumb';
const String movieActorInfoClass = 'p_info';
const String movieActorPartClass = 'p_part';
const String movieActorRoleClass = 'pe_cmt';
const String movieActorPhilmographyClass = 'mv_product';

// Sembast
const String databaseName = 'movie_db';
const String storeMovie = 'movie_store';
const String storeActor = 'actor_store';
const String storeDiary = 'diary_store';

// Cloud Firestore - diary document
const String fDiaryCol = 'diary';
const String fDiarySubCol = 'diary_sub';
const String fDiaryTitleField = 'diary_title';
const String fDiaryContentsField = 'diary_contents';
const String fDiaryRatingField = 'diary_rating';

const String fDiaryMovieMainPhotoField = 'diary_movie_main_photo';
const String fDiaryMovieCodeField = 'diary_movie_code';
const String fDiaryMoviePubDateField = 'diary_movie_pubdate';
const String fDiaryMovieTitleField = 'diary_movie_title';
const String fDiaryMovieStillcutListField = 'diary_movie_stillcut_list';
const String fDiaryMovieLineList = 'diary_movie_line_list';

// Cloud Firestore - movie document
const String fMovieCol = 'movie';
const String fMovieActorSubCol = 'movie_actor';
const String fMovieLinkField = 'movie_link';
const String fMovieCodeField = 'movie_code';
const String fMovieThumbnailField = 'movie_thumbnail';
const String fMovieTitleField = 'movie_title';
const String fMoviePubdateField = 'movie_pub_date';
const String fMovieMainDirectorField = 'movie_main_director';
const String fMovieMainActorField = 'movie_main_actor';
const String fMovieUserRatingField = 'movie_user_rating';
const String fMovieDescriptionField = 'movie_description';
const String fMovieMainPhotoField = 'movie_main_photo';
const String fMovieStillcutListField = 'movie_stillcut_list';
const String fMovieTrailerListField = 'movie_trailer_list';
const String fMovieLineListField = 'movie_line_list';

// Cloud Firestore - actor subDocument
const String fActorNameField = 'actor_name';
const String fActorLevelField = 'actor_level';
const String fActorThumbnailField = 'actor_thumbnail';
const String fActorRoleField = 'actor_role';

// Intro Screen
const String facebookImage = 'assets/images/facebook.png';
const String googleImage = 'assets/images/google.png';
const String kakaoImage = 'assets/images/kakao.jpg';