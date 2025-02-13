//
//  WebViewScreen.swift
//  radiostore
//
//  Created by adham khwaldeh on 15/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import SwiftUI

struct WebViewScreen: View {

    @StateObject var webViewStore = WebViewStore()

    var url: String

    var body: some View {
        NavigationView {
            WebView(webView: webViewStore.webView)
                .navigationBarTitle(Text(verbatim: webViewStore.title ?? ""), displayMode: .inline)
                .navigationBarItems(trailing: HStack {
                Button(action: goBack) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                }.disabled(!webViewStore.canGoBack)
                Button(action: goForward) {
                    Image(systemName: "chevron.right")
                        .imageScale(.large)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                }.disabled(!webViewStore.canGoForward)
            })
        }.navigationViewStyle(.stack)
            .onAppear {
            self.webViewStore.webView.load(URLRequest(url: URL(string: url)!))
        }
    }

    func goBack() {
        webViewStore.webView.goBack()
    }

    func goForward() {
        webViewStore.webView.goForward()
    }
}
