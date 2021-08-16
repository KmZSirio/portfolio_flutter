class PlaylistItemsResponse {
    PlaylistItemsResponse({
        required this.href,
        required this.items,
        required this.limit,
        required this.offset,
        required this.total,
    });

    String href;
    List<Item> items;
    int limit;
    int offset;
    int total;

    factory PlaylistItemsResponse.fromJson(Map<String, dynamic> json) => PlaylistItemsResponse(
        href: json["href"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        limit: json["limit"],
        offset: json["offset"],
        total: json["total"],
    );
}

class Item {
    Item({
        required this.addedAt,
        required this.addedBy,
        required this.isLocal,
        required this.track,
    });

    DateTime addedAt;
    AddedBy addedBy;
    bool isLocal;
    Track track;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        addedAt: DateTime.parse(json["added_at"]),
        addedBy: AddedBy.fromJson(json["added_by"]),
        isLocal: json["is_local"],
        track: Track.fromJson(json["track"]),
    );
}

class AddedBy {
    AddedBy({
        required this.externalUrls,
        required this.href,
        required this.id,
        required this.type,
        required this.uri,
    });

    ExternalUrls externalUrls;
    String href;
    String id;
    String type;
    String uri;

    factory AddedBy.fromJson(Map<String, dynamic> json) => AddedBy(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        type: json["type"],
        uri: json["uri"],
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

class Artist {
    Artist({
        required this.externalUrls,
        required this.href,
        required this.id,
        required this.name,
        required this.type,
        required this.uri,
    });

    ExternalUrls externalUrls;
    String href;
    String id;
    String name;
    String type;
    String uri;

    factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        name: json["name"],
        type: json["type"],
        uri: json["uri"],
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
        required this.name,
        required this.popularity,
        this.previewUrl,
        required this.track,
        required this.trackNumber,
        required this.type,
        required this.uri,
    });

    Album album;
    List<Artist> artists;
    int discNumber;
    int durationMs;
    bool episode;
    bool explicit;
    ExternalIds externalIds;
    ExternalUrls externalUrls;
    String href;
    String id;
    bool isLocal;
    String name;
    int popularity;
    dynamic previewUrl;
    bool track;
    int trackNumber;
    String type;
    String uri;

    factory Track.fromJson(Map<String, dynamic> json) => Track(
        album: Album.fromJson(json["album"]),
        artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        discNumber: json["disc_number"],
        durationMs: json["duration_ms"],
        episode: json["episode"],
        explicit: json["explicit"],
        externalIds: ExternalIds.fromJson(json["external_ids"]),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        isLocal: json["is_local"],
        name: json["name"],
        popularity: json["popularity"],
        previewUrl: (json["preview_url"] == null) ? "" : json["preview_url"],
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
    List<Artist> artists;
    ExternalUrls externalUrls;
    String href;
    String id;
    List<ImageItem> images;
    String name;
    String? releaseDate;
    String? releaseDatePrecision;
    int totalTracks;
    String type;
    String uri;

    factory Album.fromJson(Map<String, dynamic> json) => Album(
        albumType: json["album_type"],
        artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        images: List<ImageItem>.from(json["images"].map((x) => ImageItem.fromJson(x))),
        name: json["name"],
        releaseDate: (json["release_date"] == null) ? "" : json["release_date"],
        releaseDatePrecision: (json["release_date_precision"] == null) ? "" : json["release_date_precision"],
        totalTracks: json["total_tracks"],
        type: json["type"],
        uri: json["uri"],
    );
}

class ImageItem {
    ImageItem({
        required this.height,
        required this.url,
        required this.width,
    });

    dynamic height;
    String url;
    dynamic width;

    factory ImageItem.fromJson(Map<String, dynamic> json) => ImageItem(
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
