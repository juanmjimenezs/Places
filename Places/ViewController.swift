//
//  ViewController.swift
//  Places
//
//  Created by Juan Manuel Jimenez Sanchez on 6/12/16.
//  Copyright © 2016 Juan Manuel Jimenez Sanchez. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var places: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Esta función retornando el valor 'true' indica que preferimos ocultar la barra de estado
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: -UITableViewDataSource
    //Estas 3 funciones a continuación, son necesarias para poder desplegar datos en la TableView
    
    //Esta función indica el número de secciones de la tabla (normalmente es 1)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Esta función indica el número de filas por sección.
    //Como no tenemos paginador entonces le indicamos el número total de elementos en el arreglo.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    //Esta función aplica para cada fila de la tabla
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = places[indexPath.row]
        let cellID = "PlaceCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PlaceCell
        
        //Así es cuando tenemos elementos personalizados en la fila...
        cell.thumbnailimageView.image = place.image
        cell.nameLabel.text = place.name
        cell.timeLabel.text = place.type
        cell.ingredientsLabel.text = place.location
        
        return cell
    }
    
    //MARK: -UITableViewDelegate
    
    //Esta función habilita las opciones que aparecen al desplazar lateralmente la fila
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Compartir
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            let place = self.places[indexPath.row]
            
            let shareDefaultText = "Estoy visitando \(place.name) en la App de Juan Manuel"
            let activityController = UIActivityViewController(activityItems: [shareDefaultText, place.image], applicationActivities: nil)
            
            self.present(activityController, animated: true, completion: nil)
        }
        shareAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        //Eliminar
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.places.remove(at: indexPath.row)
            //self.tableView.reloadData()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        return [shareAction, deleteAction]
    }
    
    //Esta función se ejecuta cuando tocamos un área delimitada para un segue (un enlace a otro viewController)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Si el identificador corresponde al segue que va al detalle de la receta
        if segue.identifier == "showDetail" {
            //Obtenemos el indexPath de la fila seleccionada
            if let indexPath = self.tableView.indexPathForSelectedRow {
                //Obtenemos la receta seleccionada
                let selectedPlace = self.places[indexPath.row]
                //Obtenemos el controlador de destino
                let destinationViewController = segue.destination as! DetailViewController
                //Almacenamos en destino el lugar
                destinationViewController.place = selectedPlace
            }
        }
    }
}

