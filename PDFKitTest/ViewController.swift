//
//  ViewController.swift
//  PDFKitTest
//
//  Created by Vui Nguyen on 9/22/17.
//  Copyright © 2017 Sunfish Empire. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController, PDFDocumentDelegate {

  @IBOutlet weak var pdfView: PDFView?
  var documentName: String?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    documentName = "FinancialAccounting"
    
    if let documentURL = Bundle.main.url(forResource: documentName, withExtension: "pdf") {
      if let document = PDFDocument(url: documentURL) {
        // Center document on gray background
        pdfView?.autoScales = true
        pdfView?.backgroundColor = UIColor.lightGray
        pdfView?.usePageViewController(true, withViewOptions: nil)

        // 1. Set delegate
        document.delegate = self
        pdfView?.document = document

        tableOfContents(document)
      }
    }

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // start of table of contents
  func tableOfContents(_ document: PDFDocument) {
    if document.outlineRoot != nil {
    }
  }

}

