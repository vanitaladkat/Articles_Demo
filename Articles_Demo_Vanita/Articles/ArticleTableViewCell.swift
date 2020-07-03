//
//  ArticleTableViewCell.swift
//  Articles_Demo_Vanita
//
//  Created by Vanita Ladkat on 02/07/20.
//  Copyright © 2020 Vanita Ladkat. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var mediaImageViewHeightConstraint: NSLayoutConstraint!

    let viewModel = ArticleTableViewCellViewModel()
    private let mediaImageHeight: CGFloat = 200
    
    func configure() {
        let profileImageUrl = viewModel.profileImageUrl()
        profileImageView.setImage(from: profileImageUrl, placeHolder: nil) { (image) in }
        usernameLabel.text = viewModel.username()
        designationLabel.text = viewModel.designation()
        timeLabel.text = viewModel.time()
        let mediaImageUrl = viewModel.mediaImage()
        if mediaImageUrl.isEmpty {
            mediaImageViewHeightConstraint.constant = 0
        } else {
            mediaImageViewHeightConstraint.constant = mediaImageHeight
            mediaImageView.setImage(from: mediaImageUrl, placeHolder: nil) { (image) in
            }
        }

        contentLabel.text = viewModel.contents()
        titleLabel.text = viewModel.title()
        urlLabel.text = viewModel.articleUrl()
        likesLabel.text = viewModel.likes()
        commentsLabel.text = viewModel.comments()
    }
}
