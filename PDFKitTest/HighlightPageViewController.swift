//
//  HighlightPageViewController.swift
//  PDFKitTest
//
//  Created by Vui Nguyen on 10/17/17.
//  Copyright © 2017 Sunfish Empire. All rights reserved.
//

import UIKit
import PDFKit

class HighlightPageViewController: UIViewController, PDFDocumentDelegate {

  var document: PDFDocument?
  var highlightedPage: PDFPage?

  @IBOutlet weak var pdfView: PDFView!
  

  override func viewDidLoad() {
    super.viewDidLoad()

    if let document = document {
      // Set delegate
      document.delegate = self

      pdfView?.document = document
      pdfView?.autoScales = true
      pdfView?.backgroundColor = UIColor.lightGray
      pdfView?.usePageViewController(true, withViewOptions: nil)

      if let highlightedPage = highlightedPage {


        let bounds = CGRect(x:244.1196, y:362.9197, width:37.829, height:12.177)
        let highlight = PDFAnnotation(bounds: bounds,
                                      forType: PDFAnnotationSubtype.highlight,
                                      withProperties: nil)

        highlight.color = UIColor.yellow

        highlightedPage.addAnnotation(highlight)
        highlightedPage.displaysAnnotations = true
        pdfView?.go(to: highlightedPage)

    }
    print("document metadata: \(String(describing: document.documentAttributes))")
  }

    // Do any additional setup after loading the view.
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
