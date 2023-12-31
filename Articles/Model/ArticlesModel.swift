//
//  ArticlesModel.swift
//  Articles
//
//  Created by Louise on 18/12/23.
//

import Foundation

struct ArticlesModel: Decodable, Hashable {
    let status: String
    let totalResults: Int
    let articles: [Main]?
}

struct Main: Decodable, Hashable {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

