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
  //var document: PDFDocument?
  
  @IBAction func keywordSearch(_ sender: Any) {
    print("keyword search")
  }

  @IBAction func toggleThumbnails(_ sender: Any) {
    print("toggle thumbnails!")
    performSegue(withIdentifier: "ThumbnailSegue", sender: nil)
  }

  @IBAction func toggleOutline(_ sender: Any) {
    print("toggle outline!")
    performSegue(withIdentifier: "OutlineSegue", sender: nil)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    documentName = "FinancialAccounting"

    if let document = setPDFDocument() as PDFDocument? {
        // Center document on gray background
        pdfView?.autoScales = true
        pdfView?.backgroundColor = UIColor.lightGray
        pdfView?.usePageViewController(true, withViewOptions: nil)

        // Set delegate
        document.delegate = self
        pdfView?.document = document
    }

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func setPDFDocument() -> PDFDocument? {
    var document: PDFDocument?
    if let documentURL = Bundle.main.url(forResource: documentName, withExtension: "pdf") {
       document = PDFDocument(url: documentURL)
      return document!
    }
    return document!
  }

  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let identifier = segue.identifier else {
      return
    }


    let document = setPDFDocument()

    if identifier == "ThumbnailSegue" {
      //if let document = sender as? PDFDocument, // this doesn't work!
      if   let upcoming = segue.destination as? ThumbnailViewController {
          upcoming.document = document
          upcoming.title = "Thumbnails"
          print("set document successfully!")
        }
      } else if identifier == "OutlineSegue" {
      if     let upcoming = segue.destination as? OutlineViewController {
            upcoming.document = document
            upcoming.title = "Outline"
            print("going to the outline")
        }
      }

    }


}

