//
//  DetailsViewController.swift
//  20180117-JS-NYCSchools
//
//  Created by jeff sanok on 1/17/18.
//  Copyright © 2018 jeffsanok. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utils.insertGradientLayer(theView: self.view)
        SATDetailsData.getSATScoreDetails(dbn: viewModel.dbn) { (data , error) in
            self.viewModel.satData = data
            if(self.viewModel.satData.count > 0){
                self.schoolName.text = self.viewModel.satData[0].school_name
                self.numTestTakers.text = self.viewModel.satData[0].num_of_sat_test_takers
                self.writingAvgScore.text = self.viewModel.satData[0].sat_writing_avg_score
                self.mathAvgScore.text = self.viewModel.satData[0].sat_math_avg_score
                self.readingAvgScore.text = self.viewModel.satData[0].sat_critical_reading_avg_score
            }
            else{
                self.statusLabel.text = "No SAT scores available for selected school"
                self.schoolName.text = self.viewModel.schoolNamePassed
                self.numTestTakers.text = ""
                self.writingAvgScore.text = ""
                self.mathAvgScore.text = ""
                self.readingAvgScore.text = ""
            }
        }
    }
    
    let viewModel = DetailsViewModel()
    
    
    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet var schoolName: UILabel!
    @IBOutlet var numTestTakers: UILabel!
    @IBOutlet var readingAvgScore: UILabel!
    @IBOutlet var mathAvgScore: UILabel!
    @IBOutlet var writingAvgScore: UILabel!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
