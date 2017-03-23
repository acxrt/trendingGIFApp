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


class TrendingGIFCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var colors = [UIColor.red, UIColor.blue, UIColor.gray, UIColor.green, UIColor.black]
    var gifs:[String] = []
    
    let marginBetweenGifs: CGFloat = 5.0
    
    var loadedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numberOfGifs = 1
        let apiKey = "dc6zaTOxFJmzC" // TODO: Request a Production Key
        loadTrendingGifsWith(limit: numberOfGifs, apiKey: apiKey)
        
    }
    
    
    // MARK: - UICollectionViewDataSource protocol
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return gifs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : gifCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gifCell", for: indexPath) as! gifCollectionViewCell
        
        let gif = UIImage.gif(url: gifs[indexPath.item])
        
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
        
        let urlString = "http://api.giphy.com/v1/gifs/trending?limit=\(limit)&api_key=\(apiKey)"
        
//        Alamofire.request(urlString, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//                
//                // TODO: populate gifs var with url from response
//                
//                for _ in 1...7 {
//                    self.gifs.append("http://media0.giphy.com/media/3oKIPkn074os2OhrOw/giphy-downsized.gif")
//                }
//                
//                self.collectionView?.reloadData()
//                
//            case .failure(let error):
//                print(error)
//            }
//        }
        
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
}
