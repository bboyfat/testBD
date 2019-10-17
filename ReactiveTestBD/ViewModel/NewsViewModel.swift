//
//  NewsViewModel.swift
//  ReactiveTestBD
//
//  Created by Andrey Petrovskiy on 10/16/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import ReactiveKit
import Bond
import RealmSwift


class NewsViewModel {
    
    var model: MutableObservableArray<News>!
    var newsModel: Model?
    var notificationToken: NotificationToken? = nil
    
    init() {
        newsModel = Model.shared
        let newsItems = newsModel?.fetch()
        self.model = convertModel(realmModel: newsItems)
        checkChanges(with: newsItems)
    }
    
    func checkChanges(with results: Results<RealmNews>?) {
        notificationToken = results?.observe({ [weak self] (changes) in
            switch changes {
            case .initial:
                print("initial")
            case .update(_, _, _, _):
                self?.update(with: results)
            case .error(let err):
                print(err.localizedDescription)
            }
        })
    }
    
    func update(with results: Results<RealmNews>?){
        guard let results = results else { return }
        if results.count > 0{
            let new = News(title: results.last!.title, date: results.last!.date, description: results.last!.descriprion, isOnline: 0)
            self.model.append(new)
        }
    }
    
    func convertModel(realmModel: Results<RealmNews>?) -> MutableObservableArray<News> {
        var newsModel: [News] = []
        realmModel?.forEach({ (news) in
            let new: News = News(title: news.title, date: news.date, description: news.descriprion, isOnline: 0)
            newsModel.append(new)
        })
        return MutableObservableArray(newsModel)
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}
