//
//  EatTableViewCell.swift
//  FilRouge
//
//  Created by Student08 on 01/09/2021.
//

import UIKit
import AlamofireImage
import Alamofire



class EatTableViewCell: UITableViewCell {
    @IBOutlet var foodImageView: UIImageView!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var containerView: UIView!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.backgroundColor = .blueGrey
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
    func setupCell(business : Business){
        typeLabel.text = business.categories[0].title
        typeLabel.textColor = .coral
        cityLabel.text = business.location.city
        distanceLabel.text = String(format: "%.1f", business.distance/1000) + " km"
        distanceLabel.textColor = .aquamarine
        nameLabel.text = business.name
        
        foodImageView.af.setImage(withURL: URL(string: business.imageUrl!)!)
        
        
    }
}
