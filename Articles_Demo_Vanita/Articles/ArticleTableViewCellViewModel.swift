//
//  ArticleTableViewCellViewModel.swift
//  Articles_Demo_Vanita
//
//  Created by Vanita Ladkat on 02/07/20.
//  Copyright © 2020 Vanita Ladkat. All rights reserved.
//

import Foundation

class ArticleTableViewCellViewModel {
    var article: ArticlesModel?

    func profileImageUrl() -> String {
        return article?.user?.first?.avatar ?? ""
    }

    func username() -> String {
        return (article?.user?.first?.name ?? "") + " " + (article?.user?.first?.lastname ?? "")
    }

    func designation() -> String {
        return article?.user?.first?.designation ?? ""
    }

    func time() -> String {
        let currentDate = Date()
        let articleTime = article?.createdAt?.timeDifference(end: currentDate)
        return articleTime ?? ""
    }

    func mediaImage() -> String {
        return article?.media?.first?.image ?? ""
    }

    func contents() -> String {
        return article?.content ?? ""
    }

    func title() -> String {
        return article?.media?.first?.title ?? ""
    }

    func articleUrl() -> String {
        return article?.media?.first?.url ?? ""
    }

    func likes() -> String {
        return "\((article?.likes ?? 0).roundedWithAbbreviations)" + " Likes"
    }

    func comments() -> String {
        return "\((article?.comments ?? 0).roundedWithAbbreviations)" + " Comments"
    }
}
