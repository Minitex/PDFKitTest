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

  @IBAction func toggleThumbnails2(_ sender: Any) {
    print("toggle thumbnails1!")
  }

  @IBAction func toggleThumbnails(_ sender: Any) {
    print("toggle thumbnails2!")
    if let document = setPDFDocument() as PDFDocument? {
      performSegue(withIdentifier: "ThumbnailSegue", sender: document)
    }
  }
  
  @IBAction func toggleOutline(_ sender: Any) {
    print("toggle outline!")
    if let document = setPDFDocument() as PDFDocument? {
      performSegue(withIdentifier: "OutlineSegue", sender: document)
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    documentName = "FinancialAccounting"
    
    //if let documentURL = Bundle.main.url(forResource: documentName, withExtension: "pdf") {
   //  document = PDFDocument(url: documentURL)
    if let document = setPDFDocument() as PDFDocument? {
        // Center document on gray background
        pdfView?.autoScales = true
        pdfView?.backgroundColor = UIColor.lightGray
        pdfView?.usePageViewController(true, withViewOptions: nil)

        // 1. Set delegate
        document.delegate = self
        pdfView?.document = document

         //performSegue(withIdentifier: "OutlineSegue", sender: document)
        //tableOfContents(document)
      //}
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

  // start of table of contents
  func tableOfContents(_ document: PDFDocument) {
    if document.outlineRoot != nil {
    }
  }

  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let identifier = segue.identifier else {
      return
    }


    if identifier == "ThumbnailSegue" || identifier == "OutlineSegue" {
      //if let document = sender as? PDFDocument, // this doesn't work!
      if let document = setPDFDocument(),
         let upcoming = segue.destination as? ThumbnailViewController {
        upcoming.document = document
        upcoming.title = "Thumbnails"
        print("set document successfully!")
      } else {
        print("set document was NOT successful!")
      }
    }

  }
    
}

