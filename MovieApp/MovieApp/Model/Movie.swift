//
//  Movie.swift
//  MovieApp
//
//  Created by Ege Seçkin on 4.08.2022.
//

import Foundation

struct movies: Decodable{
    var Search: [movieModel]?
    let totalResults: String?
}

struct movieModel: Decodable {
    let Title: String?
    let Year: String?
    let Poster: String?
    let imdbID: String?
}

struct movieDetail: Decodable {
    let Title: String?
    let Genre: String?
    let Poster: String?
    let Plot: String?
    let Released: String?
    let Runtime: String?
    let Metascore: String?
    let imdbRating: String?
}
