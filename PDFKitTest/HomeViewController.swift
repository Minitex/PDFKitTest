//
//  ViewController.swift
//  PDFKitTest
//
//  Created by Vui Nguyen on 9/22/17.
//  Copyright © 2017 Sunfish Empire. All rights reserved.
//

import UIKit
import PDFKit

class HomeViewController: UIViewController, PDFDocumentDelegate {

  var document: PDFDocument?
  var selectedOutline: PDFOutline?
  var selectedPage: PDFPage?
  let documentName: String = "FinancialAccounting"

  @IBOutlet weak var pdfView: PDFView?

  @IBAction func keywordSearch(_ sender: Any) {
    print("keyword search")
  }

  @IBAction func unwindWithSelectedPage(segue: UIStoryboardSegue) {
    print("unwindWithSelectedPage")

    if let thumbCollectionViewController = segue.source as? ThumbCollectionViewController {
      selectedPage = thumbCollectionViewController.selectedPage
      print("on page: \(String(describing: selectedPage))")
      pdfView?.go(to: selectedPage!)
    }

    if let tocViewController = segue.source as? TOCViewController {
      selectedPage = tocViewController.selectedPage
      print("on page: \(String(describing: selectedPage))")
      pdfView?.go(to: selectedPage!)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    if let documentURL = Bundle.main.url(forResource: documentName, withExtension: "pdf") {
      document = PDFDocument(url: documentURL)
      // Set delegate
      document?.delegate = self

      pdfView?.document = document
      pdfView?.autoScales = true
      pdfView?.backgroundColor = UIColor.lightGray
      pdfView?.usePageViewController(true, withViewOptions: nil)

      print("document metadata: \(String(describing: document?.documentAttributes))")
    }

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let identifier = segue.identifier else {
      return
    }

    if identifier == "ThumbCollectionSegue" {
      if let upcoming = segue.destination as? ThumbCollectionViewController {
        upcoming.document = document
        upcoming.title = "Thumbnails"
        print("going to the thumbnail collection")
      }
    }

    if identifier == "TOCSegue" {
      if let upcoming = segue.destination as? TOCViewController {
        upcoming.document = document
        upcoming.title = "Table of Contents"
        print("going to table of contents")
      }
    }

    if identifier == "AboutSegue" {
      if let upcoming = segue.destination as? AboutViewController {
        upcoming.document = document
        upcoming.title = "About This Book"
        print("going to About Page")
      }
    }
  }

}

