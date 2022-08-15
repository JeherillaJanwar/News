//
//  NewsAPIResponse.swift
//  News
//
//  Created by Ishaan Sharma on 7/19/2022.
//


import Foundation

struct NewsAPIResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
    
}
