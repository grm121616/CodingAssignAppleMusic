//
//  ViewModel.swift
//  CodingAssign
//
//  Created by Ruoming Gao on 4/10/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import Foundation

class ViewModel: ViewModelProtocol{
    
    var results: [ResultContainer] = [] {
        didSet {
            updateCallBack()
        }
    }
    
    var updateCallBack: ()->Void
    
    init(updateCallBack: @escaping ()->Void) {
        self.updateCallBack = updateCallBack
    }
    
    func loadData() {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            guard let jsonObject = try? JSONDecoder().decode(MusicStruct.self, from: data) else { return }
            self.results = jsonObject.feed.results
        }.resume()
    }
    
    func getResult() -> [ResultContainer] {
        return results
    }
    
    func getCount() -> Int {
        return results.count
    }
    
    func getViewModelImage(index: Int) -> ViewModelLoadImage {
        return ViewModelLoadImage(resultsContainer: results[index])
    }
}

protocol ViewModelProtocol {
    var updateCallBack: ()-> Void{ get set }
    func loadData()
    func getResult() -> [ResultContainer]
    func getCount() -> Int
    func getViewModelImage(index: Int) -> ViewModelLoadImage
}
