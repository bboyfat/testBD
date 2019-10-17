//
//  NewsCell.swift
//  ReactiveTestBD
//
//  Created by Andrey Petrovskiy on 10/16/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

protocol CellConfigurer {
    
    func setupCell(cell: NewsCellProtocol, with data: News)
    
}
protocol NewsCellProtocol: UITableViewCell {
     var dateLabel: UILabel! {get set}
     var descriptionLabel: UILabel! {get set}
     var titleLabel: UILabel! {get set}
}
class NewsCell:  UITableViewCell, NewsCellProtocol {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
