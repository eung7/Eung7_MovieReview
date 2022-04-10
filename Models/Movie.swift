//
//  Movie.swift
//  Eung7_MovieReview
//
//  Created by 김응철 on 2022/04/05.
//

import Foundation

struct Movie: Codable {
    let title: String
    let image: String
    let pubDate: String
    let director: String
    let actor: String
    let userRating: String
    
    var isLiked: Bool = false
    
    var imageURL: URL? { return URL(string: image) }
    
    private enum CodingKeys: String, CodingKey {
        case title, image, pubDate, director, actor, userRating
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        userRating = try container.decodeIfPresent(String.self, forKey: .userRating) ?? ""
        actor = try container.decodeIfPresent(String.self, forKey: .actor) ?? ""
        director = try container.decodeIfPresent(String.self, forKey: .director) ?? ""
        pubDate = try container.decodeIfPresent(String.self, forKey: .pubDate) ?? ""
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        isLiked = false
    }

    init(
        title: String,
        imageURL: String,
        userRating: String,
        actor: String,
        director: String,
        pubDate: String,
        isLiked: Bool
    ) {
        self.title = title
        self.image = imageURL
        self.userRating = userRating
        self.actor = actor
        self.director = director
        self.pubDate = pubDate
        self.isLiked = isLiked
    }
}
