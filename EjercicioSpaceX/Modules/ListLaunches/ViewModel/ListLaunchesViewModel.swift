//
//  ListLaunchesViewModel.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 21/08/23.
//

import Foundation
import UIKit
import Alamofire


class ListLaunchesViewModel {
	
	var launchPlains: [LaunchPlain] = []
	
	func getLaunches(completion: @escaping (Result<[LaunchPlain], Error>) -> Void) {
		
		AF.request(Constant.API.launchPast, method: .get)
			.validate()
			.responseDecodable(of: [Launch].self) { response in
				switch response.result {
					
					case .success(let data):
					
					DBManager().deleteTable()
					self.launchPlains = []
					let currentDate = Date()
					UserDefaults.standard.set(currentDate, forKey: "lastUpdate")
					
					
					for launch in data {
						let launchPlain = LaunchPlain(
							flight_number: launch.flight_number,
							mission_name: launch.mission_name,
							launch_date_utc: launch.launch_date_utc,
							launch_date_local: launch.launch_date_local,
							details: launch.details ?? "",
							rocket_id: launch.rocket.rocket_id,
							rocket_name: launch.rocket.rocket_name,
							rocket_type: launch.rocket.rocket_type,
							site_id: launch.launch_site.site_id,
							site_name: launch.launch_site.site_name,
							site_name_long: launch.launch_site.site_name_long,
							mission_patch: launch.links.mission_patch ?? "",
							mission_patch_small: launch.links.mission_patch_small ?? "",
							presskit: launch.links.presskit ?? "",
							article_link: launch.links.article_link ?? "",
							wikipedia: launch.links.wikipedia ?? "",
							video_link: launch.links.video_link ?? "",
							youtube_id: launch.links.youtube_id ?? "",
							flickr_images: launch.links.flickr_images ?? []
						)
						
						self.launchPlains.append(launchPlain)
						DBManager().insertLaunch(launchPlaim: launchPlain)
					}
					
					completion(.success(self.launchPlains))
					
					case .failure(let error):
					completion(.failure(error))
					}
				}
	}
	
	func checkLastDate() -> Bool {
		if let savedDate = UserDefaults.standard.object(forKey: "lastUpdate") as? Date {
			
			let calendar = Calendar.current
			let savedDateComponents = calendar.dateComponents([.year, .month, .day], from: savedDate)
			let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: Date())

			if savedDateComponents.year != currentDateComponents.year ||
				savedDateComponents.month != currentDateComponents.month ||
				savedDateComponents.day != currentDateComponents.day
			{
				print("Debug | La fecha guardada es diferente al día de hoy")
				return true
			} else {
				print("Debug | La fecha guardada es igual al día de hoy")
				return false
			}
			
		} else {
			print("Debug | No se encontró ninguna fecha en UserDefaults")
			return true
		}
	}
}
