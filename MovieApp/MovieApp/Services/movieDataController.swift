//
//  movieDataController.swift
//  MovieApp
//
//  Created by Ege Seçkin on 4.08.2022.
//

import Foundation
import Alamofire

protocol movieDataControllerInterface: AnyObject{
    func fetchMovieData(title: String?, completion: @escaping((movies) -> Void))
}

public class movieDataController: movieDataControllerInterface {
    func fetchMovieData(title: String?, completion: @escaping((movies) -> Void)){
        let apikey = "44cb4261"
        AF.request("https://www.omdbapi.com/?apikey=\(apikey)&s=\(title ?? "")")
            .validate()
            .responseDecodable(of:movies.self) { (response) in
                guard let films = response.value else { return }
                completion(films)
        }
    }
}
