//
//  ViewController.swift
//  MyPhoto
//
//  Created by Dung Nguyen on 12/17/17.
//  Copyright © 2017 Dung Nguyen - s3598776. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        descriptionTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        descriptionTextField.resignFirstResponder()
        return true
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the unedited image from info
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("selecting image fail: \(info)")
        }
        
        // Set the selected image
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    // function of tap gesture when user tap on the image
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard, if user tap on ImageView while typing on TextField
        descriptionTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary // Get the image from library
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    


}

