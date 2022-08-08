//
//  MovieVM.swift
//  MovieApp
//
//  Created by Ege Seçkin on 4.08.2022.
//

import Foundation

class movieVM {
    var dataController: movieDataControllerInterface?
    var moviesLoaded: ((movies) -> Void)?
    var searchTitle: String?
    var pageCount = 1
    var pageTotal: Int?
    var moviesData: movies?
    var moviesList: [movieModel]?
    
    init(){
        dataController = movieDataController()
    }
    
    func fetchMovies(){
        dataController?.fetchMovieData(title: searchTitle, pageCount: pageCount, completion: { [weak self] response in
            self?.moviesLoaded?(response)
        })
    }
}
