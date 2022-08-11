//
//  GalleryCollectionViewCell.swift
//  Boomerang
//
//  Created by Egor Laba on 1.08.22.
//

import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var assetImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()    
    }
    
    func setup(image: UIImage?) {
        assetImageView.image = image
    }
}
