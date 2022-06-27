//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by 최영재 on 2022/06/27.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}
