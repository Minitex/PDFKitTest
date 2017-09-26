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
    if let outline = document?.outlineRoot {
        print(outline.isOpen)
        print(outline.numberOfChildren)
        var currentChild: PDFOutline?
        for index in 0...outline.numberOfChildren - 1 {
          currentChild = outline.child(at: index)
          print(currentChild?.label ?? "No Child")
        }
      }
  }

}
