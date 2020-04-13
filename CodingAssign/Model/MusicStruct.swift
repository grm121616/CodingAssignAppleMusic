//
//  MusicStruct.swift
//  CodingAssign
//
//  Created by Ruoming Gao on 4/10/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

struct MusicStruct: Codable {
    let feed: FeedContainer
}

struct FeedContainer: Codable {
    let results: [ResultContainer]
    let title: String
}

struct ResultContainer: Codable {
    let artistName: String
    let name: String
    let artworkUrl100: URL
    let releaseDate: String
    let copyright: String
    let genres: [GenresContainer]
    let artistUrl: String
}

struct GenresContainer: Codable {
    let name: String
}
