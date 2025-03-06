//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 松居昴希 on 2025/02/27.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
       @IBOutlet weak var nextButton: UIButton!
       @IBOutlet weak var prevButton: UIButton!
       @IBOutlet weak var playPauseButton: UIButton!

       var images: [UIImage] = []
       var currentIndex = 0
       var timer: Timer?
       var isPlaying = false

       override func viewDidLoad() {
           super.viewDidLoad()
           
           // 画像をセット
           images = [
               UIImage(named: "image1.jpg") ?? UIImage(),
               UIImage(named: "image2.jpg") ?? UIImage(),
               UIImage(named: "image3.jpg") ?? UIImage()
           ]
           
           print("📷 images 配列の中身: \(images)")
           print("📷 currentIndex: \(currentIndex)")

           
           if UIImage(named: "image1.jpg") != nil {
               print("✅ image1 読み込み成功")
           } else {
               print("❌ image1 が見つかりません")
           }

           if UIImage(named: "image2.jpg") != nil {
               print("✅ image2 読み込み成功")
           } else {
               print("❌ image2 が見つかりません")
           }

           if UIImage(named: "image3.jpg") != nil {
               print("✅ image3 読み込み成功")
           } else {
               print("❌ image3 が見つかりません")
           }

           if imageView == nil {
               print("❌ imageView が nil です！")
           } else {
               print("✅ imageView は存在しています")
           }


           // 初期画像を設定
           imageView.image = images[currentIndex]
           
           // タップジェスチャー追加（拡大画面への遷移）
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
           imageView.addGestureRecognizer(tapGesture)
           imageView.isUserInteractionEnabled = true
       }

       // 進むボタン
       @IBAction func nextImage(_ sender: UIButton) {
           currentIndex = (currentIndex + 1) % images.count
           imageView.image = images[currentIndex]
       }

       // 戻るボタン
       @IBAction func prevImage(_ sender: UIButton) {
           currentIndex = (currentIndex - 1 + images.count) % images.count
           imageView.image = images[currentIndex]
       }

       // 再生・停止ボタン
       @IBAction func playPauseSlideshow(_ sender: UIButton) {
           if isPlaying {
               stopSlideshow()
           } else {
               startSlideshow()
           }
       }

       func startSlideshow() {
           isPlaying = true
           playPauseButton.setTitle("停止", for: .normal)
           nextButton.isEnabled = false
           prevButton.isEnabled = false

           timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
               self.nextImage(self.nextButton)
           }
       }

       func stopSlideshow() {
           isPlaying = false
           playPauseButton.setTitle("再生", for: .normal)
           nextButton.isEnabled = true
           prevButton.isEnabled = true

           timer?.invalidate()
           timer = nil
       }

       // 画像をタップしたら拡大画面へ遷移
       @objc func imageTapped() {
           let detailVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
           detailVC.selectedImage = images[currentIndex]
           detailVC.currentIndex = currentIndex
           detailVC.delegate = self
           present(detailVC, animated: true, completion: nil)
       }
   }

   // DetailViewController から現在の画像情報を受け取る
   extension ViewController: DetailViewDelegate {
       func updateImage(index: Int) {
           currentIndex = index
           imageView.image = images[currentIndex]
       }
       
       @IBAction func unwind(_ segue: UIStoryboardSegue) {
           }
   }

