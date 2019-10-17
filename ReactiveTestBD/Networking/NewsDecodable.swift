//
//  NewsDecadable.swift
//  ReactiveTestBD
//
//  Created by Andrey Petrovskiy on 10/17/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
public enum BaseURL: String {
    case baseURL = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=0ad355d3a4194d9194a40c6efc42fc10"
}

struct NewsDecodable: Decodable {
    var articles: [Articles]
}

struct Articles: Decodable {
    var title: String
    var description: String
    var publishedAt: String
   
}
