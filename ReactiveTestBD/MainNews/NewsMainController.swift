//
//  ViewController.swift
//  ReactiveTestBD
//
//  Created by Andrey Petrovskiy on 10/16/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import ReactiveKit
import Bond

class NewsMainController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    var viewModel: NewsViewModel!
    let disposeBag = DisposeBag()
    var onlioneNews: OnlineNewsProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onlioneNews = OnlineNews()
        viewModel = NewsViewModel()
        onlioneNews.requsetNews(viewModel: self.viewModel)
        registerNib()
        bindToTableView()
        onCellTApped()
        tableViewDidScrolled()
        
    }
    
    func registerNib() {
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: "newsCell")
    }
    
    
    
    @IBAction func goToAddNewScreen(_ sender: Any) {
        let vc = UIStoryboard(name: "AddNewsScreen", bundle: nil).instantiateViewController(withIdentifier: "AddNewsScreen") as! AddNewsController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension NewsMainController: CellConfigurer {
    
    func setupCell(cell: NewsCellProtocol, with data: News) {
        cell.dateLabel.text = data.date
        cell.descriptionLabel.text = data.description
        cell.titleLabel.text = data.title
        cell.contentView.backgroundColor = getCellsColor(withInt: data.isOnline)
    }
    private func getCellsColor(withInt: Int) -> UIColor {
        switch withInt{
        case 1:
            return  #colorLiteral(red: 0.1744262874, green: 0.9389173985, blue: 1, alpha: 1)
        case 0:
            return  #colorLiteral(red: 0.0386101231, green: 0.8220543265, blue: 0.5023989081, alpha: 1)
        default:
            return  .orange
        }
    }
}


//MARK: Reactive block

extension NewsMainController {
    
    func  tableViewDidScrolled() {
        newsTableView.reactive.swipeGesture(numberOfTouches: 1, direction: .down).observeNext { [weak self] (swipe) in
            self?.onlioneNews.requsetNews(viewModel: self?.viewModel)
            }.dispose(in: disposeBag)
    }
    
    func onCellTApped() {
        newsTableView.reactive.selectedRowIndexPath.observeNext { [weak self] (indexPath) in
            let cell = self?.newsTableView.cellForRow(at: indexPath) as! NewsCell
            let news = News(title: cell.titleLabel!.text!, date: cell.dateLabel!.text!, description: cell.descriptionLabel!.text!, isOnline: 0)
            let vc = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "DetailsScreen") as! DetailsController
            vc.news = news
            self?.navigationController?.pushViewController(vc, animated: true)
            }.dispose(in: disposeBag)
    }
    
    func bindToTableView() {
        _ = viewModel.model.observeNext(with: { (_) in
            self.viewModel.model.sortedCollection(by: { (news1, news2) -> Bool in
                news1.isOnline <  news2.isOnline }).bind(to: self.newsTableView, animated: false, rowAnimation: .none) { [weak self] (news, indexPath, tableView) -> UITableViewCell in
                    let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
                    self?.setupCell(cell: cell, with: news[indexPath.row])
                    return cell
            }
        }).dispose(in: disposeBag)
        
    }
}
