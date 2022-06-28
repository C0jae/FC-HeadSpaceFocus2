//
//  QuickFocusCell.swift
//  HeadSpaceFocus
//
//  Created by 최영재 on 2022/06/27.
//

import UIKit

class QuickFocusCell: UICollectionViewCell {
   
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(_ item: QuickFocus) {
        thumbnailImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
}
