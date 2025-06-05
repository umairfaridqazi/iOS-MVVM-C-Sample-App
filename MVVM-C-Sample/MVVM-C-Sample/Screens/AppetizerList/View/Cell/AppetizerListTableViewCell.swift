//
//  AppetizerListTableViewCell.swift
//  MVVM-C-Sample
//
//  Created by Umair on 12/05/2025.
//

import UIKit

class AppetizerListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(data: Appetizer){
        lblTitle.text = data.name
        if !data.imageURL.isEmpty{
            ImageDownloader.shared.downloadImage(urlString: data.imageURL) {[weak self] image in
                guard let image else {
                    return
                }
                Task{
                    self?.imgView.image = image                    
                }
            }
        }
    }
    
}
