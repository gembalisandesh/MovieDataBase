//
//  MovieDatabaseView.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 22/10/24.
//

import SwiftUI

struct MovieDatabaseView: View {
    @State private var searchText: String = "" // State to hold the user's search text
    @StateObject private var viewModel = MainViewModel() // View model for managing movie data
    @State private var filteredMovies: [Movie] = [] // State to hold filtered movie results
    
    var body: some View {
        NavigationView {
            VStack {
                // Search bar for filtering movies
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        
                        // TextField for inputting search queries
                        TextField("Search movies by title/actor/genre/director",
                                  text: Binding(
                                    get: { searchText },
                                    set: { newValue in
                                        searchText = newValue
                                        searchMovies(searchTerm: newValue) // Trigger search on text change
                                    }
                                  ))
                            .padding(10)
                        
                        // Clear button to reset search
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = "" // Reset search text
                                searchMovies(searchTerm: "") // Clear filtered results
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 8)
                        }
                    }
                    .background(Color(.systemGray6)) // Background for the search bar
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                .padding(.top)

                // List for displaying movies
                List {
                    // If searching, show filtered results or a message
                    if !searchText.isEmpty {
                        if filteredMovies.isEmpty {
                            Text("No movies found") // Message when no results are found
                                .foregroundColor(.secondary)
                                .padding()
                        } else {
                            ForEach(filteredMovies, id: \.imdbID) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    MovieRowView(movie: movie) // Custom view for displaying movie info
                                }
                            }
                        }
                    } else {
                        // Display filter sections for categories when not searching
                        filterSection(title: "Year", items: viewModel.years)
                        filterSection(title: "Genres", items: viewModel.genres)
                        filterSection(title: "Directors", items: viewModel.directors)
                        filterSection(title: "Actors", items: viewModel.actors)

                        // Navigation link to view all movies
                        NavigationLink(destination: SelectedMoviesView(movies: viewModel.movies)) {
                            Text("All Movies")
                                .padding(.vertical, 10)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Movie Database") // Title for the navigation view
        }
    }
    
    // Function to search for movies based on the user's input
    private func searchMovies(searchTerm: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Delay for better UX
            if searchTerm == searchText {
                filteredMovies = viewModel.getMoviesBySearch(searchTerm: searchTerm) // Filter results
            }
        }
    }

    // Function to create a section with filters
    private func filterSection(title: String, items: [String]) -> some View {
        DisclosureGroup(title) {
            ForEach(items, id: \.self) { item in
                // Navigation link for each item in the filter
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
