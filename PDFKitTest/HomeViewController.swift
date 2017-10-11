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

  @IBOutlet weak var pdfView: PDFView?
  var documentName: String?
  var document: PDFDocument?
  var selectedOutline: PDFOutline?
  var selectedPage: PDFPage?
  
  @IBAction func keywordSearch(_ sender: Any) {
    print("keyword search")
  }

  @IBAction func unwindWithSelectedOutline(segue: UIStoryboardSegue) {
    print("unwindWithSelectedOutline")
    if let outlineViewController = segue.source as? OutlineViewController {
      selectedOutline = outlineViewController.selectedOutline
      print("selectedOutline: \(String(describing: selectedOutline?.description))")
      print("on page: \(String(describing: selectedOutline?.destination?.page))")

      pdfView?.go(to: (selectedOutline?.destination?.page)!)
      
    }
  }

  @IBAction func unwindWithSelectedPage(segue: UIStoryboardSegue) {
    print("unwindWithSelectedPage")
    if let thumbManualViewController = segue.source as? ThumbManualViewController {
      selectedPage = thumbManualViewController.selectedPage
      print("on page: \(String(describing: selectedPage))")
      pdfView?.go(to: selectedPage!)
    }
    
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

    documentName = "FinancialAccounting"
    if let documentURL = Bundle.main.url(forResource: documentName, withExtension: "pdf") {
        document = PDFDocument(url: documentURL)
        // Center document on gray background
        pdfView?.autoScales = true
        pdfView?.backgroundColor = UIColor.lightGray
        pdfView?.usePageViewController(true, withViewOptions: nil)

        // Set delegate
        document?.delegate = self
        pdfView?.document = document
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

    /*
     // OBE
    if identifier == "ThumbnailSegue" {
      //if let document = sender as? PDFDocument, // this doesn't work!
      if let upcoming = segue.destination as? ThumbnailViewController {
          upcoming.document = document
          upcoming.title = "Thumbnails"
          print("set document successfully!")
          print("going to thumbnails")
        }
      }
 */

    if identifier == "ThumbCollectionSegue" {
      if let upcoming = segue.destination as? ThumbCollectionViewController {
        upcoming.document = document
        upcoming.title = "Thumbnails"
        print("going to the thumbnail collection")
      }
    }

    if identifier == "OutlineSegue" {
      if let upcoming = segue.destination as? OutlineViewController {
        upcoming.document = document
        upcoming.title = "Outline"
        print("going to the outline")
      }
    }

    if identifier == "ThumbManualSegue" {
      if let upcoming = segue.destination as? ThumbManualViewController {
        upcoming.document = document
        upcoming.title = "Thumbnail Outline"
        print("going to the manual thumbnail outline")
      }
    }

    if identifier == "TOCSegue" {
      if let upcoming = segue.destination as? TOCViewController {
        upcoming.document = document
        upcoming.title = "Table of Contents"
        print("going to table of contents")
      }
    }
  }

}

