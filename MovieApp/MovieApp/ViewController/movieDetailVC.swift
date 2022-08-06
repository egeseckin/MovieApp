//
//  movieDetailVC.swift
//  MovieApp
//
//  Created by Ege Seçkin on 5.08.2022.
//

import UIKit

protocol movieDetailVCDelegate: AnyObject{
    func movieDetail(_ model: movieDetail?)
}

class movieDetailVC: UIViewController {
    
    @IBOutlet private weak var imgPoster: UIImageView!
    @IBOutlet private weak var lblGenre: UILabel!
    @IBOutlet private weak var lblDetail: UILabel!
    
    var viewModel = movieDetailVM()
    
    weak var delegate: movieDetailVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        setupUI()
        viewModel.fetchMovieDetail()
        configureUI()
    }
    func setupUI(){
        
        lblGenre.font = UIFont.boldSystemFont(ofSize: 16)
        lblDetail.font = UIFont.systemFont(ofSize: 14)
        lblDetail.textColor = .gray
    }
    func configureUI(){
        viewModel.movieDetailLoaded = { [weak self] data in
            DispatchQueue.main.async {
                self?.viewModel.movieDetailData = data
                self?.setup()
            }
        }
    }
    func setup(){
        let data = viewModel.movieDetailData
        if let posterImage = URL(string: data?.Poster ?? "") {
            DispatchQueue.main.async {
                self.imgPoster.lg.setImage(with: posterImage)
            }
        }
        lblGenre.text = "Genre: \(data?.Genre ?? "")"
        lblDetail.text = data?.Plot
        let backBarButtonItem = UIBarButtonItem(title: data?.Title, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem

    }
}
