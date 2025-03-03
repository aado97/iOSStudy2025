//
//  MovieRepository.swift
//  weeklyMovieReviewApp
//
//  Created by 도민준 on 3/3/25.
//

import Foundation

protocol MovieRepository {
    func fetchPopularMovies(completion: @escaping ([Movie]) -> Void)
}
