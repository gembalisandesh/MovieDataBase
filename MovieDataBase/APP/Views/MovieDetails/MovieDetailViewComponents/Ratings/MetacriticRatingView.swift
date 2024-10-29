//
//  MetacriticRatingView.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 22/10/24.
//

import SwiftUI

struct MetacriticRatingView: View {
    let rating: String
    
    private var score: Int {
        Int(rating.split(separator: "/").first ?? "0") ?? 0
    }
    
    private var color: Color {
        switch score {
        case 75...100: return .green
        case 50...74: return .yellow
        default: return .red
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: 3)
                .frame(width: 40, height: 40)
            
            Text("\(score)")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(color)
        }
    }
}
