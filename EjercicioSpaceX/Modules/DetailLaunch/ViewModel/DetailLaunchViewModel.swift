//
//  DetailLaunchViewModel.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 23/08/23.
//

import Foundation

class DetailLaunchViewModel {
	
	func checkVideo(launch: LaunchPlain) -> Bool {
		let pageString = launch.youtube_id ?? launch.video_link ?? ""
		if pageString != "" {
			return false
		} else {
			return true
		}
	}
	
	func checkPage(launch: LaunchPlain) -> Bool {
		let pageString = launch.wikipedia ?? launch.article_link ?? launch.presskit ?? ""
		if pageString != "" {
			return false
		} else {
			return true
		}
	}
	
	func returnLinkVideo(launch: LaunchPlain) -> String {
		let pageString = launch.youtube_id ?? launch.video_link ?? ""
		return pageString
	}
	
	func returnLinkPage(launch: LaunchPlain) -> String {
		let pageString = launch.wikipedia ?? launch.article_link ?? launch.presskit ?? ""
		return pageString
	}
	
}
