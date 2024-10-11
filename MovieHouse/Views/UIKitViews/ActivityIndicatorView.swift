//
//  ActivityIndicatorView.swift
//  MovieHouse
//
//  Created by Nitish Jain on 04/10/24.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
        
    func makeUIView(context: Context) -> some UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
}
