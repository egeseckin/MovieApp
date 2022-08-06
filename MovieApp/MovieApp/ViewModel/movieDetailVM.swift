//
//  movieDetailVM.swift
//  MovieApp
//
//  Created by Ege Seçkin on 5.08.2022.
//

import Foundation

class movieDetailVM {

    var dataController: movieDataControllerInterface?
    var movieDetailLoaded: ((movieDetail) -> Void)?
    var movieId: String?
    var movieDetailData: movieDetail?

    
    init(){
        dataController = movieDataController()
    }
    init(movieId: String?){
        self.movieId = movieId
    }
    
    func fetchMovieDetail(){
        dataController?.fetchMovieDetail(id: movieId, completion:{ [weak self] response in
            self?.movieDetailLoaded?(response)
        })
    }
}
