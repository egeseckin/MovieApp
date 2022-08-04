//
//  movieListCell.swift
//  MovieApp
//
//  Created by Ege Seçkin on 4.08.2022.
//

import UIKit
import Longinus

class movieListCell: UITableViewCell{
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    static var reuseIdentifier = "movieListCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI(){
        lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
        lblYear.font = UIFont.boldSystemFont(ofSize: 14)
        lblId.font = UIFont.systemFont(ofSize: 14)
    }
    
    func configure(_ movie: movieModel) {
        lblTitle.text = movie.Title
        lblYear.text = movie.Year
        lblId.text = movie.imdbID
        if let posterImage = URL(string: movie.Poster ?? "") {
                   DispatchQueue.main.async {
                       self.imgMovie.lg.setImage(with: posterImage)
                   }
               }
    }
}
