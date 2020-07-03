//
//  ArticlesViewModel.swift
//  Articles_Demo_Vanita
//
//  Created by Vanita Ladkat on 02/07/20.
//  Copyright © 2020 Vanita Ladkat. All rights reserved.
//

import Foundation
import ObjectMapper

class ArticlesViewModel {
    let limit = 10
    private var articles: [ArticlesModel] = []
    private var fetchedAllData = false // to aovid unnecessary hits for all fetched data and user scroll down to all articles
    
    func isAllDataFetched() -> Bool {
        return fetchedAllData
    }

    func numberOfRows() -> Int {
        return articles.count
    }

    func article(at index: Int) -> ArticlesModel? {
        if index < articles.count {
            return articles[index]
        }
        return nil
    }

    private var isDataFetchingInProgress = false  //this will avoid subsequent api calls in case of previous api is in still progresss
    func fetchArticles(completion: @escaping DataParsedCompletion) {
        guard fetchedAllData == false, isDataFetchingInProgress == false else {
            completion(true, nil)
            return
        }
        isDataFetchingInProgress = true
        let url = WebAPI.articles
        let pageNumber = articles.count / limit + 1
        let params: [String: Any] = ["page": pageNumber,
                                     "limit": limit]
        NetworkManager.sharedInstance.sendNetworkRequest(urlStr: url, httpMethod: .get, parameters: params) { [weak self] (success, json, error) in
            self?.isDataFetchingInProgress = false  //data received now
            guard success == true,
                  json != nil,
                  error == nil else {
                completion(false, error)
                return
            }
            if let parsedData = Mapper<ArticlesModel>().mapArray(JSONObject: json) {
                if parsedData.isEmpty {
                    self?.fetchedAllData = true
                }
                self?.articles += parsedData
            }
            completion(true, error)
        }
    }
}
