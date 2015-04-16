//
//  PageItemController.swift
//  Paging_Swift
//
//  Created by Olga Dalton on 26/10/14.
//  Copyright (c) 2014 swiftiostutorials.com. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {
    
    // MARK: - Variables
    var itemIndex: Int = 0
//    var imageName: String = "" {
//
//        didSet {
//
//            if let imageView = contentImageView {
//                imageView.image = UIImage(named: imageName)
//            }
//
//        }
//    }
  
//    @IBOutlet var contentImageView: UIImageView?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        contentImageView!.image = UIImage(named: imageName)
    }
  
  @IBAction func unwindToPage(sender: UIStoryboardSegue)
  {
    let sourceViewController = sender.sourceViewController
    // Pull any data from the view controller which initiated the unwind segue.
  }
}
