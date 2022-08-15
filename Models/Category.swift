//
//  Category.swift
//  News
//
//  Created by Ishaan Sharma on 7/19/2022.
//

import Foundation

enum Category: String, CaseIterable {
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
    
    var text: String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
    
    var systemImage: String {
        switch self {
        case .general:
            return "newspaper"
        case .business:
            return "building.2"
        case .technology:
            return "laptopcomputer.and.iphone"
        case .entertainment:
            return "tv"
        case .sports:
            return "bicycle"
        case .science:
            return "bolt.fill"
        case .health:
            return "cross.case.fill"
        }
    }
}

extension Category: Identifiable {
    var id: Self { self }
}
