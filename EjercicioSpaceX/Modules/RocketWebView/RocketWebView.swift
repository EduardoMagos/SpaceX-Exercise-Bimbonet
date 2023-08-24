//
//  YoutubePlayerView.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 23/08/23.
//

import UIKit
import YouTubeiOSPlayerHelper

class RocketWebView: BaseView, WKNavigationDelegate {
	
	@IBOutlet weak var lblRocketName: UILabel!
	@IBOutlet weak var lblVideo: UILabel!
	@IBOutlet weak var viewRocketWeb: WKWebView!
	
	var launchName: String?
	var rocketWeb: String?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
    
	override func viewLabels() {
		self.lblVideo.toH1(text: "Website")
		self.lblRocketName.toSectionData(text: self.launchName ?? "No name")
	}

	override func viewExtraSetup() {
		self.viewRocketWeb.navigationDelegate = self
		if let url = URL(string: self.rocketWeb ?? "") {
			let request = URLRequest(url: url)
			viewRocketWeb.load(request)
		}
	}
    
	@IBAction func backAction(_ sender: Any) {
		self.returnScreen()
	}
	
}
