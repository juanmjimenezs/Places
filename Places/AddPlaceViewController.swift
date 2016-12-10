//
//  AddPlaceViewController.swift
//  Places
//
//  Created by Juan Manuel Jimenez Sanchez on 9/12/16.
//  Copyright © 2016 Juan Manuel Jimenez Sanchez. All rights reserved.
//

import UIKit

class AddPlaceViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var textfieldName: UITextField!
    
    @IBOutlet var textfieldType: UITextField!
    
    @IBOutlet var textfieldAddress: UITextField!
    
    @IBOutlet var textfieldTelephone: UITextField!
    
    @IBOutlet var textfieldWebsite: UITextField!
    
    @IBOutlet var botton1: UIButton!
    
    @IBOutlet var botton2: UIButton!
    
    @IBOutlet var botton3: UIButton!
    
    var rating: String?
    
    var place: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textfieldName.delegate = self
        self.textfieldType.delegate = self
        self.textfieldAddress.delegate = self
        self.textfieldWebsite.delegate = self
        self.textfieldTelephone.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Esconder el teclado cuando el usuario toque afuera del teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Esconder el teclado cuando presiona el botón "Return" del teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        if let name = self.textfieldName.text,
                let type = self.textfieldType.text,
                let address = self.textfieldAddress.text,
                let telephone = self.textfieldTelephone.text,
                let website = self.textfieldWebsite.text,
                let theImage = self.imageView.image,
                let rating = self.rating {
        
            self.place = Place(name: name, type: type, location: address, image: theImage, phone: telephone, web: website)
            self.place?.rating = rating
            
            self.performSegue(withIdentifier: "unwindFromAddPlaceVC", sender: self)
        } else {
            let alertController = UIAlertController(title: "It is missing some data", message: "Check all fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    let defaultColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    let selectedColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    
    @IBAction func ratingPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.rating = "dislike"
            self.botton1.backgroundColor = selectedColor
            self.botton2.backgroundColor = defaultColor
            self.botton3.backgroundColor = defaultColor
        case 2:
            self.rating = "good"
            self.botton1.backgroundColor = defaultColor
            self.botton2.backgroundColor = selectedColor
            self.botton3.backgroundColor = defaultColor
        case 3:
            self.rating = "great"
            self.botton1.backgroundColor = defaultColor
            self.botton2.backgroundColor = defaultColor
            self.botton3.backgroundColor = selectedColor
        default:
            break
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //Hay que gestionar la selección de la imagen del lugar
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                
                //Muestra de forma modal la ventana
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Cuando se ha seleccionado una imagen
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true
        
        let leadingConstraint = NSLayoutConstraint(item: self.imageView, attribute: .leading, relatedBy: .equal, toItem: self.imageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: self.imageView, attribute: .trailing, relatedBy: .equal, toItem: self.imageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: self.imageView, attribute: .top, relatedBy: .equal, toItem: self.imageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottonConstraint = NSLayoutConstraint(item: self.imageView, attribute: .bottom, relatedBy: .equal, toItem: self.imageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottonConstraint.isActive = true
        
        //Destruye la vista que fue presentada de forma modal
        dismiss(animated: true, completion: nil)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
