//
//  UIButton.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 23/08/23.
//

import Foundation
import UIKit

extension UIButton {
	
	func toPrimaryButton(text: String) {
		self.layer.cornerRadius = 25
		self.clipsToBounds = true
		self.backgroundColor = UIColor(named: "text_dark")
		self.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16.0)
		self.tintColor = .white
		self.setTitle(text, for: .normal)
	}
	
	func toSecundaryButton(text: String) {
		self.layer.cornerRadius = 25
		self.clipsToBounds = true
		self.backgroundColor = UIColor(named: "gray_medium")
		self.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16.0)
		self.tintColor = .black
		self.setTitle(text, for: .normal)
	}
	
}
