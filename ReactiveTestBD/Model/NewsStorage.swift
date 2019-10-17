//
//  NewsStorage.swift
//  ReactiveTestBD
//
//  Created by Andrey Petrovskiy on 10/16/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import RealmSwift

class RealmNews: Object {
    
    
    
    @objc dynamic var title: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var descriprion: String = ""
   
   
}

class Model {
    
    static let shared = Model()
    
    
    func fetch () -> Results<RealmNews>{
        let realm = try! Realm()
        return realm.objects(RealmNews.self)
    }
    
    
    func save(news: RealmNews) {
        let realm = try! Realm()
        do {
          try realm.write {
                realm.add(news)
            }
        } catch let saveErr{
            print("Can't Save obj", saveErr)
        }
    }
    
    
    private init () {}
}
