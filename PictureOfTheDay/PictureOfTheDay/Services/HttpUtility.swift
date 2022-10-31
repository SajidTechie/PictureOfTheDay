//
//  HttpUtility.swift
//  PictureOfTheDay
//
//  Created by Sajid kantharia on 31/10/22.
//

import Foundation

struct HttpUtility
{
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _=completionHandler(result)
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error.localizedDescription)")
                }
            }

        }.resume()
    }

}
