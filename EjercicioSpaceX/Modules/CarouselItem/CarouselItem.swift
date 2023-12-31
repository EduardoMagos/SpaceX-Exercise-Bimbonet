//
//  CarruselItem.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 23/08/23.
//

import Foundation
import UIKit

@IBDesignable
class CarouselItem: UIView {
	
	static let CAROUSEL_ITEM_NIB = "CarouselItem"
	
	@IBOutlet var vwContent: UIView!
	@IBOutlet var vwBackground: UIView!
	@IBOutlet weak var imageView: UIImageView!
	
	// MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initWithNib()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initWithNib()
	}
	
	convenience init(image: UIImage? = UIImage()) {
		self.init()
		self.imageView.contentMode = .scaleAspectFill
		self.imageView.clipsToBounds = true
		self.imageView.roundOut(cornerRadius: 15.0)
		self.imageView.image = image
	}
	
	fileprivate func initWithNib() {
		Bundle.main.loadNibNamed(CarouselItem.CAROUSEL_ITEM_NIB, owner: self, options: nil)
		vwContent.frame = bounds
		vwContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		addSubview(vwContent)
	}
}
