//
//  MainViewModel.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 22/10/24.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var years: [String] = []
    @Published var genres: [String] = []
    @Published var directors: [String] = []
    @Published var actors: [String] = []
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadMovies()
    }

    private func loadMovies() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let loadedMovies = MovieDatabase.shared.movies {
                DispatchQueue.main.async {
                    self?.movies = loadedMovies
                    self?.updateFilters()
                }
            }
        }
    }

    private func updateFilters() {
        years = Array(Set(movies.map { $0.year })).sorted()
        genres = Array(Set(movies.flatMap { $0.genre.components(separatedBy: ", ") })).sorted()
        directors = Array(Set(movies.map { $0.director })).sorted()
        actors = Array(Set(movies.flatMap { $0.actors.components(separatedBy: ", ") })).sorted()
    }
    
    func getMoviesBySearch(searchTerm: String) -> [Movie] {
        let searchLowercased = searchTerm.lowercased()

        return movies.filter { movie in
            let yearMatches = movie.year.lowercased() == searchLowercased ||
                              movie.year.lowercased().hasPrefix(searchLowercased)
            let genreMatches = movie.genre.lowercased().localizedCaseInsensitiveContains(searchLowercased)
            let directorMatches = movie.director.lowercased().localizedCaseInsensitiveContains(searchLowercased)
            let actorMatches = movie.actors.lowercased().localizedCaseInsensitiveContains(searchLowercased)
            let titleMatches = movie.title.lowercased().localizedCaseInsensitiveContains(searchLowercased)
            
            return yearMatches || genreMatches || directorMatches || actorMatches || titleMatches
        }
    }

}
