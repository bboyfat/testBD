//
//  AddNewsController.swift
//  ReactiveTestBD
//
//  Created by Andrey Petrovskiy on 10/16/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

class AddNewsController: UIViewController {

    @IBOutlet var addNewsView: AddNewsView!
    var savedPressed: Disposable!
    var disposeBag = DisposeBag()
    var vieModel: NewsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vieModel = NewsViewModel()
        btnAction()
    }
    
    
    func btnAction() {
        addNewsView.addNewsButton.reactive.controlEvents(.touchUpInside).observeNext { (_) in
            self.save()
            self.navigationController?.popToRootViewController(animated: true)
            }.dispose(in: disposeBag)
    }
    
    func save() {
        let news = RealmNews()
        
        news.date = prepareData().date
        news.descriprion = prepareData().description
        news.title = prepareData().title
        
        vieModel?.newsModel?.save(news: news)
    }
    
    private func prepareData() ->(title: String, date: String, description: String){
        
        let title = addNewsView.titileTextField.text ?? ""
        let description = addNewsView.descriptionTextView.text ?? "Out of data"
        let date =  addNewsView.dateTextField.text ?? ""
        
        return (title, date, description)
    }

}
