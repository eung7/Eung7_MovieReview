//
//  MovieListPresenter.swift
//  Eung7_MovieReview
//
//  Created by 김응철 on 2022/04/05.
//

import Foundation
import UIKit

protocol MovieListProtocol: AnyObject {
    func setupNavigationBar()
    func setupSearchBar()
    func setupViews()
    func updateLazyTableView(isHidden: Bool)
    func updateTableView()
    func updateCollectionView()
    func pushToMovieDetailVC(with movie: Movie)
}

class MovieListPresenter: NSObject {
    private let viewController: MovieListProtocol // 이 프로토콜을 상속받는 어떠한 객체? 상수? 변수? 다 받겠다 !
    
    private let movieSearchManager = MovieSearchManager()
    
    private let userDefaultsManager = UserDefaultsManager()
    
    private var likedMovie: [Movie] = []
    private var currentMovieSearchResult: [Movie] = []
    
    init(
        viewController: MovieListProtocol
    ) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupSearchBar()
        viewController.setupViews()
    }
    
    func viewWillAppear() {
        likedMovie = userDefaultsManager.getMovie()
        viewController.updateCollectionView()
        print(likedMovie)
    }
}

extension MovieListPresenter: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewController.updateLazyTableView(isHidden: false)
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewController.updateLazyTableView(isHidden: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieSearchManager.request(from: searchText) { [weak self] movies in
            self?.currentMovieSearchResult = movies
            self?.viewController.updateTableView()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentMovieSearchResult = []
        viewController.updateTableView()
    }
}

extension MovieListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 16.0
        let width = (collectionView.frame.width - spacing * 3) / 2
        return CGSize(width: width, height: 210.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = likedMovie[indexPath.item]
        viewController.pushToMovieDetailVC(with: movie)
    }
}

extension MovieListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.update(likedMovie[indexPath.item])
        
        return cell
    }
}

extension MovieListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMovieSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = currentMovieSearchResult[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(movie.title)"
        
        return cell
    }
}

extension MovieListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = currentMovieSearchResult[indexPath.row]
        viewController.pushToMovieDetailVC(with: movie)
    }
}
