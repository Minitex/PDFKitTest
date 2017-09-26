//
//  ThumbnailViewController.swift
//  PDFKitTest
//
//  Created by Vui Nguyen on 9/25/17.
//  Copyright © 2017 Sunfish Empire. All rights reserved.
//

import UIKit
import PDFKit

class ThumbnailViewController: UIViewController, PDFDocumentDelegate {

  var document: PDFDocument?

  @IBOutlet weak var pdfView: PDFView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.



  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func displayThumbnails() {

  }

  func displayPDF() {

    if let document = document {
      pdfView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
      pdfView.autoScales = true
      pdfView?.usePageViewController(true, withViewOptions: nil)

      // 1. Set delegate
      document.delegate = self
      pdfView?.document = document
      //pdfView.displayDirection = .horizontal
      print("set document success!")
      } else {
      print("set document NOT successful!")
    }
  }
  
}
