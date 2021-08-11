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
        
    }
    
    func setupCell(index : Int){
        switch index {
        case  0 :
            cardImageView.image = UIImage(named: "bgClown")
            cardLabel.text = "Je m'ennuie Distrais-moi !"
        case  1 :
            cardImageView.image = UIImage(named: "bgWolf")
            cardLabel.text = "J'ai une faim de loup"
        case  2 :
            cardImageView.image = UIImage(named: "bgTree")
            cardLabel.text = "De l'air ! Vite ! Il faut que je bouge !"
            
        default :
            print("error")
        }
    }

}
