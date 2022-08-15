//
//  SearchTabView.swift
//  News
//
//  Created by Ishaan Sharma on 7/19/22.
//

import SwiftUI

struct SearchTabView: View {
    
    @StateObject var searchVM = ArticleSearchViewModel.shared
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        ArticleListView(articles: articles)
            .overlay(overlayView)
            .navigationTitle("Search")
            .searchable(text: $searchVM.searchQuery, placement: horizontalSizeClass  == .regular ? .navigationBarDrawer : .automatic) { suggestionsView }
            .onChange(of: searchVM.searchQuery) { newValue in
                if newValue.isEmpty {
                    searchVM.phase = .empty
                }
            }
            .onSubmit(of: .search, search)
    }
    
    private var articles: [Article] {
        if case .success(let articles) = searchVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch searchVM.phase {
        case .empty:
            if !searchVM.searchQuery.isEmpty {
                ProgressView()
            } else if !searchVM.history.isEmpty {
                SearchHistoryListView(searchVM: searchVM) { newValue in
                    searchVM.searchQuery = newValue
                    search()
                }
            } else {
                EmptyPlaceholderView(text: "Search \nOn iPadOS: Swipe Down to bring Search Field", image: Image(systemName: "magnifyingglass"))
            }
            
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No search results found", image: Image(systemName: "magnifyingglass"))
            
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: search)
            
        default: EmptyView()
            
        }
    }
    
    @ViewBuilder
    private var suggestionsView: some View {
        ForEach(["Swift", "Covid-19", "Apple", "PS5", "iOS 15"], id: \.self) { text in
            Button {
                searchVM.searchQuery = text
            } label: {
                Text(text)
            }
        }
    }
    
    private func search() {
        let searchQuery = searchVM.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if !searchQuery.isEmpty {
            searchVM.addHistory(searchQuery)
        }
        
        Task {
            await searchVM.searchArticle()
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    
    @StateObject static var bookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        SearchTabView()
            .environmentObject(bookmarkVM)
    }
}
