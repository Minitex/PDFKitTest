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
  //var pdfView: PDFView?
  //var pdfThumbnailView: PDFThumbnailView?
  //var scrollView: UIScrollView?
  var pageCount: Int?
  
  @IBOutlet weak var uiView: UIView!
  @IBOutlet weak var pdfView: PDFView!
  @IBOutlet weak var pdfThumbnailView: PDFThumbnailView!
 
  @IBAction func goToSelectedPage(_ sender: Any) {
    print(pdfThumbnailView?.selectedPages() ?? "No pages selected")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    //displayThumbnails()
    //displayPDF()
    displayThumbnails()

    //displayBottomView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func displayBottomView() {
    displayPDF()
  }

  func displayThumbnails() {
    displayPDF()


    //let thumbnailRect = CGRect(x: 0, y: Int(self.uiView.frame.height) - 150, width:  500, height: 1000)
    //let scrollViewRect = CGRect(x: 0, y: Int(self.uiView.frame.height) - 150, width: Int(self.uiView.frame.width), height: 150)

    //pdfThumbnailView = PDFThumbnailView(frame: thumbnailRect)
    pdfThumbnailView?.pdfView = pdfView
    //pdfThumbnailView?.contentInset.top = 0
    //pdfThumbnailView?.contentInset.bottom = 0
    pdfThumbnailView?.thumbnailSize = CGSize(width: 25, height: 50)
    pdfThumbnailView?.layoutMode = .horizontal

    var uicollectionview = pdfThumbnailView?.subviews[0] as! UICollectionView
    print(uicollectionview)

    print(pdfThumbnailView?.selectedPages() ?? "No pages selected")
    //uicollectionview.backgroundColor = UIColor.blue

    //scrollView = UIScrollView.init(frame: scrollViewRect)
    //scrollView?.contentSize = CGSize.init(width: thumbnailRect.width, height: thumbnailRect.height)

    //scrollView?.addSubview(pdfThumbnailView!)
    //self.uiView?.addSubview(scrollView!)
    //self.uiView?.addSubview(pdfThumbnailView!)

  }

  func displayPDF() {

    if let document = document {
      //let pdfRect = CGRect(x: 0, y: 0, width: Int(self.uiView.frame.width), height:Int(self.uiView.frame.height) - 150)
     // pdfView = PDFView(frame: pdfRect)
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
