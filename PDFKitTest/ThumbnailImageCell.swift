//
//  ThumbnailImageCell.swift
//  PDFKitTest
//
//  Created by Vui Nguyen on 10/6/17.
//  Copyright © 2017 Sunfish Empire. All rights reserved.
//

import UIKit

class ThumbnailImageCell: UICollectionViewCell {
    
  @IBOutlet weak var imageView: UIImageView!

  override var isSelected: Bool {
    didSet {
      imageView.layer.borderWidth = isSelected ? 10 : 0
    }
  }

  // MARK: - View Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }

}
