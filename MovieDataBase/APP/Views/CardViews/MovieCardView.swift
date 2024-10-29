//  MovieCardView.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 22/10/24.

import SwiftUI

struct MovieCardView: View {
    let movieTitle: String
    let movieLanguages: String
    let movieYear: String
    let moviePoster: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
    
            AsyncImageView(url: moviePoster) // Loads poster image asynchronously
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movieTitle)
                    .font(.headline)
                    .lineLimit(2)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Language:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(movieLanguages)
                        .font(.subheadline)
                        .lineLimit(3)
                }
                
                Spacer(minLength: 4)
                
                HStack {
                    Text("Year:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(movieYear)
                        .font(.subheadline)
                }
            }
            .padding(.vertical, 4)
            
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12) // Background shape
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2) // Shadow for depth
        )
    }
}


#Preview {
    MovieCardView(
        movieTitle: "Meet the Parents",
        movieLanguages: "English, Thai, Spanish, Hebrew, French",
        movieYear: "2000",
        moviePoster: "https://m.media-amazon.com/images/M/MV5BMGNlMGZiMmUtZjU0NC00MWU4LWI0YTgtYzdlNGVhZGU4NWZlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg"
    )
}
