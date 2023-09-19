//
//  Details.swift
//  LandmarkBook
//
//  Created by Calis Family on 7.01.2023.
//

import UIKit

class Details: UIViewController {

    @IBOutlet weak var landMark: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedLandmarkName=" "
    var selectedLandmarkImage=UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        landMark.text = selectedLandmarkName
        imageView.image = selectedLandmarkImage
     
    }
    


}
