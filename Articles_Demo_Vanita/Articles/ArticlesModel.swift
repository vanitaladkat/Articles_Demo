//
//  ArticlesModel.swift
//  Articles_Demo_Vanita
//
//  Created by Vanita Ladkat on 02/07/20.
//  Copyright © 2020 Vanita Ladkat. All rights reserved.
//

import Foundation
import ObjectMapper

struct ArticlesModel: Mappable {
    var content: String?
    var comments: Int?
    var likes: Int?
    var media: [Media]?
    var user: [User]?
    var createdAt: String?

    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        content <- map["content"]
        comments <- map["comments"]
        likes <- map["likes"]
        media <- map["media"]
        user <- map["user"]
        createdAt <- map["createdAt"]
    }
}

struct Media: Mappable {
    var image: String?
    var url: String?
    var title: String?

    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        image <- map["image"]
        url <- map["url"]
        title <- map["title"]
    }
}

struct User: Mappable {
    var name: String?
    var lastname: String?
    var designation: String?
    var avatar: String?

    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        name <- map["name"]
        lastname <- map["lastname"]
        designation <- map["designation"]
        avatar <- map["avatar"]
    }
}

