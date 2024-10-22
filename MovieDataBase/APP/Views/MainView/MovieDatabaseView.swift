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
    @State private var isSearching: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search movies by title/actor/genre/director", text: $searchText, onCommit: {
                        searchMovies()
                    })
                    .padding(10)
                    .padding(.leading, 30)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.leading, 8)
                            Spacer()
                        }
                    )
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                .padding(.top)

                List {
                    if isSearching {
                        ForEach(filteredMovies, id: \.imdbID) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                HStack {
                                    AsyncImage(url: URL(string: movie.poster)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 70, height: 100)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 70, height: 100)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                        case .failure:
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 70, height: 100)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text(movie.title)
                                            .font(.headline)
                                        Text("Language: \(movie.language)")
                                            .font(.subheadline)
                                        Text("Year: \(movie.year)")
                                            .font(.subheadline)
                                    }
                                    .padding(.leading, 10)
                                }
                                .padding(.vertical, 10)
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
    
    private func searchMovies() {
        filteredMovies = viewModel.getMoviesBySearch(searchTerm: searchText)
        isSearching = !searchText.isEmpty
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
