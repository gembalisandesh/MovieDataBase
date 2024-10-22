//
//  SelectedMoviesView.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 22/10/24.
//

import SwiftUI
struct SelectedMoviesView: View {
    let movies: [Movie]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(movies, id: \.imdbID) { movie in
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
        .navigationTitle("Available Options")
        .navigationBarTitleDisplayMode(.large)
    }
}
#Preview {
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
