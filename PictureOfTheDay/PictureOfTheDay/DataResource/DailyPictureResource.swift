//
//  DailyPictureResource.swift
//  PictureOfTheDay
//
//  Created by Sajid kantharia on 31/10/22.
//

import Foundation

struct DailyPictureResource
{
    func dailyPicture(completion : @escaping (_ result: PictureData?) -> Void)
    {
        let dailyPictureUrl = URL(string: "\(ApiEndpoints.dailyPictureURL)?api_key=\(ApiEndpoints.apiKey)")!
        let httpUtility = HttpUtility()
        do {
            httpUtility.getApiData(requestUrl: dailyPictureUrl, resultType: PictureData.self) { (dailyPictureApiResponse) in

                _ = completion(dailyPictureApiResponse)
            }
        }
        catch let error {
            debugPrint(error)
        }
    }
}
