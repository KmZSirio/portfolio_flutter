// To parse this JSON data, do
//
//     final playlistResponse = playlistResponseFromMap(jsonString);

import 'dart:convert';

class PlaylistListResponse {
    PlaylistListResponse({
        required this.href,
        required this.items,
        required this.limit,
        this.next,
        required this.offset,
        this.previous,
        required this.total,
    });

    String href;
    List<Playlist> items;
    int limit;
    dynamic next;
    int offset;
    dynamic previous;
    int total;

    // factory PlaylistListResponse.fromJson(String str) => PlaylistListResponse.fromMap(json.decode(str));
    factory PlaylistListResponse.fromJson(Map<String, dynamic> json) => PlaylistListResponse(
        href: json["href"],
        items: List<Playlist>.from(json["items"].map((x) => Playlist.fromMap(x))),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        total: json["total"],
    );

    factory PlaylistListResponse.fromMap(Map<String, dynamic> json) => PlaylistListResponse(
        href: json["href"],
        items: List<Playlist>.from(json["items"].map((x) => Playlist.fromMap(x))),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        total: json["total"],
    );
}

class Playlist {
    Playlist({
        required this.collaborative,
        required this.description,
        required this.externalUrls,
        required this.href,
        required this.id,
        required this.images,
        required this.name,
        required this.owner,
        this.primaryColor,
        required this.public,
        required this.snapshotId,
        required this.tracks,
        required this.type,
        required this.uri,
    });

    bool collaborative;
    String description;
    ExternalUrls externalUrls;
    String href;
    String id;
    List<ImageItem> images;
    String name;
    Owner owner;
    dynamic primaryColor;
    bool public;
    String snapshotId;
    Tracks tracks;
    String type;
    String uri;

    // factory Playlist.fromJson(String str) => Playlist.fromMap(json.decode(str));

    factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
      collaborative: json["collaborative"],
      description: json["description"],
      externalUrls: ExternalUrls.fromJson(json["external_urls"]),
      href: json["href"],
      id: json["id"],
      images: List<ImageItem>.from(json["images"].map((x) => ImageItem.fromJson(x))),
      name: json["name"],
      owner: Owner.fromJson(json["owner"]),
      public: json["public"],
      snapshotId: json["snapshot_id"],
      tracks: Tracks.fromJson(json["tracks"]),
      type: json["type"],
      uri: json["uri"],
    );

    factory Playlist.fromMap(Map<String, dynamic> json) => Playlist(
        collaborative: json["collaborative"],
        description: json["description"],
        externalUrls: ExternalUrls.fromMap(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        images: List<ImageItem>.from(json["images"].map((x) => ImageItem.fromMap(x))),
        name: json["name"],
        owner: Owner.fromMap(json["owner"]),
        primaryColor: json["primary_color"],
        public: json["public"],
        snapshotId: json["snapshot_id"],
        tracks: Tracks.fromMap(json["tracks"]),
        type: json["type"],
        uri: json["uri"],
    );
}

class ExternalUrls {
    ExternalUrls({
        required this.spotify,
    });

    String spotify;

    // factory ExternalUrls.fromJson(String str) => ExternalUrls.fromMap(json.decode(str));

    factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
      spotify: json["spotify"],
    );

    factory ExternalUrls.fromMap(Map<String, dynamic> json) => ExternalUrls(
        spotify: json["spotify"],
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

    // factory ImageItem.fromJson(String str) => ImageItem.fromMap(json.decode(str));

    factory ImageItem.fromJson(Map<String, dynamic> json) => ImageItem(
      height: json["height"],
      url: json["url"],
      width: json["width"],
    );

    factory ImageItem.fromMap(Map<String, dynamic> json) => ImageItem(
        height: json["height"],
        url: json["url"],
        width: json["width"],
    );
}

class Owner {
    Owner({
        required this.displayName,
        required this.externalUrls,
        required this.href,
        required this.id,
        required this.type,
        required this.uri,
    });

    String displayName;
    ExternalUrls externalUrls;
    String href;
    String id;
    String type;
    String uri;

    // factory Owner.fromJson(String str) => Owner.fromMap(json.decode(str));

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
      displayName: json["display_name"],
      externalUrls: ExternalUrls.fromJson(json["external_urls"]),
      href: json["href"],
      id: json["id"],
      type: json["type"],
      uri: json["uri"],
    );

    factory Owner.fromMap(Map<String, dynamic> json) => Owner(
        displayName: json["display_name"],
        externalUrls: ExternalUrls.fromMap(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        type: json["type"],
        uri: json["uri"],
    );
}

class Tracks {
    Tracks({
        required this.href,
        required this.total,
    });

    String href;
    int total;

    // factory Tracks.fromJson(String str) => Tracks.fromMap(json.decode(str));

    factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
      href: json["href"],
      total: json["total"],
    );

    factory Tracks.fromMap(Map<String, dynamic> json) => Tracks(
        href: json["href"],
        total: json["total"],
    );
}
