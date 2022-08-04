//
//  MovieVC.swift
//  MovieApp
//
//  Created by Ege Seçkin on 4.08.2022.
//

import UIKit

class MovieVC: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = movieVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        setupModels()
    }
    
    func configureUI(){
        tableView.register(UINib(nibName: "movieListCell", bundle: nil), forCellReuseIdentifier: movieListCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    func setupModels(){
        viewModel.moviesLoaded = { [weak self] data in
            DispatchQueue.main.async {
                self?.viewModel.moviesData = data
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func searchTapped() {
        viewModel.searchTitle = searchTextField.text ?? ""
        viewModel.fetchMovies()
    }
    
}


extension MovieVC: UITableViewDelegate{

}
extension MovieVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieListCell.reuseIdentifier, for: indexPath) as! movieListCell
        if let movie = viewModel.moviesData?.Search?[indexPath.row] {
            cell.configure(movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesData?.Search?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
