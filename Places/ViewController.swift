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
        
        var place = Place(name: "Alexanderplatz", type: "Square", location: "Alexanderstraße 4 10178 Berlin, Deutschland", image: #imageLiteral(resourceName: "alexanderplatz"), phone: "5550000", web: "https://es.wikipedia.org/wiki/Alexanderplatz")
        self.places.append(place)
        
        place = Place(name: "Atomium", type: "Museum", location: "Atomiumsquare 11020 Bruxelles, België", image: #imageLiteral(resourceName: "atomium"), phone: "+32(0)2 475 6543", web: "http://atomium.be/")
        self.places.append(place)
        
        place = Place(name: "Big ben", type: "Monument", location: "London SW1A 0AA England", image: #imageLiteral(resourceName: "bigben"), phone: "+44 20 7219 4272", web: "https://es.wikipedia.org/wiki/Big_Ben")
        self.places.append(place)
        
        place = Place(name: "Cristo Redentor", type: "Monument", location: "Parque Nacional da Tijuca Alto da Boa Vista Rio de Janeiro - RJ 21072, Brasil", image: #imageLiteral(resourceName: "cristoredentor"), phone: "+46 20 7219 4272", web: "https://es.wikipedia.org/wiki/Cristo_Redentor")
        self.places.append(place)
        
        place = Place(name: "Torre Eiffel", type: "Monument", location: "5 Avenue Anatole France 75007 Paris, France", image: #imageLiteral(resourceName: "torreeiffel"), phone: "+43 20 7219 4272", web: "http://www.toureiffel.paris/")
        self.places.append(place)

        place = Place(name: "Great Wall", type: "Monument", location: "Great Wall, Mutianyu Beijing, China", image: #imageLiteral(resourceName: "murallachina"), phone: "+27 20 7219 4272", web: "https://en.wikipedia.org/wiki/Great_Wall_of_China")
        self.places.append(place)
        
        place = Place(name: "Tower of Pisa", type: "Monument", location: "Piazza del Duomo, 56126 Pisa PI, Italia", image: #imageLiteral(resourceName: "torrepisa"), phone: "+41 20 7219 4272", web: "http://www.towerofpisa.org/")
        self.places.append(place)
        
        place = Place(name: "La Seu de Mallorca", type: "Catedral", location: "La Seu Plaza de la Seu 5 07001 Palma Baleares, España", image: #imageLiteral(resourceName: "mallorca"), phone: "+34 902 02 24 45", web: "http://www.catedraldemallorca.info/principal/")
        self.places.append(place)
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
        cell.typeLabel.text = place.type
        cell.locationLabel.text = place.location
        
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

