//
//  TutorialPageViewController.swift
//  Places
//
//  Created by Juan Manuel Jimenez Sanchez on 15/12/16.
//  Copyright © 2016 Juan Manuel Jimenez Sanchez. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {

    var tutorialSteps: [TutorialStep] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstStep = TutorialStep(index: 0, heading: "Personaliza", content: "Crea nuevos lugares, sube imagenes y ubicalos con solo unos pocos segundos", image: #imageLiteral(resourceName: "tuto-intro-1"))
        self.tutorialSteps.append(firstStep)
        
        let secondStep = TutorialStep(index: 1, heading: "Encuentra", content: "Ubica y encuentra tus lugares favoritos a través del mapa", image: #imageLiteral(resourceName: "tuto-intro-2"))
        self.tutorialSteps.append(secondStep)
        
        let thirdStep = TutorialStep(index: 2, heading: "Descubre", content: "Descubre lugares increibles cerca de ti y compartelos con tus amigos", image: #imageLiteral(resourceName: "tuto-intro-3"))
        self.tutorialSteps.append(thirdStep)
        
        dataSource = self
        //Aquí seleccionamos cual pantalla del tutorial arranca primero...
        if let startVC = self.pageViewController(atIndex: 0) {
            setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    //Me mueve al siguiente view controller
    func forward(toIndex: Int) {
        if let nextVC = self.pageViewController(atIndex: toIndex + 1) {
            self.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TutorialPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! TutorialContentViewController).tutorialStep.index
        index += 1
        
        return self.pageViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! TutorialContentViewController).tutorialStep.index
        index -= 1
        
        return self.pageViewController(atIndex: index)
    }
    
    func pageViewController(atIndex: Int) -> TutorialContentViewController? {
        if atIndex == NSNotFound || atIndex < 0 || atIndex >= self.tutorialSteps.count {
            return nil
        }
        
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "tutorialContentID") as? TutorialContentViewController {
            pageContentViewController.tutorialStep = self.tutorialSteps[atIndex]
            return pageContentViewController
        }
        
        return nil
    }
    
    /*func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.tutorialSteps.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let pageContentVC = storyboard?.instantiateViewController(withIdentifier: "tutorialContentID") as? TutorialContentViewController {
            if let tutorialStep = pageContentVC.tutorialStep {
                return tutorialStep.index
            }
        }
        
        return 0
    }*/
}
