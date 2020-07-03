//
//  DatabaseManager.swift
//  Articles_Demo_Vanita
//
//  Created by Vanita Ladkat on 03/07/20.
//  Copyright © 2020 Vanita Ladkat. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DatabaseManager {
    static let sharedInstance = DatabaseManager()
    private init() {}

    private func fetchArticles() -> [Article]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        let articles = try? context.fetch(request)
        return articles
    }

    func getLocalArticlesData() -> [[String: Any]] {
        var jsonArray: [[String: Any]] = []
        if let moArray = fetchArticles() {
            for item in moArray {
                var dict: [String: Any] = [:]
                for attribute in item.entity.attributesByName {
                    if let value = item.value(forKey: attribute.key) {
                        dict[attribute.key] = value
                    }
                }
                jsonArray.append(dict)
            }
        }
        return jsonArray
    }

    func deleteAllArticles() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext

        if let articles = fetchArticles() {
            articles.forEach { article in
                context.delete(article)
            }
        }
    }
    
}
