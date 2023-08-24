//
//  ListLaunchesResponse.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 21/08/23.
//

import Foundation

struct Launch: Decodable {
	let flight_number: Int
	let mission_name: String
	let launch_date_utc: String
	let launch_date_local: String
	let details: String?
	let rocket: Rocket
	let launch_site: LaunchSite
	let links: Links
}

struct Rocket: Decodable {
	let rocket_id: String
	let rocket_name: String
	let rocket_type: String
}

struct LaunchSite: Decodable {
	let site_id: String
	let site_name: String
	let site_name_long: String
}

struct Links: Decodable {
	let mission_patch: String?
	let mission_patch_small: String?
	let presskit: String?
	let article_link: String?
	let wikipedia: String?
	let video_link: String?
	let youtube_id: String?
	let flickr_images: [String]?
}

