//
//  YoutubeView.swift
//  MovieHouse
//
//  Created by Nitish Jain on 05/10/24.
//

import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let videoKey: String
    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let videoURL = URL(string: "https://www.youtube.com/embed/\(videoKey)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: videoURL))
    }
}
