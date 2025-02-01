//
//  WKWebViewRepresentable.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import SwiftUI
import WebKit

struct WKWebViewRepresentable: UIViewRepresentable {
    let videoURL: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: videoURL) else { return }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
