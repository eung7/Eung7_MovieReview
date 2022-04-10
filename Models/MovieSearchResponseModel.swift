//
//  MovieSearchResponseModel.swift
//  Eung7_MovieReview
//
//  Created by 김응철 on 2022/04/05.
//

import Foundation

struct MovieSearchReponseModel: Decodable {
    var items: [Movie] = []
}
