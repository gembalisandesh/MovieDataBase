//
//  RatingDisplayView.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 22/10/24.
//

import SwiftUI

struct RatingDisplayView: View {
    let rating: Rating
    
    var body: some View {
        VStack(spacing: 8) {
            Text(rating.value)
                .font(.system(size: 36, weight: .bold))
            
            Group {
                switch rating.source {
                case .internetMovieDatabase:
                    IMDBRatingView(rating: rating.value)
                case .rottenTomatoes:
                    RottenTomatoesRatingView(rating: rating.value)
                case .metacritic:
                    MetacriticRatingView(rating: rating.value)
                }
            }
            .frame(height: 40)
        }
    }
}
