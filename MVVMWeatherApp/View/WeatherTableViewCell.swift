//
//  WeatherTableViewCell.swift
//  MVVMWeatherApp
//
//  Created by Zeynep Sevgi on 25.07.2023.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var tempGeceLabel: UILabel!
    @IBOutlet weak var tempGunduzLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
