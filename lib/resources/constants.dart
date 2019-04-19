// API Management
const String kakaoAppKey = '0e7261bd0a60680fc4e711a7b3e230a4';
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

const String movieDescriptionClass = 'con_tx';
const String movieSubPhotosClass = 'gallery_group';
const String movieTrailerClass = 'video_thumb';

const String movieActorAreaClass = 'lst_people';
const String movieActorThumbnailClass = 'p_thumb';
const String movieActorInfoClass = 'p_info';
const String movieActorPartClass = 'p_part';
const String movieActorRoleClass = 'pe_cmt';
const String movieActorPhilmographyClass = 'mv_product';

// Database Overview
const String databaseName = 'movie_db';
const String tableMovie = 'movie_table';
const String tableStillcut = 'stillcut_table';
const String tableActor = 'actor_table';
const String tableTrailer = 'trailer_table';

// Table - movie_table
const String movieColID = 'movie_id';
const String movieColLink = 'movie_link';
const String movieColCode = 'movie_code';
const String movieColThumnail = 'movie_thumbnail';
const String movieColTitle = 'movie_title';
const String movieColPubdate = 'movie_pubdate';
const String movieColMainDirector = 'movie_main_director';
const String movieColMainActor = 'movie_main_actor';
const String movieColUserRating = 'movie_user_rating';
const String movieDescription = 'movie_description';
const String movieMainPhoto = 'movie_main_photo';

// Table - stillcut_table
const String stillcutColID = 'stillcut_id';
const String stillcutColCode = 'stillcut_code';
const String stillcutColPhoto = 'stillcut_photo';

// Table - actor_table
const String actorColID = 'actor_id';
const String actorColCode = 'actor_code';
const String actorColThumbnail = 'actor_thumbnail';
const String actorColLevel = 'actor_level';
const String actorColRole = 'actor_role';

// Table - trailer_table
const String trailerColID = 'trailer_id';
const String trailerColCode = 'trailer_code';
const String trailerColVideo = 'trailer_video';

// SQL
const String sqlCreateMovieTable = 
  'CREATE TABLE $tableMovie ('
  '$movieColID INTEGER PRIMARY KEY,'
  '$movieColLink TEXT, $movieColCode TEXT,'
  '$movieColTitle TEXT, $movieColThumnail TEXT,'
  '$movieColMainActor TEXT, $movieColMainDirector TEXT,'
  '$movieColPubdate TEXT, $movieColUserRating TEXT)';

const String sqlCreateStillcutTable = 
  'CREATE TABLE $tableStillcut ('
  '$stillcutColID INTEGER PRIMARY KEY, '
  '$stillcutColCode TEXT, $stillcutColPhoto TEXT)';

const String sqlCreateActorTable =
  'CREATE TABLE $tableActor ('
  '$actorColID INTEGER PRIMARY KEY, '
  '$actorColCode TEXT, $actorColLevel TEXT,'
  '$actorColRole TEXT, $actorColThumbnail TEXT)';

const String sqlCreateTrailerTable =
  'CREATE TABLE $tableTrailer ('
  '$trailerColID INTEGER PRIMARY KEY,'
  '$trailerColCode TEXT, $trailerColVideo TEXT)';

// Intro Screen
const String kakaoImage = 'assets/images/kakao.png';
const String googleImage = 'assets/images/google.png';

const List introBackgroundImageList = [
  'assets/images/ironman.jpg',
  'assets/images/spiderman.jpg',
  'assets/images/abouttime.jpg'
];

