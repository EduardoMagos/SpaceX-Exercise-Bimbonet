//
//  CarouselPageView.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 23/08/23.
//

import Foundation
import UIKit


class CarouselPageViewController: UIPageViewController {
	
	fileprivate var items: [UIViewController] = []
	fileprivate var images: [UIImage] = []
	fileprivate var imagesString: [String]
	
	init(imagesStirng: [String]) {
		self.imagesString = imagesStirng
		super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.dataSource = self
		self.decoratePageControl()
		self.downloadImages {
			if self.images.count == self.imagesString.count {
				self.setImages()
				
			}
			
		}
	   
		if let firstViewController = items.first {
			setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
	}
	
	func downloadImages(_ closure: @escaping () -> Void)  {

		images = []
		var count = self.imagesString.count
		for image in self.imagesString {
			count -= 1
			if let url = URL(string: image) {
				let imageDownloader = UIImageView.af.sharedImageDownloader
				imageDownloader.download(URLRequest(url: url)) { response in
					if case .success(let image) = response.result {
						self.images.append(image)
						if count == 0 {
							closure()
						}
					}
				}
			}
		}
	}
	
	func setImages() {
		self.populateItems()
		if let firstViewController = items.first {
			setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
		}
	}
	
	fileprivate func decoratePageControl() {
		let pc = UIPageControl.appearance(whenContainedInInstancesOf: [CarouselPageViewController.self])
		pc.currentPageIndicatorTintColor = .black
		pc.pageIndicatorTintColor = .gray
		pc.backgroundStyle = .automatic
		pc.backgroundColor = .none
		pc.numberOfPages = items.count
	}
	
	fileprivate func populateItems() {
		for image in images {
			let c = createCarouselItemControler(with: image)
			items.append(c)
		}
		
	}
	
	fileprivate func createCarouselItemControler(with image: UIImage?) -> UIViewController {
		let c = UIViewController()
		c.view = CarouselItem(image: image)
		return c
	}
}

// MARK: - DataSource
extension CarouselPageViewController: UIPageViewControllerDataSource {
	func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = items.index(of: viewController) else {
			return nil
		}
		
		let previousIndex = viewControllerIndex - 1
		
		guard previousIndex >= 0 else {
			return items.last
		}
		
		guard items.count > previousIndex else {
			return nil
		}
		
		return items[previousIndex]
	}
	
	func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = items.index(of: viewController) else {
			return nil
		}
		
		let nextIndex = viewControllerIndex + 1
		guard items.count != nextIndex else {
			return items.first
		}
		
		guard items.count > nextIndex else {
			return nil
		}
		
		return items[nextIndex]
	}
	
	func presentationCount(for _: UIPageViewController) -> Int {
		return items.count
	}
	
	func presentationIndex(for _: UIPageViewController) -> Int {
		guard let firstViewController = viewControllers?.first,
			let firstViewControllerIndex = items.index(of: firstViewController) else {
				return 0
		}
		
		return firstViewControllerIndex
	}
}
