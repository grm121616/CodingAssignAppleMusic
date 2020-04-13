//
//  ViewModelLoadImage.swift
//  CodingAssign
//
//  Created by Ruoming Gao on 4/11/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation
import UIKit

struct ViewModelLoadImage {
    let resultsContainer: ResultContainer
    
    init(resultsContainer: ResultContainer) {
        self.resultsContainer = resultsContainer
    }
    
    func getName() -> String {
        return resultsContainer.artistName
    }
    
    func getAlbumName() -> String {
        return resultsContainer.name
    }
    
    func getReleaseDate() -> String {
        return resultsContainer.releaseDate
    }
    
    func getCopyRights() -> String {
        return resultsContainer.copyright
    }
    
    func getGenre() -> String {
        return resultsContainer.genres[0].name
    }
    
    func getArtistUrl() -> String {
        return resultsContainer.artistUrl
    }
    
    func getImage(completion: @escaping(UIImage)->Void) {
        let url = resultsContainer.artworkUrl100
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data,
                let image = UIImage(data: data) else { return }
            completion(image)
        }.resume()
    }
}
