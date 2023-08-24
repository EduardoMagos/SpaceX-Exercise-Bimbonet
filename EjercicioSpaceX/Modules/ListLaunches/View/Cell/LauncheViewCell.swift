//
//  LauncheViewCell.swift
//  EjercicioSpaceX
//
//  Created by Luis Eduardo Magos Moreno on 21/08/23.
//

import UIKit

protocol LaunchViewCellDelegate: AnyObject {
	func didSelectLaunch(_ launch: LaunchPlain)
}

class LauncheViewCell: UITableViewCell {
	
	@IBOutlet weak var viewCell: UIView!
	@IBOutlet weak var imgLaunch: UIImageView!
	@IBOutlet weak var lblName: UILabel!
	@IBOutlet weak var lblSite: UILabel!
	@IBOutlet weak var lblDate: UILabel!
	
	weak var delegate: LaunchViewCellDelegate?
	var launch: Launch?
	var launchPlain: LaunchPlain?
	
	override func awakeFromNib() {
        super.awakeFromNib()
		self.selectionStyle = .none
		self.viewCell.roundOut(cornerRadius: 10.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	@IBAction func detailButtonTapped(_ sender: UIButton) {
		if let launch = launchPlain {
			delegate?.didSelectLaunch(launch)
		}
	}
    
}
