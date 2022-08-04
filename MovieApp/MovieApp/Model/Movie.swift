//
//  Movie.swift
//  MovieApp
//
//  Created by Ege Seçkin on 4.08.2022.
//

import Foundation

struct movies: Decodable{
    let Search: [movieModel]?
}

struct movieModel: Decodable {
    let Title: String?
    let Year: String?
    let Poster: String?
    let imdbID: String?
}
