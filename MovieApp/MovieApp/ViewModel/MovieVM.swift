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
    var moviesData: movies?
    
    init(){
        dataController = movieDataController()
    }
    
    func fetchMovies(){
        dataController?.fetchMovieData(title: searchTitle, completion: { [weak self] response in
            self?.moviesLoaded?(response)
        })
    }
}
