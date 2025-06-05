//
//  AppetizerDetailViewController.swift
//  MVVM-C-Sample
//
//  Created by Umair on 13/05/2025.
//

import UIKit

class AppetizerDetailViewController: UIViewController {

    var appetizer : Appetizer
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    required init?(coder: NSCoder, appetizer: Appetizer) {
        self.appetizer = appetizer
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init?(coder: NSCoder) needs to be implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        lblTitle.text = appetizer.name
        lblDescription.text = appetizer.description

        ImageDownloader.shared.downloadImage(urlString: appetizer.imageURL) { [weak self] image in
            if let image = image{
                self?.imgView.image = image
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
