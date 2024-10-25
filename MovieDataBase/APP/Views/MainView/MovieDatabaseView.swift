//
//  MovieDatabaseView.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 22/10/24.
//

import SwiftUI

struct MovieDatabaseView: View {
    @State private var searchText: String = ""
    @StateObject private var viewModel = MainViewModel()
    @State private var filteredMovies: [Movie] = []
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        
                        TextField("Search movies by title/actor/genre/director",
                                  text: Binding(
                                    get: { searchText },
                                    set: { newValue in
                                        searchText = newValue
                                        searchMovies(searchTerm: newValue)
                                    }
                                  ))
                            .padding(10)
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                                searchMovies(searchTerm: "")
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 8)
                        }
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                .padding(.top)

                List {
                    if !searchText.isEmpty {
                        if filteredMovies.isEmpty {
                            Text("No movies found")
                                .foregroundColor(.secondary)
                                .padding()
                        } else {
                            ForEach(filteredMovies, id: \.imdbID) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    MovieRowView(movie: movie)
                                }
                            }
                        }
                    } else {
                        filterSection(title: "Year", items: viewModel.years)
                        filterSection(title: "Genres", items: viewModel.genres)
                        filterSection(title: "Directors", items: viewModel.directors)
                        filterSection(title: "Actors", items: viewModel.actors)

                        NavigationLink(destination: SelectedMoviesView(movies: viewModel.movies)) {
                            Text("All Movies")
                                .padding(.vertical, 10)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Movie Database")
        }
    }
    
    private func searchMovies(searchTerm: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if searchTerm == searchText {
                filteredMovies = viewModel.getMoviesBySearch(searchTerm: searchTerm)
            }
        }
    }

    private func filterSection(title: String, items: [String]) -> some View {
        DisclosureGroup(title) {
            ForEach(items, id: \.self) { item in
                NavigationLink(destination: SelectedMoviesView(movies: viewModel.getMoviesBySearch(searchTerm: item))) {
                    Text(item)
                        .padding(.vertical, 10)
                }
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    MovieDatabaseView()
}
