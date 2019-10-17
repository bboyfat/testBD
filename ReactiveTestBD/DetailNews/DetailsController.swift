//
//  DetailsController.swift
//  ReactiveTestBD
//
//  Created by Andrey Petrovskiy on 10/17/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

class DetailsController: UIViewController {

    @IBOutlet var detailsView: DetailsView!
    let disposeBag = DisposeBag()
    var news: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        btnAction()

    }

    func btnAction(){
       detailsView.createNewsBtn.reactive.controlEvents(.touchUpInside).observeNext {[weak self] (_) in
            self?.goToAddnews()
        }.dispose(in: disposeBag)
    }
    
    func goToAddnews(){
        let vc = UIStoryboard(name: "AddNewsScreen", bundle: nil).instantiateViewController(withIdentifier: "AddNewsScreen") as! AddNewsController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configView(){
        guard let news = news else { return }
        detailsView.dateLabel.text = news.date
        detailsView.titleLabel.text = news.title
        detailsView.detailsLabel.text = news.description
    }

 

}
