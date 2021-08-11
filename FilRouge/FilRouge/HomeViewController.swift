//
//  HomeViewController.swift
//  FilRouge
//
//  Created by Student05 on 15/06/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var pinkGuyImageView: UIImageView!
    @IBOutlet weak var bubleImage: UIImageView!
    @IBOutlet weak var bubleView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Accueil"
       setupView()
        setupCollectionView()
    }
    

    func setupView(){
        bubleView.layer.cornerRadius = 20
        bubleImage.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        pinkGuyImageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/4)
    }
    
    func setupCollectionView(){
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: "CustomCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        layout.itemSize = CGSize(width: 280, height: myCollectionView.layer.frame.height)
                myCollectionView.collectionViewLayout = layout
        myCollectionView.backgroundColor = .none
        
        }
    
 

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
        
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier:"CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        customCell.setupCell(index: indexPath.row)
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case  0 :
            tabBarController?.selectedIndex = 2
        case  1 :
            tabBarController?.selectedIndex = 1
            
        case  2 :
         
               
            tabBarController?.selectedIndex = 3
        default :
            print("error")
        }
        
        
    }
    
    
}


