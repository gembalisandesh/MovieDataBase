//
//  IMDBRatingView.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 22/10/24.
//

import SwiftUI

struct IMDBRatingView: View {
    let rating: String
    
    private var ratingValue: Double {
        Double(rating.split(separator: "/").first ?? "0") ?? 0
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<5) { index in
                Image(systemName: index < Int(ratingValue/2) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
        }
    }
}
