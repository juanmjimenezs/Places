//
//  TutorialContentViewController.swift
//  Places
//
//  Created by Juan Manuel Jimenez Sanchez on 15/12/16.
//  Copyright © 2016 Juan Manuel Jimenez Sanchez. All rights reserved.
//

import UIKit

class TutorialContentViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    
    var tutorialStep: TutorialStep!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = self.tutorialStep.heading
        self.contentLabel.text = self.tutorialStep.content
        self.contentImageView.image = self.tutorialStep.image
        self.pageControl.currentPage = self.tutorialStep.index
        
        switch self.tutorialStep.index {
        case 0...1:
            self.nextButton.setTitle("Next", for: .normal)
        case 2:
            self.nextButton.setTitle("Start!", for: .normal)
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        switch self.tutorialStep.index {
        case 0...1://Next...
            let pageViewController = parent as! TutorialPageViewController
            pageViewController.forward(toIndex: self.tutorialStep.index)
        case 2://Start...
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "hasViewedTutorial")
            self.dismiss(animated: true, completion: nil)
        default:
            break
        }
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
