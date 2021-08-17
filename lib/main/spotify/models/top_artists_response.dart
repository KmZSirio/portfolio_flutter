class TopArtistsResponse {
    TopArtistsResponse({
        required this.items,
        required this.total,
        required this.limit,
        required this.offset,
        this.previous,
        required this.href,
        this.next,
    });

    List<Artists> items;
    int total;
    int limit;
    int offset;
    String? previous;
    String href;
    String? next;

    factory TopArtistsResponse.fromJson(Map<String, dynamic> json) => TopArtistsResponse(
        items: List<Artists>.from(json["items"].map((x) => Artists.fromJson(x))),
        total: json["total"],
        limit: json["limit"],
        offset: json["offset"],
        previous: (json["previous"] == null) ? "" : json["previous"],
        href: json["href"],
        next: (json["next"] == null) ? "" : json["next"],
    );
}

class Artists {
    Artists({
        required this.externalUrls,
        required this.followers,
        required this.genres,
        required this.href,
        required this.id,
        required this.images,
        required this.name,
        required this.popularity,
        required this.uri,
    });

    ExternalUrls externalUrls;
    Followers followers;
    List<String> genres;
    String href;
    String id;
    List<ImageItem> images;
    String name;
    int popularity;
    String uri;

    factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        followers: Followers.fromJson(json["followers"]),
        genres: List<String>.from(json["genres"].map((x) => x)),
        href: json["href"],
        id: json["id"],
        images: List<ImageItem>.from(json["images"].map((x) => ImageItem.fromJson(x))),
        name: json["name"],
        popularity: json["popularity"],
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

class Followers {
    Followers({
        this.href,
        required this.total,
    });

    String? href;
    int total;

    factory Followers.fromJson(Map<String, dynamic> json) => Followers(
        href: (json["href"] == null) ? "" : json["href"],
        total: json["total"],
    );
}

class ImageItem {
    ImageItem({
        required this.height,
        required this.url,
        required this.width,
    });

    int height;
    String url;
    int width;

    factory ImageItem.fromJson(Map<String, dynamic> json) => ImageItem(
        height: json["height"],
        url: json["url"],
        width: json["width"],
    );
}
