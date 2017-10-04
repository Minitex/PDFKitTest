//
//  OutlineViewController.swift
//  PDFKitTest
//
//  Created by Vui Nguyen on 9/26/17.
//  Copyright © 2017 Sunfish Empire. All rights reserved.
//

import UIKit
import PDFKit

class OutlineViewController: UIViewController, PDFDocumentDelegate {
  var document: PDFDocument?
  var outline: PDFOutline?

  var selectedOutline: PDFOutline?

  @IBOutlet weak var tocButton: UIButton!
  @IBOutlet weak var chapter6Button: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    if let document = document {
      document.delegate = self
      tableOfContents()
    }

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
    outline = document?.outlineRoot
    print(outline?.isOpen as Any)
    print(outline?.numberOfChildren as Any)
    var currentChild: PDFOutline?
    for index in 0...(outline?.numberOfChildren)! - 1 {
      currentChild = outline?.child(at: index)
      print("[\(index)]:\(String(describing: currentChild?.label))")
      print("\t[\(index)]:\(String(describing: currentChild?.destination?.page))")
      print("\t[\(index)]:\(String(describing: currentChild?.destination?.point))")
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let button = sender as? UIButton  else {
      return
    }
    if segue.identifier == "SaveSelectedOutline" {
      if button === tocButton {
        selectedOutline = outline?.child(at: 2)
      } else {
        selectedOutline = outline?.child(at: 9)
      }
    }
  }
}
