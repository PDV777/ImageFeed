//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Dmitry on 01.03.2024.
//

import UIKit

final class ImagesListCell:UITableViewCell {
    
    static let reuseIdentifier = "ImagesListCell"
    
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
}

