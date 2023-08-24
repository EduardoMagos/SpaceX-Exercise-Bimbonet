//
//  BaseView.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 21/08/23.
//

import UIKit

class BaseView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.setNavigationBarHidden(true, animated: false)
		self.setupUserInterface()
		self.viewGetData()
		if Constant.letsDebugg {
			self.viewWillTest()
		}
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(true, animated: false)
		self.setupUserInterface()
	}
	
	func setupUserInterface() {
		DispatchQueue.main.async {
			self.viewLabels()
			self.viewInputs()
			self.viewButtons()
			self.viewExtraSetup()
		}
	}
	
	func returnScreen() {
		self.navigationController?.popViewController(animated: true)
	}
    
	func viewGetData() {} // Función para configurar las pruebas de la vista
	func viewWillTest() {} // Función para configurar las pruebas de la vista
	func viewLabels() {} // Función para configurar las etiquetas de la vista
	func viewInputs() {} // Función para configurar las entradas de la vista
	func viewButtons() {} // Función para configurar los botones de la vista
	func viewExtraSetup() {} // Función para las configuraciones extra de la vista

}
