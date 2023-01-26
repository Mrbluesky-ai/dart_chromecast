class CastMedia {
  final String? contentId;
  String? title;
  String? subtitle;
  bool autoPlay = true;
  double position;
  double playbackRate;
  String contentType;
  List<String>? images;
  String subtitlesUrl;

  CastMedia({
    this.contentId,
    this.title,
    this.subtitle,
    this.autoPlay = true,
    this.position = 0.0,
    this.playbackRate = 1.0,
    this.contentType = 'video/mp4',
    this.images,
    this.subtitlesUrl = "",
  }) {
    if (null == images) {
      images = [];
    }
  }

  Map toChromeCastMap() {
    if (subtitlesUrl == ""){
      return {
        'type': 'LOAD',
        'autoPlay': autoPlay,
        'currentTime': position,
        'playbackRate': playbackRate,
        'activeTracks': [],
        'media': {
          'contentId': contentId,
          'contentType': contentType,
          'streamType': 'BUFFERED',
          'textTrackStyle': {
            'edgeType': 'NONE',
            'fontScale': 1.0,
            'fontStyle': 'NORMAL',
            'fontFamily': 'Droid Sans',
            'fontGenericFamily': 'SANS_SERIF',
            'windowColor': '#00000',
            'windowRoundedCornerRadius': 10,
            'windowType': 'NONE',
          },
          'metadata': {
            'metadataType': 0,
            'images': images?.map((image) => {'url': image}).toList(),
            'title': title,
            'subtitle': subtitle,
          },
        }
      };
    } else {
      return {
        'type': 'LOAD',
        'autoPlay': autoPlay,
        'currentTime': position,
        'playbackRate': playbackRate,
        'activeTracks': [],
        'media': {
          'contentId': contentId,
          'contentType': contentType,
          'streamType': 'BUFFERED',
          'textTrackStyle': {
            'edgeType': 'NONE',
            'fontScale': 1.0,
            'fontStyle': 'NORMAL',
            'fontFamily': 'Droid Sans',
            'fontGenericFamily': 'SANS_SERIF',
            'windowColor': '#00000',
            'windowRoundedCornerRadius': 10,
            'windowType': 'NONE',
          },
          'metadata': {
            'metadataType': 0,
            'images': images?.map((image) => {'url': image}).toList(),
            'title': title,
            'subtitle': subtitle,
          },
          'tracks': {
            'trackId': 10,
            'type': 'TEXT',
            'trackContentId': subtitlesUrl,
            'trackContentType': 'text/vtt',
            'name': 'Dutch',
            'language': 'nl-NL',
            'subtype': 'SUBTITLES',
          }
        }
      };
    }
  }
}
