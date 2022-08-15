//
//  ContentView.swift
//  News
//
//  Created by Ishaan Sharma on 7/19/2022.
//


import SwiftUI

struct ContentView: View {
    
    @AppStorage("item_selection") var selectedMenuItemId: MenuItem.ID?
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        switch horizontalSizeClass {
        case .regular:
            SidebarContentView(selectedMenuItemId: $selectedMenuItemId)
        default:
            TabContentView(selectedMenuItemId: $selectedMenuItemId)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
