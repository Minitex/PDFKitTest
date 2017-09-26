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
  var pdfView: PDFView?
  var pdfThumbnailView: PDFThumbnailView?
  
  @IBOutlet weak var uiView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    //displayThumbnails()
    //displayPDF()
    displayThumbnails()


  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func displayThumbnails() {
    let thumbnailRect = CGRect(x: 0, y: Int(self.uiView.frame.height) - 150, width: Int(self.uiView.frame.width), height: 150)
    pdfThumbnailView = PDFThumbnailView(frame: thumbnailRect)
    pdfThumbnailView?.thumbnailSize = CGSize(width: 25, height: 50)
    displayPDF()
    pdfThumbnailView?.pdfView = pdfView
    pdfThumbnailView?.layoutMode = .horizontal
    pdfView?.addSubview(pdfThumbnailView!)
  }

  func displayPDF() {

    if let document = document {
      let pdfRect = CGRect(x: 0, y: 0, width: Int(self.uiView.frame.width), height:Int(self.uiView.frame.height) - 150)
      pdfView = PDFView(frame: pdfRect)
      pdfView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
      pdfView?.autoScales = true
      pdfView?.usePageViewController(true, withViewOptions: nil)

      // 1. Set delegate
      document.delegate = self
      pdfView?.document = document
      //pdfView.displayDirection = .horizontal

      self.uiView.addSubview(pdfView!)
      //self.view = pdfView
      print("set document success!")
      } else {
      print("set document NOT successful!")
    }
  }
  
}
