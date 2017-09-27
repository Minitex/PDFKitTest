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
  var document: PDFDocument?
  var currentOutline: PDFOutline?
  
  @IBAction func keywordSearch(_ sender: Any) {
    print("keyword search")
  }

  @IBAction func goToTableOfContents(_ segue: UIStoryboardSegue) {
    print("to back and display the table of contents")
   // selectedTOCIndex = 2 // official Table of Contents page
    // receive the "outline" for table of contents page and then go to that page in the PDF
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

    if identifier == "ThumbnailSegue" {
      //if let document = sender as? PDFDocument, // this doesn't work!
      if   let upcoming = segue.destination as? ThumbnailViewController {
          upcoming.document = document
          upcoming.title = "Thumbnails"
          print("set document successfully!")
          print("going to thumbnails")
        }
      }

    if identifier == "OutlineSegue" {
      if     let upcoming = segue.destination as? OutlineViewController {
            upcoming.document = document
            upcoming.title = "Outline"
            print("going to the outline")
        }
      }

    }


}

