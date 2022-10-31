//
//  DailyPictureViewController.swift
//  PictureOfTheDay
//
//  Created by Sajid kantharia on 31/10/22.
//

import UIKit

class DailyPictureViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationTextView: UITextView!
    private var dailyPictureViewModel = DailyPictureViewModel()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyPictureViewModel.delegate = self
        dailyPictureViewModel.dailyPicture()
    }
   
}

extension DailyPictureViewController : PictureViewModelDelegate
{
    func didReceiveDailyPictureResponse(dailyPictureResponse: PictureData?) {
        if(dailyPictureResponse != nil)
        {
            print(dailyPictureResponse)
        }
        else {
            debugPrint("No Data Available")
        }
    }
   
}
