//
//  GalleryViewController.swift
//  Boomerang
//
//  Created by Egor Laba on 28.06.22.
//

import UIKit

final class GalleryViewController: UIViewController {
    
    private let presenter = GalleryPresenter()
    private var galleryView: GalleryView { view as! GalleryView }
    
}
