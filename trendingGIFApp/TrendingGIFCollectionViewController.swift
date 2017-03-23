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
import SwiftGifOrigin
import SwiftyJSON

class TrendingGIFCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var gifs:[UIImage] = []
    let marginBetweenGifs: CGFloat = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numberOfGifs = 20
        let apiKey = "dc6zaTOxFJmzC" // TODO: Request a Production Key
        loadTrendingGifsWith(limit: numberOfGifs, apiKey: apiKey)
        
    }
    
    
    // MARK: - UICollectionViewDataSource protocol
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return gifs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : gifCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gifCell", for: indexPath) as! gifCollectionViewCell
        
        //let gif = UIImage.gif(url: gifs[indexPath.item])
        let gif = gifs[indexPath.item]
        
        cell.gifImageView.image = gif
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
    func loadTrendingGifsWith(limit: Int, apiKey: String) {
        
        let requestUrlString = "http://api.giphy.com/v1/gifs/trending?limit=\(limit)&api_key=\(apiKey)"
        
        Alamofire.request(requestUrlString, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                for index in 0..<json["data"].arrayValue.count {
                    
                    let gifUrlString = json["data"].arrayValue[index]["images"]["original"]["url"].stringValue
                    
                    // TODO: Make sure that the string is not nil
                    guard gifUrlString != nil else {continue}
                    
                    if let gifInImageFormat = UIImage.gif(url: gifUrlString) {
                        self.gifs.append(gifInImageFormat)
                    }
                }
                
                self.collectionView?.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
