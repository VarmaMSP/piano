import 'package:super_enum/super_enum.dart';

part 'task.g.dart';

///! DO NOT CHANGE THE ORDER
/// Every task should be idempotent
@superEnum
enum _Task {
  @Data(fields: [
    DataField<String>('urlParam'),
  ])
  CachePodcast,
  @Data(fields: [
    DataField<String>('episodeId'),
    DataField<String>('url'),
    DataField<String>('directory'),
    DataField<String>('filename'),
  ])
  DownloadEpisode,
}

extension TaskExtension on Task {
  Map<String, dynamic> toJson() {
    return when(
      cachePodcast: (data) {
        return {
          'key': _Task.CachePodcast.index,
          'url_param': data.urlParam,
        };
      },
      downloadEpisode: (data) {
        return {
          'key': _Task.DownloadEpisode.index,
          'episode_id': data.episodeId,
          'url': data.url,
          'directory': data.directory,
          'filename': data.filename,
        };
      },
    );
  }
}

//ignore: missing_return
Task taskFromJson(Map<String, dynamic> json) {
  switch (_Task.values[json['key']]) {
    case _Task.CachePodcast:
      return Task.cachePodcast(
        urlParam: json['url_param'],
      );

    case _Task.DownloadEpisode:
      return Task.downloadEpisode(
        episodeId: json['episode_id'],
        url: json['url'],
        directory: json['directory'],
        filename: json['filename'],
      );
  }
}
