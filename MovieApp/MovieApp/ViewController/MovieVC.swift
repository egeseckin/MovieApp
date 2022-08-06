//
//  MovieVC.swift
//  MovieApp
//
//  Created by Ege Seçkin on 4.08.2022.
//

import UIKit

class MovieVC: UIViewController {

    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var noResultView: UIView!
    
    var viewModel = movieVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupModels()
    }
    
    func configureUI(){
        let label = UILabel()
        label.text = "Sinema"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = label
        tableView.register(UINib(nibName: "movieListCell", bundle: nil), forCellReuseIdentifier: movieListCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        noResultView.isHidden = true
    }
    func setupModels(){
        viewModel.moviesLoaded = { [weak self] data in
            if self?.viewModel.moviesData == nil {
                self?.viewModel.moviesData = data
            }
            DispatchQueue.main.async {
                
                self?.viewModel.moviesList = (self?.viewModel.moviesList ?? []) + (data.Search ?? [])
                if data.totalResults == "0" || data.totalResults == nil {
                    self?.noResultView.isHidden = false
                }else{
                    self?.noResultView.isHidden = true
                }
                self?.viewModel.totalCount = Int(data.totalResults ?? "0")  ?? 0
                self?.viewModel.pageTotal = (self?.viewModel.totalCount ?? 0) / 10  // 10 Movies on each page
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func searchTapped() {
        viewModel.searchTitle = searchTextField.text ?? ""
        viewModel.pageCount = 1
        self.viewModel.moviesList = []
        viewModel.fetchMovies()
    }
    
}


extension MovieVC: UITableViewDelegate{

}
extension MovieVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == (self.viewModel.moviesList?.count ?? 0) - 2 && viewModel.pageCount < (viewModel.pageTotal ?? 0) {
            viewModel.pageCount = viewModel.pageCount + 1
            viewModel.fetchMovies()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: movieListCell.reuseIdentifier, for: indexPath) as! movieListCell
        if let movie = self.viewModel.moviesList?[indexPath.row] {
            cell.configure(movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.moviesList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc =  UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "movieDetailVC") as! movieDetailVC
        let backItem = UIBarButtonItem()
        backItem.title = self.viewModel.moviesList?[indexPath.row].Title
        backItem.tintColor = .white
           navigationItem.backBarButtonItem = backItem
        vc.viewModel.movieId = self.viewModel.moviesList?[indexPath.row].imdbID
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
