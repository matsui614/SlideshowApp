//
//  DetailViewController.swift
//  SlideshowApp
//
//  Created by 松居昴希 on 2025/03/03.
//


import UIKit

protocol DetailViewDelegate: AnyObject {
    func updateImage(index: Int)
}

class DetailViewController: UIViewController {

        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var backButton: UIButton!

        var selectedImage: UIImage?
        var currentIndex: Int = 0
        weak var delegate: DetailViewDelegate?

        override func viewDidLoad() {
            super.viewDidLoad()

            // 画像を設定
            imageView.image = selectedImage
        }
    

        // 戻るボタン
        @IBAction func goBack(_ sender: UIButton) {
            delegate?.updateImage(index: currentIndex)
            dismiss(animated: true, completion: nil)
        }
    }


