//
//  UIView.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 22/08/23.
//

import Foundation
import UIKit

extension UIView {
	
	static var identifier: String {
		return String(describing: self)
	}
	
	var identifier: String {
		return String(self.classForCoder.description().split(separator: ".").last ?? "")
	}
	
	static func nib() -> UINib {
		return UINib(nibName: self.identifier, bundle: nil)
	}
	
	func roundOut(cornerRadius: CGFloat = 25.0) {
		self.layer.cornerRadius = cornerRadius
		self.clipsToBounds = true
	}
	
}
