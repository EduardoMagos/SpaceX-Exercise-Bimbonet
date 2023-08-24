//
//  Label.swift
//  Vado-ios-daily
//
//  Created by Luis Eduardo Magos Moreno on 04/07/23.
//  Copyright © 2023 Neology. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
	
	enum font: String {
		case roboto = "Roboto"
		case poppins = "Poppins"
	}
	
	enum typeFont: String {
		case black = "Roboto-Black"
		case bold = "Roboto-Bold"
		case medium = "Roboto-Medium"
		case regular = "Roboto-Regular"
	}
	
	func setupLabel(type: typeFont, size: Double, text: String, color: UIColor = .black, underline: Bool = false) {
		self.font = UIFont(name: type.rawValue, size: size)!
		self.textColor = color
	}
	
	func toH1(text: String) {
		self.font = UIFont(name: "Poppins-Bold", size: 20.0)!
		self.textColor = UIColor(named: "text_dark")
		self.text = text
	}
	
	func toH2(text: String) {
		self.font = UIFont(name: "Poppins-SemiBold", size: 20.0)!
		self.textColor = UIColor(named: "text_dark")
		self.text = text
	}
	
	func toSection(text: String) {
		self.font = UIFont(name: "Poppins-SemiBold", size: 16.0)!
		self.textColor = UIColor(named: "text_dark")
		self.text = text
	}
	
	func toSectionData(text: String) {
		self.font = UIFont(name: "Poppins-Regular", size: 16.0)!
		self.textColor = UIColor(named: "text_dark")
		self.text = text
	}
	
	func toDetail(text: String) {
		self.font = UIFont(name: "Poppins-Regular", size: 14.0)!
		self.textColor = UIColor(named: "text_dark")
		self.text = text
	}
	
	func toTitleCell(text: String) {
		self.font = UIFont(name: "Poppins-SemiBold", size: 18.0)!
		self.textColor = UIColor(named: "text_dark")
		self.text = text
	}
	
	func toLabelCell(text: String) {
		self.font = UIFont(name: "Poppins-Regular", size: 14.0)!
		self.textColor = UIColor(named: "text_dark")
		self.text = text
	}
	
	func showAllContent() {
		self.numberOfLines = 0
		self.adjustsFontSizeToFitWidth = false
	}
}
