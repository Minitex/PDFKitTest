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
  var searchResults: [PDFSelection]?
  var currentSelection: PDFSelection?
  
  let documentName: String = "FinancialAccounting"

  //let searchTerm = "minnesota"
  let searchTerm = "graduate"

  @IBOutlet weak var pdfView: PDFView?

  @IBAction func asynchKeywordSearch(_ sender: Any) {
    print("asynchKeywordSearch!")

    //print("keyword search")

    if (document?.isFinding)! {
      document?.cancelFindString()
    }

    /*
    if searchResults == nil {
      searchResults = [PDFSelection]()
    }
 */

    document?.beginFindString(searchTerm, withOptions: [NSString.CompareOptions.caseInsensitive])
    /*
    searchResults = document?.findString(searchTerm, withOptions: [NSString.CompareOptions.caseInsensitive]) as [PDFSelection]?
    print("search results: \(String(describing: searchResults)), count: \(String(describing: searchResults?.count))")
    for result in searchResults! {
      print("search result 1: pages:\(result.pages), string:\(String(describing: result.string)), attributedString:\(String(describing: result.attributedString))")
      print("search result 2: selectionsByLine[0]: \(result.selectionsByLine()[0])")
      print("search result 3: pages count: \(result.pages.count)")
      print("search result 4: bounds: \(result.bounds(for: result.pages[0]))\n")
      print("search result 5: result string: \(String(describing: result.pages[0].string))")
    }
 */
  }

  @IBAction func unwindWithCurrentSelection(segue: UIStoryboardSegue) {
    print("unwindWithCurrentSelection")

    if let searchResultsViewController = segue.source as? SearchResultsViewController {
      currentSelection = searchResultsViewController.currentSelection
      currentSelection?.color = UIColor.yellow
      pdfView?.currentSelection = currentSelection
      pdfView?.scrollSelectionToVisible(nil)
    }
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

  // MARK: PDFDocumentDelegate
  func didMatchString(_ instance: PDFSelection) {
    print("found a match!")
    //searchResults?.append(instance)

    let result = instance

    print("search result 1: pages:\(result.pages), string:\(String(describing: result.string)), attributedString:\(String(describing: result.attributedString))")
    print("search result 2: selectionsByLine[0]: \(result.selectionsByLine()[0])")
    print("search result 3: pages count: \(result.pages.count)")
    print("search result 4: bounds: \(result.bounds(for: result.pages[0]))\n")
    print("search result 5: result string: \(String(describing: result.pages[0].string))")
    print("search result 6: result extend: \(String(describing: result.extendForLineBoundaries()))")
    //result.extendForLineBoundaries()
    print("search result 7: selectionsByLine[0]: \(result.selectionsByLine()[0])")


    //print("search result 6: result attriubtedString: \(String(describing: result.pages[0].attributedString))")

    //let pageString = result.pages[0].string
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

    if identifier == "SearchSegue" {
      if let upcoming = segue.destination as? SearchResultsViewController {
        upcoming.document = document
        upcoming.title = "Results for \"\(searchTerm)\""
        upcoming.searchTerm = searchTerm
        upcoming.searchResults = searchResults
        print("going to search results")
      }
    }

  }

}

