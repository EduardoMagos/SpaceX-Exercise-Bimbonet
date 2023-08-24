//
//  Constant.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 21/08/23.
//

import Foundation
struct Constant {
	
	struct API {
		static let hostApi = "https://api.spacexdata.com/"
		static let contextApi = "v3/"
		static let routeApi = "launches/"
		static let launchPast = "\(hostApi)\(contextApi)\(routeApi)past"
	}
	
	struct Colors {
		static let pallet = BaseColors.self
	}
	
	static let letsDebugg = true
	
}
