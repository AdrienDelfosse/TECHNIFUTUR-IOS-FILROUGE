//
//  JokeTableViewCell.swift
//  FilRouge
//
//  Created by Student08 on 31/08/2021.
//

import UIKit

class JokeTableViewCell: UITableViewCell {


    @IBOutlet weak var cellContainerTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var JokeLabel: UILabel!
    
    var index : Int  = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .blueGrey
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
        JokeLabel.numberOfLines = 0
        JokeLabel.font = UIFont.boldSystemFont(ofSize: 28)
        JokeLabel.textColor = .middleBlue

        cellContainerTopAnchor.constant = 0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupTableView(joke : Joke, index : Int){
        self.index = index
        JokeLabel.text = joke.joke
        

        
        if index == 0 {
            self.showGuy()
        } else {
            self.hideGuy()
        }
    }
    
    
    private func showGuy() {
        cellContainerTopAnchor.constant = 60
        layoutIfNeeded()
    }

    private func hideGuy() {
        cellContainerTopAnchor.constant = 0
        layoutIfNeeded()
    }
    
}
