//
//  AboutViewController.swift
//  PDFKitTest
//
//  Created by Vui Nguyen on 10/11/17.
//  Copyright © 2017 Sunfish Empire. All rights reserved.
//

import UIKit
import PDFKit

class AboutViewController: UIViewController, PDFDocumentDelegate {

  var document: PDFDocument?

  @IBOutlet weak var aboutLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    if let document = document {
      document.delegate = self

      var attributesString: String = ""
      for (keyString, valueString) in document.documentAttributes! {
        attributesString += keyString.description
        attributesString += " : "
        attributesString += valueString as! String
        attributesString += "\n"
      }
      print(attributesString)
      aboutLabel.text = attributesString
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
