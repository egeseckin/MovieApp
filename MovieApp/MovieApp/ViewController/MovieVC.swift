//
//  MovieVC.swift
//  MovieApp
//
//  Created by Ege Seçkin on 4.08.2022.
//

import UIKit
import Lottie

class MovieVC: UIViewController {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var noResultView: UIView!
    @IBOutlet private weak var animationView: AnimationView!
    
    var viewModel = movieVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupModels()
    }
    
    func configureUI(){
        tableView.register(UINib(nibName: "movieListCell", bundle: nil), forCellReuseIdentifier: movieListCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        noResultView.isHidden = true
        lottieInitialize()
        shadowNavitagiotnBar()
        
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
                self?.viewModel.pageTotal = (Int(data.totalResults ?? "0") ?? 0) / 10  // 10 Movies on each page
                self?.lottieStop()
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func searchTapped() {
        viewModel.searchTitle = searchTextField.text ?? ""
        viewModel.pageCount = 1
        self.viewModel.moviesList = []
        lottieStart()
        viewModel.fetchMovies()
    }
    
}


extension MovieVC: UITableViewDelegate{
    
}
extension MovieVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == (self.viewModel.moviesList?.count ?? 0) - 2 && viewModel.pageCount < (viewModel.pageTotal ?? 0) {
            viewModel.pageCount = viewModel.pageCount + 1
            lottieStart()
            viewModel.fetchMovies()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: movieListCell.reuseIdentifier, for: indexPath) as! movieListCell
        if let movie = self.viewModel.moviesList?[indexPath.row] {
            cell.configure(movie)
        }
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.moviesList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
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

extension MovieVC {
    func lottieInitialize(){
        animationView.isHidden = true
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
    }
    func lottieStart(){
        animationView.isHidden = false
        animationView.play()
    }
    
    func lottieStop(){
        animationView.isHidden = true
        animationView.stop()
    }
    
    func shadowNavitagiotnBar(){
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
    }
}
