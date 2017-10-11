//
//  TOCViewController.swift
//  PDFKitTest
//
//  Created by Vui Nguyen on 10/11/17.
//  Copyright © 2017 Sunfish Empire. All rights reserved.
//

import UIKit
import PDFKit

class TOCViewController: UITableViewController, PDFDocumentDelegate {

  var document: PDFDocument?
  var selectedPage: PDFPage?
  var selectedChapter: PDFOutline?
  var chapters = [PDFOutline]()
  var chapterCount: Int?

  let reuseIdentifier = "TOCCell"

  override func viewDidLoad() {
    super.viewDidLoad()

    if let document = document {
      document.delegate = self
      tableOfContents()
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

  func tableOfContents() {
    guard document?.outlineRoot != nil else {
      print("document outline doesn't exist!")
      return
    }
    let outline = document?.outlineRoot
    print(outline?.isOpen as Any)
    print(outline?.numberOfChildren as Any)

    chapterCount = outline?.numberOfChildren
    for index in 0...(chapterCount)! - 1 {

      chapters.append((outline?.child(at: index))!)

      print("[\(index)]:\(String(describing: chapters[index].label))")
      print("\t[\(index)]:\(String(describing: chapters[index].destination?.page))")
      print("\t[\(index)]:\(String(describing: chapters[index].destination?.point))")
    }
  }
  
  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return chapterCount!
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

    // Configure the cell...
    //cell.textLabel?.text = indexPath.row.description

    cell.textLabel?.text = chapters[indexPath.row].label
    return cell
  }

  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    print("selected \(indexPath.row)")
    selectedChapter = chapters[indexPath.row]
    selectedPage = selectedChapter?.destination?.page
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
      if segue.identifier == "SaveSelectedPage" {
        if let upcoming = segue.destination as? HomeViewController {
          upcoming.selectedPage = selectedPage
          print("going back to HomeViewController")
        }
      }
    }
    

}
