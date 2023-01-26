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
            // This is an unique ID, used to reference the track
            'type': 'TEXT',
            // Default Media Receiver currently only supports TEXT
            'trackContentId': subtitlesUrl,
            // the URL of the VTT (enabled CORS and the correct ContentType are required)
            'trackContentType': 'text/vtt',
            // Currently only VTT is supported
            'name': 'Dutch',
            // a Name for humans
            'language': 'nl-NL',
            // the language
            'subtype': 'SUBTITLES',
            // should be SUBTITLES
          }
        }
      };
    }
  }
}
