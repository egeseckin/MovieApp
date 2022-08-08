//
//  movieDataController.swift
//  MovieApp
//
//  Created by Ege Seçkin on 4.08.2022.
//

import Foundation
import Alamofire

protocol movieDataControllerInterface: AnyObject{
    func fetchMovieData(title: String?, pageCount: Int?, completion: @escaping((movies) -> Void))
    func fetchMovieDetail(id: String?, completion: @escaping((movieDetail) -> Void))
    
}

public class movieDataController: movieDataControllerInterface {
    let apikey = "44cb4261"
    
    //For the main page
    func fetchMovieData(title: String?, pageCount: Int?, completion: @escaping((movies) -> Void)){
        AF.request("https://www.omdbapi.com/?apikey=\(apikey)&s=\(title ?? "")&page=\(pageCount ?? 0)")
            .validate()
            .responseDecodable(of:movies.self) { (response) in
                guard let films = response.value else { return }
                completion(films)
            }
    }
    
    //For detail page
    func fetchMovieDetail(id: String?, completion: @escaping((movieDetail) -> Void)){
        AF.request("https://www.omdbapi.com/?apikey=\(apikey)&i=\(id ?? "")")
            .validate()
            .responseDecodable(of:movieDetail.self) { (response) in
                guard let films = response.value else { return }
                completion(films)
            }
    }
}
