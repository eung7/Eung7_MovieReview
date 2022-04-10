//
//  UserDefaultsManager.swift
//  Eung7_MovieReview
//
//  Created by 김응철 on 2022/04/05.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func getMovie() -> [Movie]
    func addMovie(_ newValue: Movie)
    func removeMovie(_ value: Movie)
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case movie
    }
    
    func getMovie() -> [Movie] {
        guard let data = UserDefaults.standard.data(forKey: Key.movie.rawValue) else { return [] }
        let movies = try? PropertyListDecoder().decode([Movie].self, from: data)
        
        return movies ?? []
    }
    
    func addMovie(_ newValue: Movie) {
        var currentMovies: [Movie] = getMovie()
        currentMovies.insert(newValue, at: 0)
        
        setMovie(currentMovies)
    }
    
    func removeMovie(_ value: Movie) {
        let currentMovies: [Movie] = getMovie()
        let newValue = currentMovies.filter { $0.title != value.title }
        
        setMovie(newValue)
    }
    
    func setMovie(_ movie: [Movie]) {
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(movie),
            forKey: Key.movie.rawValue
        )
    }
}
