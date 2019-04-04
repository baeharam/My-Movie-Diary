import 'package:html/dom.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/resources/strings.dart';

class ActorModel {
  String name;
  String thumbnail;
  ACTOR_LEVEL level;
  String role;
  List<String> philmography;

  ActorModel({
    this.name,
    this.thumbnail,
    this.level,
    this.role,
    this.philmography
  }) : assert(name!=null),
       assert(thumbnail!=null),
       assert(level!=null),
       assert(role!=null),
       assert(philmography!=null);

  factory ActorModel.fromElement(Element element) {
    String thumbnail = element
      .getElementsByClassName(movieActorThumbnailClass)[0]
      .getElementsByTagName(aTag)[0]
      .getElementsByTagName(imgTag)[0].attributes[srcAttributes];
    String name = element
      .getElementsByClassName(movieActorInfoClass)[0]
      .getElementsByTagName(aTag)[0].attributes[titleAttributes];
    ACTOR_LEVEL level = element
      .getElementsByClassName(movieActorInfoClass)[0]
      .getElementsByClassName(movieActorPartClass)[0].text==mainActor ? 
      ACTOR_LEVEL.LEADING : ACTOR_LEVEL.SUPPORTING;

    List<Element> roleElementList = element.getElementsByClassName(movieActorRoleClass);
    String role = roleElementList.isEmpty ? '' : roleElementList[0].getElementsByTagName(spanTag)[0].text;
    List<String> philmography = List<String>();
    for(Element product in element.getElementsByClassName(movieActorPhilmographyClass)[0]
        .getElementsByTagName(aTag)) {
      philmography.add(product.text);
    }

    return ActorModel(
      thumbnail: thumbnail,
      name: name,
      level: level,
      role: role,
      philmography: philmography
    );
  }

  @override
  String toString() {
    return 
      'name: $name\n'
      'thumbnial: $thumbnail\n'
      'level: $level\n'
      'role: $role\n'
      'philmography: ${philmography.toString()}';
    
  }
}

enum ACTOR_LEVEL {
  LEADING,
  SUPPORTING
}