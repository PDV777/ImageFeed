//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Dmitry on 05.03.2024.
//

import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage? {
        didSet {
            guard isViewLoaded else { return } // 1
            imageView.image = image // 2
        }
    }
        @IBOutlet var imageView: UIImageView!
        
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
            super.viewDidLoad()
            imageView.image = image
        }
    }

