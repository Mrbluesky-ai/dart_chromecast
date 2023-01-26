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
          'edgeType': 'NONE', // can be: "NONE", "OUTLINE", "DROP_SHADOW", "RAISED", "DEPRESSED"
          'fontScale': 1.0, // transforms into "font-size: " + (fontScale*100) +"%"
          'fontStyle': 'NORMAL', // can be: "NORMAL", "BOLD", "BOLD_ITALIC", "ITALIC",
          'fontFamily': 'Droid Sans',
          'fontGenericFamily': 'SANS_SERIF', // can be: "SANS_SERIF", "MONOSPACED_SANS_SERIF", "SERIF", "MONOSPACED_SERIF", "CASUAL", "CURSIVE", "SMALL_CAPITALS",
          'windowColor': '#00000', // see http://dev.w3.org/csswg/css-color/#hex-notation
          'windowRoundedCornerRadius': 10, // radius in px
          'windowType': 'NONE' // can be: "NONE", "NORMAL", "ROUNDED_CORNERS"
        },
        'metadata': {
          'metadataType': 0,
          'images': images?.map((image) => {'url': image}).toList(),
          'title': title,
          'subtitle': subtitle,
        },
        subtitlesUrl == ""? 'tracks': {
          'trackId': 10, // This is an unique ID, used to reference the track
          'type': 'TEXT', // Default Media Receiver currently only supports TEXT
          'trackContentId': subtitlesUrl, // the URL of the VTT (enabled CORS and the correct ContentType are required)
          'trackContentType': 'text/vtt', // Currently only VTT is supported
          'name': 'Dutch', // a Name for humans
          'language': 'nl-NL', // the language
          'subtype': 'SUBTITLES' // should be SUBTITLES
        } : null,
      }
    };
  }
}
