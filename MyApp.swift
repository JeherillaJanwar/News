//
//  MyApp.swift
//  News
//
//  Created by Ishaan Sharma on 7/19/2022.
//

import SwiftUI

@main
struct XCANewsApp: App {
    
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}
