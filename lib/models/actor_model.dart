import 'package:html/dom.dart';

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
  }) : assert(name!=null && name.isNotEmpty),
       assert(thumbnail!=null && thumbnail.isNotEmpty),
       assert(level!=null),
       assert(role!=null && role.isNotEmpty),
       assert(philmography!=null && philmography.isNotEmpty);

  factory ActorModel.fromElement(Element element) {
    String thumbnail = element
      .getElementsByClassName('p_thumb')[0]
      .getElementsByTagName('a')[0]
      .getElementsByTagName('img')[0].attributes['src'];
    String name = element
      .getElementsByClassName('p_info')[0]
      .getElementsByTagName('a')[0].attributes['title'];
    ACTOR_LEVEL level = element
      .getElementsByClassName('p_info')[0]
      .getElementsByClassName('p_part')[0].text=='주연' ? 
      ACTOR_LEVEL.LEADING : ACTOR_LEVEL.SUPPORTING;
    String role = element
      .getElementsByClassName('pe_cmt')[0]
      .getElementsByTagName('span')[0].text;
    List<String> philmography = List<String>();
    for(Element product in element.getElementsByClassName('mv_product')[0].getElementsByTagName('a')) {
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