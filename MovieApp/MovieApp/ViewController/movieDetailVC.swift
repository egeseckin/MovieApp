//
//  movieDetailVC.swift
//  MovieApp
//
//  Created by Ege Seçkin on 5.08.2022.
//

import UIKit
import Lottie

protocol movieDetailVCDelegate: AnyObject{
    func movieDetail(_ model: movieDetail?)
}

class movieDetailVC: UIViewController {
    
    @IBOutlet private weak var imgPoster: UIImageView!
    @IBOutlet private weak var lblGenre: UILabel!
    @IBOutlet private weak var lblDetail: UILabel!
    @IBOutlet private weak var lblReleased: UILabel!
    @IBOutlet private weak var lblRuntime: UILabel!
    @IBOutlet private weak var animationView: AnimationView!
    @IBOutlet private weak var metaScoreView: UIView!
    @IBOutlet private weak var lblMetaScorePoint: UILabel!
    @IBOutlet private weak var lblMetaScore: UILabel!
    @IBOutlet private weak var imdbScoreView: UIView!
    @IBOutlet private weak var lblImdbScorePoint: UILabel!
    @IBOutlet private weak var lblImdbScore: UILabel!
    @IBOutlet private weak var hideStackView: UIStackView!
    
    var viewModel = movieDetailVM()
    
    weak var delegate: movieDetailVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        setupUI()
        lottieStart()
        viewModel.fetchMovieDetail()
        configureUI()
    }
    func setupUI(){
        
        lblGenre.font = UIFont.boldSystemFont(ofSize: 16)
        lblRuntime.font = UIFont.systemFont(ofSize: 16)
        lblReleased.font = UIFont.systemFont(ofSize: 16)
        lblDetail.font = UIFont.systemFont(ofSize: 14)
        lblDetail.textColor = .gray
        lblImdbScore.text = "IMDB Rating"
        imdbScoreView.layer.cornerRadius = 10.0
        imdbScoreView.layer.borderWidth = 3.0
        imdbScoreView.layer.borderColor = UIColor.blue.cgColor
        lblMetaScore.text = "Metascore"
        metaScoreView.layer.cornerRadius = 25.0
        metaScoreView.layer.backgroundColor = UIColor.systemPink.cgColor
    }
    func configureUI(){
        viewModel.movieDetailLoaded = { [weak self] data in
            DispatchQueue.main.async {
                self?.viewModel.movieDetailData = data
                self?.lottieStop()
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
        lblMetaScorePoint.text = data?.Metascore
        lblImdbScorePoint.text = data?.imdbRating
        lblGenre.attributedText = stringAttribute(boldString: "Genre: ", normalString: data?.Genre ?? "")
        lblReleased.attributedText = stringAttribute(boldString: "Released on: ", normalString: data?.Released ?? "Unknown")
        lblRuntime.attributedText =  stringAttribute(boldString: "Duration: ", normalString: data?.Runtime ?? "Unknown")
        lblDetail.attributedText = stringAttribute(boldString: "Plot: ", normalString: data?.Plot ?? "Unknown")
        let backBarButtonItem = UIBarButtonItem(title: data?.Title, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        
    }
}

extension movieDetailVC {
    func lottieStart(){
        animationView.isHidden = false
        hideStackView.isHidden = true
        animationView.play()
    }
    
    func lottieStop(){
        animationView.isHidden = true
        hideStackView.isHidden = false
        animationView.stop()
    }
    
    func stringAttribute(boldString: String?, normalString: String?) -> NSMutableAttributedString?{

        let firstAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.black]
        let secondAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]

        let firstString = NSMutableAttributedString(string: boldString ?? "", attributes: firstAttributes)
        let secondString = NSAttributedString(string: normalString ?? "", attributes: secondAttributes)

        firstString.append(secondString)
        return firstString
    }

}
