//
//  ThumbOutlineViewController.swift
//  PDFKitTest
//
//  Created by Vui Nguyen on 10/3/17.
//  Copyright © 2017 Sunfish Empire. All rights reserved.
//

import UIKit
import PDFKit

class ThumbManualViewController: UIViewController, PDFDocumentDelegate {

  @IBOutlet weak var imageView1: UIImageView!
  @IBOutlet weak var imageView2: UIImageView!
  
  var document: PDFDocument?
  var selectedPage: PDFPage?

  override func viewDidLoad() {
      super.viewDidLoad()

        // Do any additional setup after loading the view.
      if let document = document {
        document.delegate = self
        loadThumbnails()
        print("after loading thumbnails")
      }

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
    
  private func loadThumbnails() {
    let page4 = document?.page(at: 4)
    imageView1.image = page4?.thumbnail(of: CGSize(width: imageView1.frame.size.width, height: imageView1.frame.size.height), for: .cropBox)

    let page152 = document?.page(at: 152)
    imageView2.image = page152?.thumbnail(of: CGSize(width: imageView2.frame.size.width, height: imageView2.frame.size.height), for: .cropBox)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let gesture = sender as? UITapGestureRecognizer else {
      return
    }

    guard let image = gesture.view as? UIImageView  else {
      return
    }


    if segue.identifier == "SaveSelectedPage" {
      if image === imageView1 {
        selectedPage = document?.page(at: 4)
      } else {
        selectedPage = document?.page(at: 152)
      }
    }
  }

}
