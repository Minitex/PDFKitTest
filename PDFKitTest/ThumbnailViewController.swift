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
  var scrollView: UIScrollView?
  var pageCount: Int?
  
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
    displayPDF()

    let thumbnailRect = CGRect(x: 0, y: Int(self.uiView.frame.height) - 150, width:  Int(self.uiView.frame.width), height: 1000)
    let scrollViewRect = CGRect(x: 0, y: Int(self.uiView.frame.height) - 150, width: Int(self.uiView.frame.width), height: 150)

    pdfThumbnailView = PDFThumbnailView(frame: thumbnailRect)
    pdfThumbnailView?.pdfView = pdfView
    pdfThumbnailView?.thumbnailSize = CGSize(width: 70, height: 140)
    pdfThumbnailView?.layoutMode = .horizontal

    scrollView = UIScrollView.init(frame: scrollViewRect)
    scrollView?.contentSize = CGSize.init(width: thumbnailRect.width, height: thumbnailRect.height)

    scrollView?.addSubview(pdfThumbnailView!)
    self.uiView?.addSubview(scrollView!)
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
      pageCount = document.pageCount
      //pdfView.displayDirection = .horizontal

      self.uiView.addSubview(pdfView!)
      //self.view = pdfView
      print("set document success!")
      print("page count is: \(String(describing: pageCount))")
      } else {
      print("set document NOT successful!")
    }
  }
  
}
