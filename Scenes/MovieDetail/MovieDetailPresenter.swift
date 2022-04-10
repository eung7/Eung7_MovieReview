//
//  MovieDetailPresenter.swift
//  Eung7_MovieReview
//
//  Created by 김응철 on 2022/04/05.
//

import Foundation

protocol MovieDetailProtocol: AnyObject {
    func setViews(with movie: Movie)
    func setRightBarButton(with isLiked: Bool)
}

class MovieDetailPresenter {
    private let viewController: MovieDetailProtocol
    
    private let userDefaultsManager : UserDefaultsManagerProtocol
    
    private var movie: Movie
    
    init(
        viewController: MovieDetailProtocol,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager(),
        movie: Movie
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
        self.movie = movie
    }
    
    func viewDidLoad() {
        viewController.setViews(with: movie)
        viewController.setRightBarButton(with: movie.isLiked)
    }
    
    func didTapRightBarButton() {
        movie.isLiked.toggle()
        
        if movie.isLiked {
            userDefaultsManager.addMovie(movie)
        } else {
            userDefaultsManager.removeMovie(movie)
        }
        
        print(movie.isLiked)
        viewController.setRightBarButton(with: movie.isLiked)
    }
}
