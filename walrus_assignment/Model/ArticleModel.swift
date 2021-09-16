//
//  ArticleModel.swift
//  walrus_assignment
//
//  Created by Payal Kandlur on 14/09/21.
//

import UIKit
import Realm
import RealmSwift

// MARK: - Welcome
//class ArticleModel: Object, Codable {
//    dynamic var status: String
//    dynamic var totalResults: Int
//    dynamic var articles: [Article]
//}

enum ArticleModelKeys: CodingKey {
    case source, author, title, description, url, urlToImage, publishedAt, content
}

// MARK: - Article
@objcMembers class ArticleModel: Object, Codable {
    dynamic var source: Source?
    dynamic var author: String?
    dynamic var title, articleDescription: String?
    dynamic var url: String?
    dynamic var urlToImage: String?
    dynamic var publishedAt: Date?
    dynamic var content: String?
    
    required override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: ArticleModelKeys.self)
        source = try? container.decodeIfPresent(Source.self, forKey: .source)
        title = try? container.decodeIfPresent(String.self, forKey: .title)
        articleDescription = try? container.decodeIfPresent(String.self, forKey: .description)
        author = try? container.decodeIfPresent(String.self, forKey: .author)
        urlToImage = try? container.decodeIfPresent(String.self, forKey: .urlToImage)
        url = try? container.decodeIfPresent(String.self, forKey: .url)
        publishedAt = try? container.decodeIfPresent(Date.self, forKey: .publishedAt)
        content = try? container.decodeIfPresent(String.self, forKey: .content)
    }
}

// MARK: - Source
class Source: Codable {
    dynamic var id: String?
    dynamic var name: String
}

