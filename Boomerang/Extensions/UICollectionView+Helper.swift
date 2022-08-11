//
//  UICollectionView+Helper.swift
//  Boomerang
//
//  Created by Egor Laba on 1.08.22.
//

import UIKit

extension UICollectionView {
    
    func register(_ cellType: UICollectionViewCell.Type, for reuseIdentifier: String? = nil) {
        let reuseIdentifier = reuseIdentifier ?? cellType.reuseIdentifier
        let nib = UINib(nibName: String(describing: cellType), bundle: .main)
        
        register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for cell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath) as! T
    }
}
