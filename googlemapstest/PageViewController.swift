//
//  ViewController.swift
//  Paging_Swift
//
//  Created by Olga Dalton on 26/10/14.
//  Copyright (c) 2014 swiftiostutorials.com. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIPageViewControllerDataSource {
    
    // MARK: - Variables
    private var pageViewController: UIPageViewController?
    
    @IBOutlet weak var buttonScroll: UIScrollView!
    
    var controllers = [PageItemController]()
    
    // Initialize it right away here
    //    private let contentImages = ["nature_pic_1.png",
    //                                 "nature_pic_2.png",
    //                                 "nature_pic_3.png",
    //                                 "nature_pic_4.png"]
    
    // View controller for the popups.
    var popViewController: PopUpViewController!
    
    func timelineButtonPressed(sender:UIButton){
        
        // Launch a pop up
        // Could easily use the sender.tag to specify specific content.
        self.popViewController = PopUpViewController(nibName: "PopUpViewController", bundle: nil)
        self.popViewController.title = "This is a popup view for button \(sender.tag)"
        self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "You just triggered a popup window for \(sender.tag)", animated: true)
    }
    
    func timelineButtonsView(buttonSize:CGSize, buttonCount:Int) -> UIView {
        
        // Creates a view for the buttons
        let buttonView = UIView()
        buttonView.backgroundColor = UIColor.blackColor()
        buttonView.frame.origin = CGPointMake(0,0)
        let padding = CGSizeMake(20, 10)
        buttonView.frame.size.width = (buttonSize.width + padding.width) * CGFloat(buttonCount)
        buttonView.frame.size.height = (buttonSize.height +  2.0 * padding.height)
        
        // Defines some variables to have buttons at standard distances; Could easily be extended to create an actual timeline (i.e. distance between buttons can be different)
        var buttonPosition = CGPointMake(padding.width * 0.5, padding.height)
        let buttonIncrement = buttonSize.width + padding.width
        let hueIncrement = 1.0 / CGFloat(buttonCount)
        var newHue = hueIncrement
        
        // Begin Button adding code
        // Add Buttons to View - this just procedurally creates buttonCount many buttons with different colors
        for i in 0...(buttonCount - 1)  {
            var button = UIButton.buttonWithType(.Custom) as UIButton
            button.tag = i
            button.frame.size = buttonSize
            button.frame.origin = buttonPosition
            buttonPosition.x = buttonPosition.x + buttonIncrement
            button.backgroundColor = UIColor(hue: newHue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            newHue = newHue + hueIncrement
            button.addTarget(self, action: "timelineButtonPressed:", forControlEvents: .TouchUpInside)
            buttonView.addSubview(button)
        }
        // End button adding code
        
        // Begin Line Code
        // Draw Timeline Line
        let line = UIView()
        line.setTranslatesAutoresizingMaskIntoConstraints(false)
        line.backgroundColor = UIColor.lightGrayColor()
        line.frame = CGRect(origin: CGPoint(x: 0, y: 32.5), size: CGSize(width: buttonView.frame.width, height: 5))
        
        buttonView.addSubview(line) // Add the line to the screen
        buttonView.sendSubviewToBack(line) // Send it to the back
        // End Line Code
        
        return buttonView
    }
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set the scrolling pageview
        let scrollingView = timelineButtonsView(CGSizeMake(50.0,50.0), buttonCount: 10) // This generates the buttons
        buttonScroll.contentSize = scrollingView.frame.size // Makes sure we actually scroll
        buttonScroll.addSubview(scrollingView) //Adds our stuff to the View
        buttonScroll.showsHorizontalScrollIndicator = true
        buttonScroll.indicatorStyle = .Default
        
        populateControllersArray()
        createPageViewController()
        setupPageControl()
        
        view.bringSubviewToFront(buttonScroll)
    }
    
    func populateControllersArray() {
        for i in 0...2 {
            let controller = storyboard!.instantiateViewControllerWithIdentifier("ItemController\(i)") as PageItemController
            controller.itemIndex = i
            controllers.append(controller)
            
        }
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as UIPageViewController
        pageController.dataSource = self
        
        if !controllers.isEmpty {
            pageController.setViewControllers([controllers[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
            
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        pageViewController!.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 70);
        
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        //
        //        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as UIPageViewController
        //        pageController.dataSource = self
        //
        //        if contentImages.count > 0 {
        //            let firstController = getItemController(0)!
        //            let startingViewControllers: NSArray = [firstController]
        //            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        //        }
        //
        //        pageViewController = pageController
        //        addChildViewController(pageViewController!)
        //        self.view.addSubview(pageViewController!.view)
        //        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if let controller = viewController as? PageItemController {
            if controller.itemIndex > 0 {
                return controllers[controller.itemIndex - 1]
            }
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let controller = viewController as? PageItemController {
            if controller.itemIndex < controllers.count - 1 {
                return controllers[controller.itemIndex + 1]
            }
        }
        
        return nil
    }
    
    
    // MARK: - Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
