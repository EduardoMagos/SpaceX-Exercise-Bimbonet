//
//  ListLaunchesView.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 21/08/23.
//

import UIKit
import AlamofireImage

class ListLaunchesView: BaseView, LaunchViewCellDelegate {
	
	@IBOutlet weak var viewHeader: UIView!
	@IBOutlet weak var tableLaunches: UITableView!
	
	private var listLaunchesViewModel = ListLaunchesViewModel()
	var launchesPlain: [LaunchPlain] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewExtraSetup() {
		self.viewHeader.roundOut(cornerRadius: 0.0)
		self.tableLaunches.delegate = self
		self.tableLaunches.dataSource = self
		self.tableLaunches.separatorStyle = .none
		self.tableLaunches.register(LauncheViewCell.nib(), forCellReuseIdentifier: LauncheViewCell.identifier)
	}
	
	override func viewGetData() {
		
		if self.listLaunchesViewModel.checkLastDate() {
			self.listLaunchesViewModel.getLaunches { [weak self] result in
				switch result {
				case .success(let launches):
					self?.launchesPlain = launches
					self?.tableLaunches.reloadData()
					print("Debug | Data recuperada de la API")
				case .failure(let error):
					print("Debug | Error al transformar la respuesta: \(error)")
				}
			}
		} else {
			self.launchesPlain = DBManager().listLaunches()
			print("Debug | Data recuperada de la base de datos")
		}
		
	}
	
	func didSelectLaunch(_ launchCell: LaunchPlain) {
		self.navigateToDetailRocket(launchCell: launchCell)
	}
	
	func navigateToDetailRocket(launchCell: LaunchPlain) {
		let storyBoard : UIStoryboard = UIStoryboard(name: "DetailLaunchView", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "DetailLaunchView") as! DetailLaunchView
		vc.launch = launchCell
		self.navigationController?.pushViewController(vc, animated: true)
	}
}

extension ListLaunchesView: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.launchesPlain.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: LauncheViewCell.identifier, for: indexPath) as? LauncheViewCell else {
			return UITableViewCell()
		}
		
		let launchPlain = self.launchesPlain[indexPath.row]
		cell.delegate = self
		cell.launchPlain = launchPlain
		cell.lblName.toTitleCell(text: launchPlain.mission_name)
		cell.lblSite.toLabelCell(text: launchPlain.site_name)
		cell.lblDate.toLabelCell(text: launchPlain.launch_date_local.toUserDate())
		
		if let url = URL(string: launchPlain.mission_patch_small) {
			cell.imgLaunch.af.setImage(withURL: url)
		}
		
		return cell
	}
}
