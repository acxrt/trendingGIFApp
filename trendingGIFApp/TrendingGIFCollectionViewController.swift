//
//  TrendingGIFCollectionViewController.swift
//  trendingGIFApp
//
//  Created by Aina Cuxart on 23/3/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation
import UIKit

class TrendingGIFCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var colors = [UIColor.red, UIColor.blue, UIColor.gray, UIColor.green, UIColor.black]
    
    let marginBetweenGifs: CGFloat = 5.0
    
    
    //MARK: - UICollectionViewDataSource protocol
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return gifs.count
        return colors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gifCell", for: indexPath)
        
        cell.backgroundColor = colors[indexPath.item]
        
        return cell
    }


    //MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let fixedLength = (view.frame.width - marginBetweenGifs*4) / 2
        
        return CGSize(width: fixedLength, height: fixedLength)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets{
        
        return UIEdgeInsets(top: marginBetweenGifs, left: marginBetweenGifs, bottom: marginBetweenGifs, right: marginBetweenGifs)
    }
}
