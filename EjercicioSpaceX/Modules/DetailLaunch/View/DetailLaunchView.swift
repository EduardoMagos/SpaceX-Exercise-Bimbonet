//
//  DetailLaunchView.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 22/08/23.
//

import UIKit
import AlamofireImage
import YouTubeiOSPlayerHelper

class DetailLaunchView: BaseView {
	
	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var lblDate: UILabel!
	@IBOutlet weak var lblDateData: UILabel!
	@IBOutlet weak var lblSite: UILabel!
	@IBOutlet weak var lblSiteData: UILabel!
	@IBOutlet weak var lblRocketName: UILabel!
	@IBOutlet weak var lblRocketNameData: UILabel!
	@IBOutlet weak var lblRocketType: UILabel!
	@IBOutlet weak var lblRocketTypeData: UILabel!
	@IBOutlet weak var viewSlide: UIView!
	@IBOutlet weak var textViewDescription: UITextView!
	@IBOutlet weak var imgLaunch: UIImageView!
	@IBOutlet weak var lblDetails: UILabel!
	@IBOutlet weak var btnVideo: UIButton!
	@IBOutlet weak var btnPage: UIButton!
	@IBOutlet weak var viewYoutube: YTPlayerView!
	
	var launch: LaunchPlain?
	private var detailLaunchViewModel = DetailLaunchViewModel()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.viewYoutube.isHidden = true
		self.setCarrouselElements()
    }
	
	override func viewLabels() {
		
		self.lblSiteData.showAllContent()
		self.lblDetails.showAllContent()
		
		self.lblTitle.toH1(text: self.launch?.mission_name ?? "No mision name")
		self.lblDate.toSection(text: "Date:")
		self.lblDateData.toSectionData(text: self.launch?.launch_date_local.toUserDate() ?? "No data")
		self.lblSite.toSection(text: "Site:")
		self.lblSiteData.toSectionData(text: self.launch?.site_name_long ?? "No data")
		self.lblRocketName.toSection(text: "Rocket Name:")
		self.lblRocketNameData.toSectionData(text: self.launch?.rocket_name ?? "No data")
		self.lblRocketType.toSection(text: "Rocket type:")
		self.lblRocketTypeData.toSectionData(text: self.launch?.rocket_type ?? "No data")
		if let detalis = self.launch?.details {
			self.lblDetails.toDetail(text: detalis)
		} else {
			self.lblDetails.isHidden = true
		}
	}
	
	override func viewButtons() {
		self.btnVideo.toPrimaryButton(text: "Watch video")
		self.btnPage.toSecundaryButton(text: "Visit website")
		self.btnVideo.isHidden = self.detailLaunchViewModel.checkVideo(launch: self.launch!)
		self.btnPage.isHidden = self.detailLaunchViewModel.checkPage(launch: self.launch!)
	}
	
	override func viewExtraSetup() {
		self.viewYoutube.roundOut(cornerRadius: 10.0)
		if let imageUrl = launch?.mission_patch_small, let url = URL(string: imageUrl) {
			self.imgLaunch.af.setImage(withURL: url)
		}
	}
	
	func setCarrouselElements() {
		
		if self.launch?.flickr_images.count ?? 0 > 0 && self.launch?.flickr_images[0] != "" {
			let carrousel = CarouselPageViewController(imagesStirng: (self.launch?.flickr_images)!)
			self.setupCarrousel(carrousel: carrousel)
		} else {
			self.viewSlide.isHidden = true
		}
		
	}
	
	private func setupCarrousel(carrousel: UIPageViewController) {
		addChild(carrousel)
		self.viewSlide.addSubview(carrousel.view)
		carrousel.didMove(toParent: self)
		carrousel.view.frame = self.viewSlide.bounds
	}
	
	private func navigateToRocketWeb() {
		let storyBoard : UIStoryboard = UIStoryboard(name: "RocketWebView", bundle:nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "RocketWebView") as! RocketWebView
		vc.launchName = self.launch?.mission_name
		vc.rocketWeb = self.detailLaunchViewModel.returnLinkPage(launch: self.launch!)
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	private func watchVideo() {
		UIView.animate(withDuration: 0.3) {
			self.viewYoutube.isHidden = !self.viewYoutube.isHidden
			self.view.layoutIfNeeded()
			if !self.viewYoutube.isHidden {
				self.viewYoutube.load(withVideoId: self.detailLaunchViewModel.returnLinkVideo(launch: self.launch!))
				self.btnVideo.toPrimaryButton(text: "Hide video")
			} else {
				self.viewYoutube.stopVideo()
				self.btnVideo.toPrimaryButton(text: "Watch video")
			}
		}
	}
	
	@IBAction func backScreen(_ sender: Any) {
		self.returnScreen()
	}
	
	@IBAction func showVideo(_ sender: Any) {
		self.watchVideo()
	}
	
	@IBAction func showPage(_ sender: Any) {
		self.navigateToRocketWeb()
	}
	
	
}
