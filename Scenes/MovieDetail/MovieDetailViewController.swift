//
//  MovieDetailViewController.swift
//  Eung7_MovieReview
//
//  Created by 김응철 on 2022/04/05.
//

import UIKit
import SnapKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    private var presenter: MovieDetailPresenter!
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .secondarySystemBackground
        
        return imageView
    }()
    
    private lazy var rightBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "star"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButton)
    )
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = MovieDetailPresenter(
            viewController: self,
            movie: movie
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension MovieDetailViewController: MovieDetailProtocol {
    func setViews(with movie: Movie) {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = movie.title
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let userRatingContentsStackView = MovieContentsStackView(
            title: "평점",
            contents: movie.userRating
        )
        
        let actorContentsStackView = MovieContentsStackView(
            title: "배우",
            contents: movie.actor
        )
        
        let directorContentsStackView = MovieContentsStackView(
            title: "감독",
            contents: movie.director
        )
        
        let pubdateContentsStackView = MovieContentsStackView(
            title: "제작년도",
            contents: movie.pubDate
        )
        
        let contentsStackView = UIStackView(arrangedSubviews: [
            userRatingContentsStackView,
            actorContentsStackView,
            directorContentsStackView,
            pubdateContentsStackView
        ])
        contentsStackView.axis = .vertical
        contentsStackView.spacing = 8

        [imageView, contentsStackView ]
            .forEach { view.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(imageView.snp.width)
        }
        
        contentsStackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.leading)
            $0.trailing.equalTo(imageView.snp.trailing)
            $0.top.equalTo(imageView.snp.bottom).offset(16)
        }
        
        if let imageURL = movie.imageURL {
            imageView.kf.setImage(with: movie.imageURL)
        }
    }
    
    func setRightBarButton(with isLiked: Bool) {
        let imageName = isLiked ? "star.fill" : "star"
        rightBarButtonItem.image = UIImage(systemName: imageName)
    }
}

private extension MovieDetailViewController {
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton()
    }
}
