//
//  MovieListViewModel.swift
//  weeklyMovieReviewApp
//
//  Created by 도민준 on 3/3/25.
//


import Foundation

class MovieListViewModel {
    private let movieUseCase: MovieUseCase
    var movies: [Movie] = [] {
        didSet {
            print("Movies updated: \(movies)")
            self.reloadCollectionView?()
        }
    }
    
    var reloadCollectionView: (() -> Void)?
    
    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
    }
    
    func fetchMovies() {
        movieUseCase.getPopularMovies { [weak self] movies in
            self?.movies = movies
        }
    }
    
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
    
    var numberOfMovies: Int {
        return movies.count
    }
}
