//
//  CustomTableViewCell.swift
//  OpenWeatherApp
//
//  Created by Anton on 07.02.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var labelDayOfWeak: UILabel!
    @IBOutlet private weak var labelDayMaxTemp: UILabel!
    @IBOutlet private weak var labelNightMinTemp: UILabel!
    
    //MARK: Life cycle
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configure
    
    func configure(labelDayOfWeak: Date,
                   labelDayMaxTemp: Double,
                   labelNightMinTemp: Int){
        self.labelDayOfWeak.text = "\(labelDayOfWeak)"
        self.labelDayMaxTemp.text = "\(labelDayMaxTemp)"
        self.labelNightMinTemp.text = "\(labelNightMinTemp)"
        
    }
}
