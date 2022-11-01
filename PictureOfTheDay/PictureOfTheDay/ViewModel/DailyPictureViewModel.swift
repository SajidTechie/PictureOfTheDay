//
//  DailyPictureViewModel.swift
//  PictureOfTheDay
//
//  Created by Sajid kantharia on 31/10/22.
//

import Foundation

protocol PictureViewModelDelegate {
    func didReceiveDailyPictureResponse(dailyPictureResponse: PictureData?)
}

struct DailyPictureViewModel
{
    var delegate : PictureViewModelDelegate?
    
    func dailyPicture()
    {
        //use DailyPictureResource to call picture API
        let dailyPictureResource = DailyPictureResource()
        dailyPictureResource.dailyPicture{ (dailyPictureApiResponse) in
            
            //return the response we get from dailyPictureResource
            DispatchQueue.main.async {
                self.delegate?.didReceiveDailyPictureResponse(dailyPictureResponse: dailyPictureApiResponse)
            }
        }
    }
}
