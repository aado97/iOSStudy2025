//
//  MovieUseCase.swift
//  weeklyMovieReviewApp
//
//  Created by 도민준 on 3/3/25.
//

import Foundation

class MovieUseCase {
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func getPopularMovies(completion: @escaping ([Movie]) -> Void) {
        repository.fetchPopularMovies { movies in
            completion(movies)
        }
    }
}
