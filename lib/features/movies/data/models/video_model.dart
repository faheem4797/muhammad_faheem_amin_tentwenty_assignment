import 'package:equatable/equatable.dart';

class VideoModel extends Equatable {
  final String key;
  final String site;
  final String type;
  final String id;
  // final String? name;
  // final int? size;
  // final bool? official;

  const VideoModel({
    required this.key,
    required this.site,
    required this.type,
    required this.id,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      key: map['key'] ?? '',
      site: map['site'] ?? '',
      type: map['type'] ?? '',
      id: map['id'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, key, site, type];
}
