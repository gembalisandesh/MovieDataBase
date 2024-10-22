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
                ZStack(alignment: .bottom) {
                    AsyncImage(url: URL(string: movie.poster)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 400)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(height: 400)
                    }
                    
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 200)
                    
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
                
                VStack(spacing: 16) {
                    Picker("Rating Source", selection: $selectedRatingSource) {
                        Text("IMDB").tag(Source.internetMovieDatabase)
                        Text("Rotten Tomatoes").tag(Source.rottenTomatoes)
                        Text("Metacritic").tag(Source.metacritic)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    if let rating = movie.ratings.first(where: { $0.source == selectedRatingSource }) {
                        RatingDisplayView(rating: rating)
                            .padding(.bottom)
                    }
                }
                .padding(.vertical, 20)
                .background(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 1)
                
                VStack(spacing: 24) {
                    ContentSection(title: "Plot") {
                        Text(movie.plot)
                            .lineSpacing(4)
                            .foregroundColor(.primary.opacity(0.9))
                    }
                    
                    ContentSection(title: "Credits") {
                        InfoRow(title: "Director", content: movie.director)
                        InfoRow(title: "Cast", content: movie.actors)
                        InfoRow(title: "Writer", content: movie.writer)
                    }
                    
                    ContentSection(title: "Details") {
                        InfoRow(title: "Released", content: movie.released)
                        InfoRow(title: "Genre", content: movie.genre)
                        InfoRow(title: "Runtime", content: movie.runtime)
                        InfoRow(title: "Language", content: movie.language)
                        InfoRow(title: "Country", content: movie.country)
                    }
                    
                    ContentSection(title: "Recognition") {
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
