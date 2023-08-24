//
//  LaunchPlain.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 23/08/23.
//

import Foundation

class LaunchPlain {
	
	let flight_number: Int
	let mission_name: String
	let launch_date_utc: String
	let launch_date_local: String
	let details: String
	let rocket_id: String
	let rocket_name: String
	let rocket_type: String
	let site_id: String
	let site_name: String
	let site_name_long: String
	let mission_patch: String
	let mission_patch_small: String
	let presskit: String
	let article_link: String
	let wikipedia: String
	let video_link: String
	let youtube_id: String
	let flickr_images: [String]
	
	
	init(
		flight_number: Int,
		mission_name: String,
		launch_date_utc: String,
		launch_date_local: String,
		details: String,
		rocket_id: String,
		rocket_name: String,
		rocket_type: String,
		site_id: String,
		site_name: String,
		site_name_long: String,
		mission_patch: String,
		mission_patch_small: String,
		presskit: String,
		article_link: String,
		wikipedia: String,
		video_link: String,
		youtube_id: String,
		flickr_images: [String]
	) {
		self.flight_number = flight_number
		self.mission_name = mission_name
		self.launch_date_utc = launch_date_utc
		self.launch_date_local = launch_date_local
		self.details = details
		self.rocket_id = rocket_id
		self.rocket_name = rocket_name
		self.rocket_type = rocket_type
		self.site_id = site_id
		self.site_name = site_name
		self.site_name_long = site_name_long
		self.mission_patch = mission_patch
		self.mission_patch_small = mission_patch_small
		self.presskit = presskit
		self.article_link = article_link
		self.wikipedia = wikipedia
		self.video_link = video_link
		self.youtube_id = youtube_id
		self.flickr_images = flickr_images
	}
}
