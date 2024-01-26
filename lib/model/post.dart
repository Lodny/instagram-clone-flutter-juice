import 'package:instagram_clone_flutter/model/instagram_user.dart';

class Post {
  final String? id;
  final String? thumbnail;
  final String? description;
  final int? likeCount;
  final String? uid;
  final InstagramUser? userInfo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Post({
    this.id,
    this.thumbnail,
    this.description,
    this.likeCount,
    this.uid,
    this.userInfo,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  // factory Post.fromJson(String id, Map<String, dynamic> json) {
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'] == null ? '' : json['id'] as String,
        // id: json['id'] == null ? '' : json['id'] as String,
        thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
        description: json['description'] == null ? '' : json['description'] as String,
        likeCount: json['likeCount'] == null ? 0 : json['likeCount'] as int,
        uid: json['uid'] == null ? '' : json['uid'] as String,
        userInfo: json['userInfo'] == null ? null : InstagramUser.fromJson(json['userInfo']),
        createdAt: json['createdAt'] == null ? DateTime.now() : json['createdAt'].toDate(),
        updatedAt: json['updatedAt'] == null ? DateTime.now() : json['updatedAt'].toDate(),
        deletedAt: json['deletedA'] == null ? DateTime.now() : json['deletedA'].toDate(),
    );
  }

  factory Post.init(InstagramUser userInfo) {
    var time = DateTime.now();
    return Post(
      thumbnail: '',
      userInfo: userInfo,
      uid: userInfo.uid,
      description: '',
      createdAt: time,
      updatedAt: time,
    );
  }

  Post copyWith({
    String? id,
    String? thumbnail,
    String? description,
    int? likeCount,
    String? uid,
    InstagramUser? userInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Post(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      likeCount: likeCount ?? this.likeCount,
      uid: uid ?? this.uid,
      userInfo: userInfo ?? this.userInfo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'thumbnail': this.thumbnail,
      'description': this.description,
      'likeCount': this.likeCount,
      'uid': this.uid,
      'userInfo': this.userInfo?.toMap(),
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'deletedAt': this.deletedAt,
    };
  }
}
