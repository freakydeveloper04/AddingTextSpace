//
//  ViewController.swift
//  AddingTextSpace
//
//  Created by Vaibhav Mehta on 14/09/19.
//  Copyright © 2019 oz10. All rights reserved.
//

import UIKit
import AssetsLibrary

class ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextView: UITextView!
    @IBOutlet weak var bottomTextView: UITextView!
    private var originalImage: UIImage?
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        topTextView.isHidden = true
        bottomTextView.isHidden = true
        
        originalImage = imageView.image
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(ViewController.openGallery(tapGesture:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func openGallery(tapGesture: UITapGestureRecognizer){
        
        print("hello")
    }
    
    
    
    @IBAction func addImage(_ sender: Any) {
        self.setupImagePicker()

    }
    
    @IBAction func cancelImage(_ sender: Any) {
        
        topTextView.isHidden = true
        bottomTextView.isHidden = true
    }
    
    @IBAction func addTopTextView(_ sender: UIButton) {
        topTextView.isHidden = false
    }
  
    @IBAction func addBottomTextView(_ sender: UIButton) {
        
        bottomTextView.isHidden = false

    }
    @IBAction func addInsideTextView(_ sender: UIButton) {
    }
    @IBAction func saveImage(_ sender: UIButton) {
        
        print("Image Saved")
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        var img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if(mainView != nil){
            var rect = (mainView?.frame)!
            rect.size.height *= img!.scale  //MOST IMPORTANT
            rect.size.width *= img!.scale    //TOOK ME DAYS TO FIGURE THIS OUT
            let imageRef = img?.cgImage!.cropping(to: rect)
            img = UIImage(cgImage: imageRef!, scale: img!.scale, orientation: img!.imageOrientation)
        }

        return UIImageWriteToSavedPhotosAlbum(img!, nil, nil, nil)

        
//        let imgData = img!.jpegData(compressionQuality: 0.75)
//
//        var imgjpegImage = UIImage(data: imgData!)
//
//        ALAssetsLibrary().writeImageToSavedPhotosAlbum(imgjpegImage!.CGImage, orientation: ALAssetOrientation(rawValue: imgjpegImage!.imageOrientation.rawValue)!,
//                                                        completionBlock:{
//
//                                                            (path: NSURL!, error: NSError!) -> Void in
//
//                                                            print("\(path)")
//                                                            var picPath: String = "\(path)"
//
//                                                            NSUserDefaults.standardUserDefaults().setObject(picPath, forkey: "myPicPath")
//        })
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func setupImagePicker(){
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.delegate = self
            imagePicker.isEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        self.dismiss(animated: true, completion: nil)
        
    }
}
