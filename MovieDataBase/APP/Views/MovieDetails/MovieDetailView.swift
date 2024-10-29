//
//  MovieDetailView.swift
//  MovieDataBase
//
//  Created by Gembali Sandesh Kumar on 22/10/24.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @State private var selectedRatingSource: Source = .internetMovieDatabase
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header section with movie poster and title
                ZStack(alignment: .bottom) {
                    AsyncImageView(url: movie.poster) // Asynchronous loading of the movie poster
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 400)
                    
                    // Gradient overlay for title visibility
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(0.5)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 200)
                    
                    // Movie title and year display
                    VStack(alignment: .leading, spacing: 4) {
                        Text(movie.title)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("(\(movie.year))")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                // Ratings section
                VStack(spacing: 16) {
                    Picker("Rating Source", selection: $selectedRatingSource) {
                        Text("IMDB").tag(Source.internetMovieDatabase)
                        Text("Rotten Tomatoes").tag(Source.rottenTomatoes)
                        Text("Metacritic").tag(Source.metacritic)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    // Display the selected rating
                    if let rating = movie.ratings.first(where: { $0.source == selectedRatingSource }) {
                        RatingDisplayView(rating: rating) // Custom view to show the rating
                            .padding(.bottom)
                    }
                }
                .padding(.vertical, 20)
                .background(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 1)
                
                // Sections for detailed movie information
                VStack(spacing: 24) {
                    ContentSection(title: "Plot") {
                        Text(movie.plot)
                            .lineSpacing(4)
                            .foregroundColor(.primary.opacity(0.9))
                    }
                    
                    ContentSection(title: "Credits") {
                        // Displaying director, cast, and writer information
                        InfoRow(title: "Director", content: movie.director)
                        InfoRow(title: "Cast", content: movie.actors)
                        InfoRow(title: "Writer", content: movie.writer)
                    }
                    
                    ContentSection(title: "Details") {
                        // Displaying various movie details
                        InfoRow(title: "Released", content: movie.released)
                        InfoRow(title: "Genre", content: movie.genre)
                        InfoRow(title: "Runtime", content: movie.runtime)
                        InfoRow(title: "Language", content: movie.language)
                        InfoRow(title: "Country", content: movie.country)
                    }
                    
                    ContentSection(title: "Recognition") {
                        // Awards and box office information
                        InfoRow(title: "Awards", content: movie.awards)
                        if let boxOffice = movie.boxOffice {
                            InfoRow(title: "Box Office", content: boxOffice)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    let mockMovie = Movie(
        title: "Meet the Parents",
        year: "2000",
        rated: "PG-13",
        released: "06 Oct 2000",
        runtime: "108 min",
        genre: "Comedy, Romance",
        director: "Jay Roach",
        writer: "Greg Glienna, Mary Ruth Clarke",
        actors: "Robert De Niro, Ben Stiller, Teri Polo, Blythe Danner",
        plot: "A Jewish male nurse plans to ask his live-in girlfriend to marry him. However, he learns that her strict father expects to be asked for his daughter's hand before she can accept.",
        language: "English, Thai, Spanish, Hebrew, French",
        country: "USA",
        awards: "Nominated for 1 Oscar. Another 7 wins & 14 nominations.",
        poster: "https://m.media-amazon.com/images/M/MV5BMGNlMGZiMmUtZjU0NC00MWU4LWI0YTgtYzdlNGVhZGU4NWZlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg",
        ratings: [
            Rating(source: .internetMovieDatabase, value: "7.0/10"),
            Rating(source: .rottenTomatoes, value: "84%"),
            Rating(source: .metacritic, value: "73/100")
        ],
        metascore: "73",
        imdbRating: "7.0",
        imdbVotes: "287,123",
        imdbID: "tt0212338",
        type: .movie,
        dvd: .the28Nov2000,
        boxOffice: "$166,244,045",
        production: "Universal Pictures",
        website: .nA,
        response: .responseTrue
    )
    
    return NavigationView {
        MovieDetailView(movie: mockMovie)
    }
}
