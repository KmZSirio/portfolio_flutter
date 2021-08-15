class PlaylistItemsResponse {
    PlaylistItemsResponse({
        required this.href,
        required this.items,
        required this.limit,
        this.next,
        required this.offset,
        this.previous,
        required this.total,
    });

    String href;
    List<Item> items;
    int limit;
    dynamic next;
    int offset;
    dynamic previous;
    int total;

    factory PlaylistItemsResponse.fromJson(Map<String, dynamic> json) => PlaylistItemsResponse(
        href: json["href"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        total: json["total"],
    );
}

class Item {
    Item({
        required this.addedAt,
        required this.addedBy,
        required this.isLocal,
        this.primaryColor,
        required this.track,
        required this.videoThumbnail,
    });

    DateTime addedAt;
    AddedBy addedBy;
    bool isLocal;
    dynamic primaryColor;
    Track track;
    VideoThumbnail videoThumbnail;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        addedAt: DateTime.parse(json["added_at"]),
        addedBy: AddedBy.fromJson(json["added_by"]),
        isLocal: json["is_local"],
        primaryColor: json["primary_color"],
        track: Track.fromJson(json["track"]),
        videoThumbnail: VideoThumbnail.fromJson(json["video_thumbnail"]),
    );
}

class AddedBy {
    AddedBy({
        required this.externalUrls,
        required this.href,
        required this.id,
        required this.type,
        required this.uri,
        required this.name,
    });

    ExternalUrls externalUrls;
    String href;
    String id;
    String type;
    String uri;
    String name;

    factory AddedBy.fromJson(Map<String, dynamic> json) => AddedBy(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        type: json["type"],
        uri: json["uri"],
        name: json["name"] == null ? null : json["name"],
    );
}

class ExternalUrls {
    ExternalUrls({
        required this.spotify,
    });

    String spotify;

    factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
        spotify: json["spotify"],
    );
}

class Track {
    Track({
        required this.album,
        required this.artists,
        required this.discNumber,
        required this.durationMs,
        required this.episode,
        required this.explicit,
        required this.externalIds,
        required this.externalUrls,
        required this.href,
        required this.id,
        required this.isLocal,
        required this.isPlayable,
        required this.name,
        required this.popularity,
        required this.previewUrl,
        required this.track,
        required this.trackNumber,
        required this.type,
        required this.uri,
    });

    Album album;
    List<AddedBy> artists;
    int discNumber;
    int durationMs;
    bool episode;
    bool explicit;
    ExternalIds externalIds;
    ExternalUrls externalUrls;
    String href;
    String id;
    bool isLocal;
    bool isPlayable;
    String name;
    int popularity;
    String previewUrl;
    bool track;
    int trackNumber;
    String type;
    String uri;

    factory Track.fromJson(Map<String, dynamic> json) => Track(
        album: Album.fromJson(json["album"]),
        artists: List<AddedBy>.from(json["artists"].map((x) => AddedBy.fromJson(x))),
        discNumber: json["disc_number"],
        durationMs: json["duration_ms"],
        episode: json["episode"],
        explicit: json["explicit"],
        externalIds: ExternalIds.fromJson(json["external_ids"]),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        isLocal: json["is_local"],
        isPlayable: json["is_playable"],
        name: json["name"],
        popularity: json["popularity"],
        previewUrl: json["preview_url"],
        track: json["track"],
        trackNumber: json["track_number"],
        type: json["type"],
        uri: json["uri"],
    );
}

class Album {
    Album({
        required this.albumType,
        required this.artists,
        required this.externalUrls,
        required this.href,
        required this.id,
        required this.images,
        required this.name,
        this.releaseDate,
        this.releaseDatePrecision,
        required this.totalTracks,
        required this.type,
        required this.uri,
    });

    String albumType;
    List<AddedBy> artists;
    ExternalUrls externalUrls;
    String href;
    String id;
    List<Image> images;
    String name;
    dynamic releaseDate;
    dynamic releaseDatePrecision;
    int totalTracks;
    String type;
    String uri;

    factory Album.fromJson(Map<String, dynamic> json) => Album(
        albumType: json["album_type"],
        artists: List<AddedBy>.from(json["artists"].map((x) => AddedBy.fromJson(x))),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        name: json["name"],
        releaseDate: json["release_date"],
        releaseDatePrecision: json["release_date_precision"],
        totalTracks: json["total_tracks"],
        type: json["type"],
        uri: json["uri"],
    );
}

class Image {
    Image({
        required this.height,
        required this.url,
        required this.width,
    });

    dynamic height;
    String url;
    dynamic width;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        height: json["height"],
        url: json["url"],
        width: json["width"],
    );
}

class ExternalIds {
    ExternalIds({
        required this.isrc,
    });

    String isrc;

    factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
        isrc: json["isrc"],
    );
}

class VideoThumbnail {
    VideoThumbnail({
        this.url,
    });

    dynamic url;

    factory VideoThumbnail.fromJson(Map<String, dynamic> json) => VideoThumbnail(
        url: json["url"],
    );
}
