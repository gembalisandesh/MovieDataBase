//
//  SelectedMoviesView.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 22/10/24.
//

import SwiftUI

struct SelectedMoviesView: View {
    @StateObject private var viewModel: SelectedMoviesViewModel

    // Accept the movies array in the initializer
    init(movies: [Movie]) {
        _viewModel = StateObject(wrappedValue: SelectedMoviesViewModel(movies: movies))
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        // Display each movie card
                        ForEach(viewModel.sortedMovies, id: \.imdbID) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieCardView(
                                    movieTitle: movie.title,
                                    movieLanguages: movie.language,
                                    movieYear: movie.year,
                                    moviePoster: movie.poster
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .navigationTitle("Available Options") // Title for the navigation bar
                .navigationBarTitleDisplayMode(.large)
                .navigationBarItems(trailing: Button(action: {
                    viewModel.showSortOptions.toggle() // Toggle sort options visibility
                }) {
                    Text("Sort")
                })

                // Show sort options if toggle is true
                if viewModel.showSortOptions {
                    VStack(alignment: .trailing) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Spacer()
                                Button("Cancel") {
                                    viewModel.showSortOptions = false // Hide sort options
                                }
                                .foregroundColor(.red)
                                .padding(.trailing, 8)
                            }

                            // Sort buttons with actions
                            Button(action: {
                                viewModel.sortOrder = .titleAscending
                                viewModel.applySortAndHide() // Apply sorting and hide options
                            }) {
                                HStack {
                                    Text("Title Ascending")
                                    Text("↑")
                                }
                            }

                            Button(action: {
                                viewModel.sortOrder = .titleDescending
                                viewModel.applySortAndHide()
                            }) {
                                HStack {
                                    Text("Title Descending")
                                    Text("↓")
                                }
                            }

                            Button(action: {
                                viewModel.sortOrder = .yearAscending
                                viewModel.applySortAndHide()
                            }) {
                                HStack {
                                    Text("Year Ascending")
                                    Text("↑")
                                }
                            }

                            Button(action: {
                                viewModel.sortOrder = .yearDescending
                                viewModel.applySortAndHide()
                            }) {
                                HStack {
                                    Text("Year Descending")
                                    Text("↓")
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .frame(maxWidth: 190)
                    }
                    .padding(.top, 8)
                    .padding(.trailing, 16)
                    .position(x: geometry.size.width - 90, y: 95) // Position of sort options
                }
            }
        }
    }
}
#Preview {
    NavigationView {
        SelectedMoviesView(movies: [
            Movie(
                title: "Meet the Parents",
                year: "2000",
                rated: "PG-13",
                released: "2000-10-06",
                runtime: "95 min",
                genre: "Comedy",
                director: "Jay Roach",
                writer: "Jim Herzfeld, John Hamburg",
                actors: "Ben Stiller, Robert De Niro, Blythe Danner",
                plot: "A man is caught between his future father-in-law and his own father.",
                language: "English, Thai, Spanish, Hebrew, French",
                country: "USA",
                awards: "Nominated for 1 Oscar. Another 8 wins & 22 nominations.",
                poster: "movie_poster_image",
                ratings: [],
                metascore: "N/A",
                imdbRating: "7.0",
                imdbVotes: "139,892",
                imdbID: "tt0212338",
                type: .movie,
                dvd: nil,
                boxOffice: "$166,200,000",
                production: "Universal Pictures",
                website: nil,
                response: .responseTrue
            ),
            Movie(
                title: "Inception",
                year: "2010",
                rated: "PG-13",
                released: "2010-07-16",
                runtime: "148 min",
                genre: "Action, Adventure, Sci-Fi",
                director: "Christopher Nolan",
                writer: "Christopher Nolan",
                actors: "Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page",
                plot: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.",
                language: "English, Japanese, French",
                country: "USA, UK",
                awards: "Won 4 Oscars. Another 143 wins & 218 nominations.",
                poster: "inception_poster_image",
                ratings: [],
                metascore: "74",
                imdbRating: "8.8",
                imdbVotes: "2,047,570",
                imdbID: "tt1375666",
                type: .movie,
                dvd: nil,
                boxOffice: "$836,836,967",
                production: "Warner Bros.",
                website: nil,
                response: .responseTrue
            )
        ])
    }
}
