//
//  AsyncImageView.swift
//  MovieDataBase
//
//  Created by gembali sandesh kumar on 29/10/24.
//


import SwiftUI  

struct AsyncImageView: View {  
    let url: String  
    let placeholder: AnyView?  
    let errorView: AnyView?  
    
    init(url: String, placeholder: AnyView? = nil, errorView: AnyView? = nil) {  
        self.url = url  
        self.placeholder = placeholder  
        self.errorView = errorView  
    }  
    
    var body: some View {  
        AsyncImage(url: URL(string: url)) { phase in  
            switch phase {  
            case .empty:  
                placeholder ?? AnyView(ProgressView())  
            case .success(let image):  
                image  
                    .resizable()                      
                    .clipped()  
            case .failure:  
                errorView ?? AnyView(RoundedRectangle(cornerRadius: 8)  
                    .fill(Color.gray.opacity(0.3)))  
            @unknown default:  
                EmptyView()  
            }  
        }  
    }  
}  