//
//  SearchAsyncViewController.swift
//  PDFKitTest
//
//  Created by Vui Nguyen on 10/16/17.
//  Copyright © 2017 Sunfish Empire. All rights reserved.
//

import UIKit
import PDFKit

class SearchAsyncViewController: UITableViewController, PDFDocumentDelegate, UITextFieldDelegate {

  var document: PDFDocument?
  var searchResults: [PDFSelection]?
  var searchResultsCount: Int?
  var searchTerm: String?
  var currentSelection: PDFSelection?

  let reuseIdentifier = "SearchAsyncResultCell"

  @IBOutlet weak var searchBox: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()

    if let document = document {
      document.delegate = self
    }

    if searchResults != nil {
      self.tableView.reloadData()
    }

    if searchTerm != nil {
      searchBox.text = searchTerm
    }

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  func search() {
    if (document?.isFinding)! {
      document?.cancelFindString()
    }

    if searchResults == nil {
      searchResults = [PDFSelection]()
    }

    searchTerm = searchBox.text
    document?.beginFindString(searchTerm!, withOptions: [NSString.CompareOptions.caseInsensitive])
  }

  // MARK: PDFDocumentDelegate
  func didMatchString(_ instance: PDFSelection) {
    print("found a match!")
    searchResults?.append(instance)

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
    self.tableView.reloadData()
  }

  // MARK: - Textfield Delegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    print("pressed return!")

    guard !((textField.text?.isEmpty)!) else {
      return true
    }

    search()
    textField.resignFirstResponder()
    return true
  }

  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    searchResults = nil
    searchTerm = nil
    self.tableView.reloadData()
    return true
  }

  // MARK: - Table view data sourcemin

  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    if let searchResults = searchResults {
      print("searchResults: \(searchResults)")
      return searchResults.count
    }
    return 0
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

    searchResults![indexPath.row].extendForLineBoundaries()
    cell.textLabel?.text = searchResults![indexPath.row].selectionsByLine()[0].string
    cell.detailTextLabel?.text = "Page: \(String(describing: searchResults![indexPath.row].pages[0].label))"
    return cell
  }

  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    print("selected \(indexPath.row)")
    currentSelection = searchResults![indexPath.row]
    print("currentSelection is: \(String(describing: currentSelection))")
    return indexPath
  }

  // MARK: - Navigation
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "SaveCurrentSelection" {
      if let upcoming = segue.destination as? HomeViewController {
        upcoming.currentSelection = currentSelection
        upcoming.searchResults = searchResults
        upcoming.searchTerm = searchTerm
        print("going back to HomeViewController")
      }
    }
  }

}
