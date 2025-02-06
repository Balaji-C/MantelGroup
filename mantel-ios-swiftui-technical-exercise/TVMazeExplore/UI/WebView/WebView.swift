// Technical exercise, Mantel Group pty ltd.
// Created on 26/1/2025.

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.contentInsetAdjustmentBehavior = .always
        webView.scrollView.contentInset = .zero
        webView.scrollView.scrollIndicatorInsets = .zero
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let styledHTML = """
        <html>
        <head>
        <style>
        body {
            font-family: 'Helvetica Neue', sans-serif;
            font-size: 30px;
            color: #000000; 
            margin: 0;
            padding: 10;
        }
        </style>
        </head>
        <body>
        \(htmlContent)
        </body>
        </html>
        """
        webView.loadHTMLString(styledHTML, baseURL: nil)
    }
}
