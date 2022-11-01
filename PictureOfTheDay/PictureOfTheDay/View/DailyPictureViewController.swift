//
//  DailyPictureViewController.swift
//  PictureOfTheDay
//
//  Created by Sajid kantharia on 31/10/22.
//

/*
 In this project I have used storyboard for UI for the sake of simplicity. In production app we will prefer to build UI programmatically for performance benefits.
 */

import UIKit
import SDWebImage
import CoreData

class DailyPictureViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationTextView: UITextView!
    
    private var pictureResponse : DailyPicture?
    private var checkIfNewData:Bool = false
    
    private var dailyPictureViewModel = DailyPictureViewModel()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //calling daily picture API if internet is connected
        if (Utils.isConnectedToNetwork()) {
            activityIndicator.isHidden = false
            checkIfNewData = true
            
            dailyPictureViewModel.delegate = self
            dailyPictureViewModel.dailyPicture()
        }else{
            checkIfNewData = false
            
            //fetch data from local db
            fetchPicture()
        }
    }
    
}

extension DailyPictureViewController : PictureViewModelDelegate
{
    func didReceiveDailyPictureResponse(dailyPictureResponse: PictureData?) {
        
        if(dailyPictureResponse != nil){
            //check in local db if value is present then update else add picture data
            if(pictureResponse != nil){
                updatePicture(dailyPictureResponse: dailyPictureResponse)
            }else{
                addPictureData(dailyPictureResponse: dailyPictureResponse)
            }
        }else{
            let alert = UIAlertController(title: "Error", message: "No Data Available to Display", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        activityIndicator.isHidden = true
    }
    
    //- - - - add data in daily picture entity
    func addPictureData(dailyPictureResponse: PictureData?){
        let pictureObj = DailyPicture(context: self.context)
        pictureObj.imageUrl = dailyPictureResponse?.url ?? ""
        pictureObj.title = dailyPictureResponse?.title ?? ""
        pictureObj.explanation = dailyPictureResponse?.explanation ?? ""
        
        //save data
        do{
            try self.context.save()
        }
        catch{}
        
        //refetch data
        self.fetchPicture()
    }
    
    //fetch picture response
    func fetchPicture(){
        
        do{
            //For sorting and filtering we need to create a fetch request
            let request = DailyPicture.fetchRequest() as NSFetchRequest<DailyPicture>
            let response = try context.fetch(request)
            
            if let pictureObj = response.first {
                pictureResponse = pictureObj
                
                if(!checkIfNewData){
                    let alert = UIAlertController(title: "Error", message: "We are not connected to the internet, showing you the last image we have.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }else{
                let alert = UIAlertController(title: "Error", message: "No Data Available to Display", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            
            
            setData()
        
        }catch{
            debugPrint(error)
        }
    }
    
    // - - - Update picture data with new values from API
    func updatePicture(dailyPictureResponse: PictureData?){
        
        self.fetchPicture()
        
        if(dailyPictureResponse != nil){
            guard let objToUpdate = pictureResponse else { return }
            objToUpdate.imageUrl = dailyPictureResponse?.url ?? ""
            objToUpdate.title = dailyPictureResponse?.title ?? ""
            objToUpdate.explanation = dailyPictureResponse?.explanation ?? ""
        }
        //save data
        do{
            try self.context.save()
        }
        catch{}
        
        //refetch data
        self.fetchPicture()
    }
    
    // - - - - setting image,title and explanation on daily picture view
    func setData(){
        self.imageView.sd_setImage(with: URL(string: pictureResponse?.imageUrl ?? ""), placeholderImage: UIImage(named: "no-photos"))
        self.titleLabel.text = pictureResponse?.title ?? ""
        self.explanationTextView.text = pictureResponse?.explanation ?? ""
    }
}
