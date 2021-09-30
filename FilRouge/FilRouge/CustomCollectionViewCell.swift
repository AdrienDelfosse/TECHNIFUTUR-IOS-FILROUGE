//
//  CustomCollectionViewCell.swift
//  FilRouge
//
//  Created by Student08 on 11/08/2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardBackgroundView: UIImageView!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 30
        cardLabel.textColor = .middleBlue
    }
    
    func setupCell(with homeItem: HomeItems){
        cardImageView.image = homeItem.image
        cardLabel.text = homeItem.label
        
        
    }

}
