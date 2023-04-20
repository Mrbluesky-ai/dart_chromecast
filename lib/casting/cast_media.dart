import 'cast_media_text_track_style.dart';
import 'cast_media_track.dart';

class CastMedia {
  final String? contentId;
  String? title;
  String? subtitle;
  bool autoPlay = true;
  double position;
  double playbackRate;
  String contentType;
  List<String>? images;
  List<int>? activeTrackIds;
  List<CastMediaTrack>? tracks;
  CastMediaTextTrackStyle? textTrackStyle;

  CastMedia({
    this.contentId,
    this.title,
    this.subtitle,
    this.autoPlay = true,
    this.position = 0.0,
    this.playbackRate = 1.0,
    this.contentType = 'video/mp4',
    this.images,
    this.activeTrackIds,
    this.tracks,
    this.textTrackStyle,
  }) {
    if (null == images) {
      images = [];
    }
    if (null == activeTrackIds) {
      activeTrackIds = [];
    }

    if (null == tracks) {
      tracks = [];
    }

  }

  Map toChromeCastMap() {
      return {
        'type': 'LOAD',
        'autoPlay': autoPlay,
        'currentTime': position,
        'playbackRate': playbackRate,
        'activeTracks': activeTrackIds,
        'media': {
          'contentId': contentId,
          'contentType': contentType,
          'streamType': 'BUFFERED',
          'tracks': CastMediaTrack.listToChromeCastMap(tracks!),
          "textTrackStyle": textTrackStyle?.toChromeCastMap()?? CastMediaTextTrackStyle(),
          'metadata': {
            'metadataType': 1,
            'images': images?.map((image) => {'url': image}).toList(),
            'title': title,
            'subtitle': subtitle,
          },
        }
      };
  }
}
