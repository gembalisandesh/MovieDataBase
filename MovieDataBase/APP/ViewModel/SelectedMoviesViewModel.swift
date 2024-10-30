//
//  SelectedMoviesViewModel.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 30/10/24.
//


import SwiftUI
import Combine

class SelectedMoviesViewModel: ObservableObject {
    @Published var sortedMovies: [Movie] = []
    @Published var sortOrder: SortOrder = .titleAscending
    @Published var showSortOptions: Bool = false
    
    private var movies: [Movie] = []

    init(movies: [Movie]) {
        self.movies = movies
        refreshMovies()
    }

    func refreshMovies() {
        switch sortOrder {
        case .titleAscending:
            sortedMovies = movies.sorted { $0.title < $1.title }
        case .titleDescending:
            sortedMovies = movies.sorted { $0.title > $1.title }
        case .yearAscending:
            sortedMovies = movies.sorted { $0.year < $1.year }
        case .yearDescending:
            sortedMovies = movies.sorted { $0.year > $1.year }
        }
    }

    func applySortAndHide() {
        refreshMovies()
        showSortOptions = false
    }
}
