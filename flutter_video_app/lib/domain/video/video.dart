import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  factory Video({
    required String id,
    required String description,
    required List<String> sources,
    required String subtitle,
    required String thumb,
    required String title,
  }) = _Video;

  const Video._();

  factory Video.fromJson(Map<String, Object?> json)
  => _$VideoFromJson(json);

  factory Video.unknown() {
    return Video(
      id: '00000000-0000-0000-0000-000000000000',
      description: '-unknown-',
      sources: [
        'https://placehold.co/1920x1080.mp4?text=Unknown+video',
      ],
      title: 'Неизвестное видео',
      subtitle: 'Попробуйте выбрать другое',
      thumb: 'https://placehold.co/600x400?text=Hello+World',
    );
  }
}
