//
//  GalleryViewController.swift
//  Boomerang
//
//  Created by Egor Laba on 28.06.22.
//

import UIKit
import PhotosUI
import AVFoundation

final class GalleryViewController: UIViewController {
    
    private let presenter = GalleryPresenter()
    private var galleryView: GalleryView { view as! GalleryView }
    
    @IBOutlet weak var addFrameButton: UIButton!
    @IBOutlet weak var deleteFrameButton: UIButton!
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
    var stepCount = 1
    
    let videoURL: URL! = Bundle.main.url(forResource: "sample", withExtension: "mp4")
    
    private var generator: AVAssetImageGenerator!
    private var asset: AVAsset!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Permission(viewController: self).checkCameraAvailability()
        //        presentPhotoLibrary()
        
        asset = AVAsset(url: self.videoURL)
        generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        galleryView.setupCollectionView(with: self)
        
        if stepCount != 0  { deleteFrameButton.isEnabled = false }
        galleryView.timeLabel.text = "\(stepCount) s"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        preparePlayer()
    }
    
    private func preparePlayer() {
        let playerItem = AVPlayerItem(url: videoURL)
        let player = AVQueuePlayer(playerItem: playerItem)
        
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = self.galleryView.videoView.bounds
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        self.galleryView.videoView.layer.addSublayer(playerLayer)
        
        player.play()
    }
    
    private func getFrame(time: TimeInterval) -> UIImage? {
        let duration = CMTimeGetSeconds(asset.duration)
        
        if time >= duration { return nil }
        let time = CMTime(seconds: time, preferredTimescale: 60)
        
        guard let image = try? self.generator.copyCGImage(at: time, actualTime: nil) else { return nil }
        
        return UIImage(cgImage: image)
    }
    
    @IBAction private func tapDeleteFrame(_ sender: Any) {
        stepCount -= 1
        galleryView.constraintWidth.constant = galleryView.frameView.frame.size.width - galleryView.galleryCollectionView.frame.size.height
        galleryView.timeLabel.text = "\(stepCount) s"
        
        stepCount <= 1 ? (deleteFrameButton.isEnabled = false) : (addFrameButton.isEnabled = true)
    }
    
    @IBAction private func tapAddFrame(_ sender: Any) {
        stepCount += 1
        galleryView.constraintWidth.constant = galleryView.frameView.frame.size.width + galleryView.galleryCollectionView.frame.size.height
        galleryView.timeLabel.text = "\(stepCount) s"

        stepCount >= 5 ? (addFrameButton.isEnabled = false) : (deleteFrameButton.isEnabled = true)
    }
}


extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(CMTimeGetSeconds(asset.duration))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: GalleryCollectionViewCell.self, for: indexPath)
        
        let frame = getFrame(time: TimeInterval(indexPath.row))
        cell.setup(image: frame)
        
        return cell
    }
}
















































//    func presentPhotoLibrary() {
//        var pickerConfig = PHPickerConfiguration()
//        pickerConfig.filter = .videos
//        let videoPicker = PHPickerViewController(configuration: pickerConfig)
//        videoPicker.delegate = self
//        self.present(videoPicker, animated: true, completion: nil)
//    }
//}

//extension GalleryViewController: PHPickerViewControllerDelegate {
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        picker.dismiss(animated: true)
//
//        guard let itemProvider = results.first?.itemProvider else { return }
//        itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { url, error in
//
//            if let url = url {
//                let fileName = "\(Int(Date().timeIntervalSince1970)).\(url.pathExtension)"
//                let newURL = URL(fileURLWithPath: NSTemporaryDirectory() + fileName)
//                try? FileManager.default.copyItem(at: url, to: newURL)
//
//                DispatchQueue.main.async {
//
//                    let player = AVPlayer(url: newURL)
//                    let playerLayer = AVPlayerLayer(player: player)
//                    self.presenter.videoURL = url
//                    playerLayer.videoGravity = .resizeAspectFill
//                    playerLayer.frame = self.galleryView.videoView.bounds
//                    self.galleryView.videoView.layer.addSublayer(playerLayer)
//                    player.play()
//                }
//            }
//        }
//    }



    
