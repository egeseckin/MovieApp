//
//  movieListCell.swift
//  MovieApp
//
//  Created by Ege Seçkin on 4.08.2022.
//

import UIKit
import Longinus

class movieListCell: UITableViewCell{
    
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var imgMovie: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblId: UILabel!
    @IBOutlet private weak var lblYear: UILabel!
    
    static var reuseIdentifier = "movieListCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI(){
        lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
        lblYear.font = UIFont.boldSystemFont(ofSize: 14)
        lblId.font = UIFont.systemFont(ofSize: 14)
        cellView.layer.borderColor = UIColor.systemGray4.cgColor
        cellView.layer.borderWidth = 1.0
        cellView.layer.cornerRadius = 6.0
        cellView.layer.shadowOpacity = 1.0
        cellView.layer.shadowRadius = 8.0
    }
    
    func configure(_ movie: movieModel) {
        lblTitle.text = movie.Title
        lblYear.text =  "Year: \(movie.Year ?? "")"
        lblId.text = "IMDB Id: \(movie.imdbID ?? "")"
        if let posterImage = URL(string: movie.Poster ?? "") {
                   DispatchQueue.main.async {
                       self.imgMovie.lg.setImage(with: posterImage)
                   }
               }
    }
}
