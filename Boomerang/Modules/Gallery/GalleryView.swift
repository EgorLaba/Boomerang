//
//  GalleryView.swift
//  Boomerang
//
//  Created by Egor Laba on 28.06.22.
//

import UIKit

fileprivate struct Constants {
    static let videoViewCornerRadius: CGFloat = 10.0
    static let frameViewBorderWidth: CGFloat = 4.0
    static let frameViewCornerRadius: CGFloat = 6.0
}

final class GalleryView: UIView {
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    
    var frameView: UIView!
    var constraintWidth: NSLayoutConstraint!
    var constraintHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        configureUI()
        layout()
    }
                                            
    func setupCollectionView(with dataSource: UICollectionViewDataSource) {
        galleryCollectionView.dataSource = dataSource
    }
    
    func reloadData() {
        galleryCollectionView.reloadData()
    }
    
    private func configureUI() {
        videoView.layer.cornerRadius = Constants.videoViewCornerRadius
        videoView.layer.masksToBounds = true
        
        let frameView = UIView()
        frameView.backgroundColor = .clear
        frameView.layer.cornerRadius = Constants.frameViewCornerRadius
        frameView.layer.borderColor = UIColor.purple.cgColor
        frameView.translatesAutoresizingMaskIntoConstraints = false
        frameView.layer.borderWidth = Constants.frameViewBorderWidth
        
        self.frameView = frameView
        galleryCollectionView.addSubview(frameView)
    }
    
    private func setupCollectionView() {
        galleryCollectionView.register(GalleryCollectionViewCell.self)
        galleryCollectionView.showsHorizontalScrollIndicator = false
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        
        let cellWidth: CGFloat = 60.0
        let cellHeight: CGFloat = 60.0
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        flowLayout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        galleryCollectionView.collectionViewLayout = flowLayout
    }
    
    private func layout() {
        frameView.topAnchor.constraint(equalTo: galleryCollectionView.topAnchor).isActive = true
        frameView.bottomAnchor.constraint(equalTo: galleryCollectionView.bottomAnchor).isActive = true
        frameView.leftAnchor.constraint(equalTo: galleryCollectionView.leftAnchor).isActive = true
        
        constraintWidth = frameView.widthAnchor.constraint(equalToConstant: 60)
        constraintHeight = frameView.heightAnchor.constraint(equalToConstant: 60)
        constraintWidth.isActive = true
        constraintHeight.isActive = true
    }
}
