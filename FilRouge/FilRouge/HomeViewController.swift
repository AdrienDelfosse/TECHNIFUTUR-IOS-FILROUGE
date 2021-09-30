//
//  HomeViewController.swift
//  FilRouge
//
//  Created by Student05 on 15/06/2021.
//

import UIKit

struct HomeItems {
    var image: UIImage?
    var label: String
    var redirectTab: Int
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var pager: UIPageControl!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var pinkGuyImageView: UIImageView!
    @IBOutlet weak var bubleImage: UIImageView!
    @IBOutlet weak var bubleView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    private var currentPage: Int = 0
    private var items: [HomeItems] = []
    private var collectionViewFlowLayout: UICollectionViewFlowLayout? {
        return self.myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Accueil"
        defineCells()
        setupView()
        setupCollectionView()
    }
    

    func setupView(){
        bubleView.layer.cornerRadius = 20
        bubleImage.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        pinkGuyImageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/4)
        pager.currentPageIndicatorTintColor = .pink
    }
    private func defineCells() {
        items.removeAll()
        
        items.append(HomeItems(image: UIImage(named: "bgWolf"),
                               label: "J'ai une faim d'loup !",
                               redirectTab: 1))
        items.append(HomeItems(image: UIImage(named: "bgClown"),
                               label: "Jsuis en dep !",
                               redirectTab: 2))
        items.append(HomeItems(image: UIImage(named: "bgTree"),
                               label: "Faut qu'jme bouge !",
                               redirectTab: 3))
        
        self.myCollectionView.reloadData()
    
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
    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewFlowLayout?.itemSize.width ?? 0
        let proportionalOffset = (collectionViewFlowLayout?.collectionView?.contentOffset.x ?? 0) / itemWidth
        let index = Int(round(proportionalOffset))
        let numberOfItems = myCollectionView.numberOfItems(inSection: 0)
        let safeIndex = max(0, min(numberOfItems - 1, index))
        return safeIndex
    }
    
 

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
        
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier:"CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        customCell.setupCell(with: items[indexPath.row])
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case  0 :
            tabBarController?.selectedIndex = 1
        case  1 :
            tabBarController?.selectedIndex = 2
            
        case  2 :
         
               
            tabBarController?.selectedIndex = 3
        default :
            print("error")
        }
        
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        
        // calculate where collectionView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()

        // scroll to item
        let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
        collectionViewFlowLayout?.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        //update pager
        self.pager.currentPage = indexPath.row
        self.currentPage = pager.currentPage
    }
    
    
    
}


