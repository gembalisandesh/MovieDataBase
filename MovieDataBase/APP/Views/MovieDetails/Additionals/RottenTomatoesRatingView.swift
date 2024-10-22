//
//  RottenTomatoesRatingView.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 22/10/24.
//

import SwiftUI

struct RottenTomatoesRatingView: View {
    let rating: String
    
    private var percentage: Double {
        Double(rating.replacingOccurrences(of: "%", with: "")) ?? 0
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: percentage >= 60 ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                .foregroundColor(percentage >= 60 ? .green : .red)
            
            Text("\(Int(percentage))%")
                .fontWeight(.semibold)
        }
    }
}
