//
//  AboutUsPageViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/21/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class AboutUsPageViewController: UIPageViewController {
    
    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newPageViewController("AboutUsFirst"),
                self.newPageViewController("AboutUsSecond"),
                self.newPageViewController("AboutUsThird"),
                self.newPageViewController("AboutUsFourth"),
                self.newPageViewController("AboutUsFifth")]
    }()
    
    fileprivate func newPageViewController(_ page: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .instantiateViewController(withIdentifier: "\(page)ViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        self.view.backgroundColor = UIColor.clear
        stylePageControl()
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let subViews: NSArray = view.subviews as NSArray
        var scrollView: UIScrollView? = nil
        var pageControl: UIPageControl? = nil
        
        for view in subViews {
            if ((view as AnyObject).isKind(of: UIScrollView.self)) {
                scrollView = view as? UIScrollView
            } else if ((view as AnyObject).isKind(of: UIPageControl.self)) {
                pageControl = view as? UIPageControl
            }
        }
        
        if (scrollView != nil && pageControl != nil) {
            scrollView?.frame = view.bounds
            view.bringSubview(toFront: pageControl!)
        }
    }
}

extension AboutUsPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil //orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil //orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }
    
    fileprivate func stylePageControl() {
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [type(of: self)])
        
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.backgroundColor = UIColor.clear
    }
}
