// To parse this JSON data, do
//
//     final youTubeVideosResponse = youTubeVideosResponseFromJson(jsonString);

import 'dart:convert';

YouTubeVideosResponse youTubeVideosResponseFromJson(String str) => YouTubeVideosResponse.fromJson(json.decode(str));

String youTubeVideosResponseToJson(YouTubeVideosResponse data) => json.encode(data.toJson());

class YouTubeVideosResponse {
    YouTubeVideosResponse({
        this.kind,
        this.etag,
        this.nextPageToken,
        this.regionCode,
        this.pageInfo,
        this.items,
    });

    String kind;
    String etag;
    String nextPageToken;
    String regionCode;
    PageInfo pageInfo;
    List<Item> items;

    factory YouTubeVideosResponse.fromJson(Map<String, dynamic> json) => YouTubeVideosResponse(
        kind: json["kind"],
        etag: json["etag"],
        nextPageToken: json["nextPageToken"],
        regionCode: json["regionCode"],
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "nextPageToken": nextPageToken,
        "regionCode": regionCode,
        "pageInfo": pageInfo.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    Item({
        this.kind,
        this.etag,
        this.id,
        this.snippet,
    });

    ItemKind kind;
    String etag;
    Id id;
    Snippet snippet;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        kind: itemKindValues.map[json["kind"]],
        etag: json["etag"],
        id: Id.fromJson(json["id"]),
        snippet: Snippet.fromJson(json["snippet"]),
    );

    Map<String, dynamic> toJson() => {
        "kind": itemKindValues.reverse[kind],
        "etag": etag,
        "id": id.toJson(),
        "snippet": snippet.toJson(),
    };
}

class Id {
    Id({
        this.kind,
        this.videoId,
    });

    IdKind kind;
    String videoId;

    factory Id.fromJson(Map<String, dynamic> json) => Id(
        kind: idKindValues.map[json["kind"]],
        videoId: json["videoId"],
    );

    Map<String, dynamic> toJson() => {
        "kind": idKindValues.reverse[kind],
        "videoId": videoId,
    };
}

enum IdKind { YOUTUBE_VIDEO }

final idKindValues = EnumValues({
    "youtube#video": IdKind.YOUTUBE_VIDEO
});

enum ItemKind { YOUTUBE_SEARCH_RESULT }

final itemKindValues = EnumValues({
    "youtube#searchResult": ItemKind.YOUTUBE_SEARCH_RESULT
});

class Snippet {
    Snippet({
        this.publishedAt,
        this.channelId,
        this.title,
        this.description,
        this.thumbnails,
        this.channelTitle,
        this.liveBroadcastContent,
        this.publishTime,
    });

    DateTime publishedAt;
    String channelId;
    String title;
    String description;
    Thumbnails thumbnails;
    String channelTitle;
    LiveBroadcastContent liveBroadcastContent;
    DateTime publishTime;

    factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        publishedAt: DateTime.parse(json["publishedAt"]),
        channelId: json["channelId"],
        title: json["title"],
        description: json["description"],
        thumbnails: Thumbnails.fromJson(json["thumbnails"]),
        channelTitle: json["channelTitle"],
        liveBroadcastContent: liveBroadcastContentValues.map[json["liveBroadcastContent"]],
        publishTime: DateTime.parse(json["publishTime"]),
    );

    Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt.toIso8601String(),
        "channelId": channelId,
        "title": title,
        "description": description,
        "thumbnails": thumbnails.toJson(),
        "channelTitle": channelTitle,
        "liveBroadcastContent": liveBroadcastContentValues.reverse[liveBroadcastContent],
        "publishTime": publishTime.toIso8601String(),
    };
}

enum LiveBroadcastContent { NONE }

final liveBroadcastContentValues = EnumValues({
    "none": LiveBroadcastContent.NONE
});

class Thumbnails {
    Thumbnails({
        this.thumbnailsDefault,
        this.medium,
        this.high,
    });

    Default thumbnailsDefault;
    Default medium;
    Default high;

    factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        thumbnailsDefault: Default.fromJson(json["default"]),
        medium: Default.fromJson(json["medium"]),
        high: Default.fromJson(json["high"]),
    );

    Map<String, dynamic> toJson() => {
        "default": thumbnailsDefault.toJson(),
        "medium": medium.toJson(),
        "high": high.toJson(),
    };
}

class Default {
    Default({
        this.url,
        this.width,
        this.height,
    });

    String url;
    int width;
    int height;

    factory Default.fromJson(Map<String, dynamic> json) => Default(
        url: json["url"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
    };
}

class PageInfo {
    PageInfo({
        this.totalResults,
        this.resultsPerPage,
    });

    int totalResults;
    int resultsPerPage;

    factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        totalResults: json["totalResults"],
        resultsPerPage: json["resultsPerPage"],
    );

    Map<String, dynamic> toJson() => {
        "totalResults": totalResults,
        "resultsPerPage": resultsPerPage,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
