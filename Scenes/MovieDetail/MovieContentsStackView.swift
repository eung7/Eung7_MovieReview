//
//  MovieContentsStackView.swift
//  Eung7_MovieReview
//
//  Created by 김응철 on 2022/04/05.
//

import SnapKit
import UIKit

class MovieContentsStackView: UIStackView {
    private let title: String
    private let contents: String
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = title
        
        return label
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = contents
        
        return label
    }()
    
    init(title: String, contents: String) {
        self.title = title
        self.contents = contents
        
        super.init(frame: .zero)
        
        axis = .horizontal
        
        [ titleLabel, contentsLabel ]
            .forEach { addArrangedSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(80)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
