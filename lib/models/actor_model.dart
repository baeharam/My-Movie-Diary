import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:html/dom.dart';
import 'package:mymovie/resources/constants.dart';
import 'package:mymovie/resources/strings.dart';
import 'package:uuid/uuid.dart';

class ActorModel {

  static const String actorLevelLeading = 'leading';
  static const String actorLevelSupporting = 'supporting';
  final Uuid uuid = Uuid();

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

  String get docName => this.name+"-"+uuid.v1();

  factory ActorModel.fromSnapshot(DocumentSnapshot snapshot) {
    return ActorModel(
      name: snapshot.data[fActorNameField],
      thumbnail: snapshot.data[fActorThumbnailField],
      level: snapshot.data[fActorLevelField],
      role: snapshot.data[fActorRoleField]
    );
  }

  Map<String,dynamic> toMap() {
    return {
      fActorNameField: this.name,
      fActorThumbnailField: this.thumbnail,
      fActorLevelField: this.level,
      fActorRoleField: this.role
    };
  }

  factory ActorModel.fromMap(Map<String,dynamic> map) {
    return ActorModel(
      name: map[fActorNameField],
      thumbnail: map[fActorThumbnailField],
      level: map[fActorLevelField],
      role: map[fActorRoleField]
    );
  }

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