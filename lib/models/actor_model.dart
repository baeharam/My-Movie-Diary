import 'package:html/dom.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/resources/strings.dart';

class ActorModel {

  static const String actorLevelLeading = 'leading';
  static const String actorLevelSupporting = 'supporting';

  String name;
  String thumbnail;
  String level;
  String role;

  ActorModel({
    this.name,
    this.thumbnail,
    this.level,
    this.role,
  }) : assert(name!=null),
       assert(thumbnail!=null),
       assert(level!=null),
       assert(role!=null);

  factory ActorModel.fromElement(Element element) {
    String thumbnail = element
      .getElementsByClassName(movieActorThumbnailClass)[0]
      .getElementsByTagName(aTag)[0]
      .getElementsByTagName(imgTag)[0].attributes[srcAttributes];
    String name = element
      .getElementsByClassName(movieActorInfoClass)[0]
      .getElementsByTagName(aTag)[0].attributes[titleAttributes];
    String level = element
      .getElementsByClassName(movieActorInfoClass)[0]
      .getElementsByClassName(movieActorPartClass)[0].text==mainActor ? 
      actorLevelLeading : actorLevelSupporting;

    List<Element> roleElementList = element.getElementsByClassName(movieActorRoleClass);
    String role = roleElementList.isEmpty ? '' : roleElementList[0].getElementsByTagName(spanTag)[0].text;

    return ActorModel(
      thumbnail: thumbnail,
      name: name,
      level: level,
      role: role,
    );
  }

  @override
  String toString() {
    return 
      'name: $name\n'
      'thumbnial: $thumbnail\n'
      'level: $level\n'
      'role: $role\n';
    
  }
}