//
//  JokeTableViewCell.swift
//  FilRouge
//
//  Created by Student08 on 31/08/2021.
//

import UIKit

class JokeTableViewCell: UITableViewCell {


    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var JokeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .blueGrey
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupTableView(joke : Joke){
        JokeLabel.text = joke.joke
    }
    
}
