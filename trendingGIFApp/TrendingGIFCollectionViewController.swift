//
//  TrendingGIFCollectionViewController.swift
//  trendingGIFApp
//
//  Created by Aina Cuxart on 23/3/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation
import UIKit

import Alamofire


class TrendingGIFCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var colors = [UIColor.red, UIColor.blue, UIColor.gray, UIColor.green, UIColor.black]
    
    let marginBetweenGifs: CGFloat = 5.0
    
    var loadedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numberOfGifs = 20
        loadTrendingGifs(limit: numberOfGifs)
        
    }
    
    
    // MARK: - UICollectionViewDataSource protocol
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return gifs.count
        return colors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : gifCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gifCell", for: indexPath) as! gifCollectionViewCell
        
        
        if let url = NSURL(string: "http://media0.giphy.com/media/3oKIPkn074os2OhrOw/giphy-downsized.gif") {
            if let data = NSData(contentsOf: url as URL) {
                cell.gifImageView.image = UIImage(data: data as Data)
            }        
        }
        
        
        return cell
    }


    // MARK: - UICollectionViewDelegate protocol
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
    
    
    // MARK: - Load trending GIFs from API
    func loadTrendingGifs(limit: Int) {
        
        Alamofire.request("http://api.giphy.com/v1/gifs/trending?limit=\(limit)&api_key=dc6zaTOxFJmzC").responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
//            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
        
    }
    
}
