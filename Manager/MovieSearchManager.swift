//
//  MovieSearchManager.swift
//  Eung7_MovieReview
//
//  Created by 김응철 on 2022/04/05.
//

import Foundation
import Alamofire

protocol MovieSearchManagerProtocol {
    func request(from keyword: String, completionHandler: @escaping ([Movie]) -> Void)
}

struct MovieSearchManager: MovieSearchManagerProtocol {
    func request(from keyword: String, completionHandler : @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/movie.json") else { return }
        let parameters = MovieSearchRequestModel(query: keyword)
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "OEVjFIrvWUYMXPYGibPs",
            "X-Naver-Client-Secret": "nHYyTuXM1F"
        ]
        AF
            .request(
                url,
                method: .get,
                parameters: parameters,
                headers: headers
            )
            .responseDecodable(of: MovieSearchReponseModel.self, completionHandler: { response in
                switch response.result {
                case .success(let data) :
                    completionHandler(data.items)
                case .failure(let err) :
                    print(err.localizedDescription)
                }
            })
            .resume()
    }
}
