//
//  OnlineNews.swift
//  ReactiveTestBD
//
//  Created by Andrey Petrovskiy on 10/17/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
protocol OnlineNewsProtocol {
    func requsetNews(viewModel: NewsViewModel?)
}


class OnlineNews: OnlineNewsProtocol {
    func requsetNews(viewModel: NewsViewModel?) {
        
        let urlString = BaseURL.baseURL.rawValue
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                OperationQueue.main.addOperation { [weak self] in
                    let news = self?.decodeData(data: data)
                    news?.forEach({ (new) in
                        viewModel?.model.append(new)
                    })
                    
                }
            }
            }.resume()
    }
    
    func decodeData(data: Data) -> [News] {
        var news: [News] = []
        do{
            let onlineNews = try JSONDecoder().decode(NewsDecodable.self, from: data)
            onlineNews.articles.forEach { (articles) in
                news.append(News(title: articles.title, date: articles.publishedAt, description: articles.description, isOnline: 1))
            }
        } catch let err {
            news = [News(title: "", date: "", description: "Out of data", isOnline: 1)]
            print("can't decode", err)
        }
        return news
    }
    
}
