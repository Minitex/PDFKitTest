//
//  SearchAsyncViewController.swift
//  PDFKitTest
//
//  Created by Vui Nguyen on 10/16/17.
//  Copyright © 2017 Sunfish Empire. All rights reserved.
//

import UIKit
import PDFKit

class SearchAsyncViewController: UITableViewController, PDFDocumentDelegate {

  var document: PDFDocument?
  var searchResults: [PDFSelection]?
  var searchResultsCount: Int?
  var searchTerm: String?
  var currentSelection: PDFSelection?

  let reuseIdentifier = "SearchAsyncResultCell"

  override func viewDidLoad() {
        super.viewDidLoad()

    if let document = document {
      document.delegate = self
    }

    if let searchResults = searchResults {
      print("searchResults: \(searchResults)")
    }

    if let searchTerm = searchTerm {
      print("searchTerm: \(searchTerm)")
      search()
    }

    // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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


    document?.beginFindString(searchTerm!, withOptions: [NSString.CompareOptions.caseInsensitive])

    /*
    print("keyword search")
    //searchResults = document?.findString(searchTerm!, withOptions: [NSString.CompareOptions.caseInsensitive]) as [PDFSelection]?
    print("search results: \(String(describing: searchResults)), count: \(String(describing: searchResults?.count))")
    for result in searchResults! {
      print("search result 1: pages:\(result.pages), string:\(String(describing: result.string)), attributedString:\(String(describing: result.attributedString))")
      print("search result 2: selectionsByLine[0]: \(result.selectionsByLine()[0])")
      print("search result 3: pages count: \(result.pages.count)")
      print("search result 4: bounds: \(result.bounds(for: result.pages[0]))\n")

      //print("search result 5: result string: \(String(describing: result.pages[0].string))")
    }
*/

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

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return searchResults!.count
  }


  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

    // Configure the cell...
    //cell.textLabel?.text = indexPath.row.description

    //cell.textLabel?.text = searchResults![indexPath.row].bounds(for: searchResults![indexPath.row].pages[0]).debugDescription
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

  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */

  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */

  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

   }
   */

  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */


  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "SaveCurrentSelection" {
      if let upcoming = segue.destination as? HomeViewController {
        upcoming.currentSelection = currentSelection
        print("going back to HomeViewController")
      }
    }
  }

}
