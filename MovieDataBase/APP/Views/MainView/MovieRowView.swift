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
