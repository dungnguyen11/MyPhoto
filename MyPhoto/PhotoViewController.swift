//
//  ViewController.swift
//  MyPhoto
//
//  Created by Dung Nguyen on 12/17/17.
//  Copyright © 2017 Dung Nguyen - s3598776. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        descriptionTextField.delegate = self
        
        // Set up view if editing an existing Photo
        if let photo = photo {
            photoImageView.image = photo.image
            descriptionTextField.text = photo.description
        }
        
        // Enable the Save button only if the text field has a valid Meal name
        updateSaveButtonState()
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button until the user enter the description
        saveButton.isEnabled = false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
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
    
    //MARK: Navigation
    
    // Dimiss view when user press Cancel button
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddPhotoMode = presentingViewController is UINavigationController
        
        if isPresentingInAddPhotoMode { // User is adding a new photo
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController { // User is editing an existing photo
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            fatalError("saveButton did not pressed")
        }
        
        // Initialize the photo properties if the save button is pressed
        let image = photoImageView.image
        let description = descriptionTextField.text ?? ""
        
        photo = Photo(image: image!, description: description)
        
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
    
    //MARK: Private methods
    private func updateSaveButtonState(){
        // Disable the Save button if the text field is empty
        let text = descriptionTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    


}

