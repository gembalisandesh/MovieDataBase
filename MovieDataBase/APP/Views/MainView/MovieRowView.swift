//
//  MovieRowView.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 25/10/24.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            AsyncImageView(url: movie.poster)
                .aspectRatio(contentMode: .fill)  
                .frame(width: 70, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 8))  
            
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
