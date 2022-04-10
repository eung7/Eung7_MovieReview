//
//  ViewController.swift
//  Eung7_MovieReview
//
//  Created by 김응철 on 2022/04/05.
//

import UIKit
import SnapKit

class MovieListViewController: UIViewController {
    lazy var presenter = MovieListPresenter(viewController: self)
    
    private let searchController = UISearchController()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = presenter
        collectionView.dataSource = presenter
        collectionView.register(
            MovieListCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier
        ) 
        
        return collectionView
    }()
    
    private lazy var lazyTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        tableView.delegate = presenter
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
}

extension MovieListViewController: MovieListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "영화 평점"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        navigationItem.searchController = searchController
    }
    
    func setupViews() {
        [ collectionView, lazyTableView ]
            .forEach { view.addSubview($0) }

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lazyTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lazyTableView.isHidden = true
    }
    
    func updateLazyTableView(isHidden: Bool) {
        lazyTableView.isHidden = isHidden
    }
    
    func updateTableView() {
        lazyTableView.reloadData()
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
    
    func pushToMovieDetailVC(with movie: Movie) {
        let movieDetailVC = MovieDetailViewController(movie: movie)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
