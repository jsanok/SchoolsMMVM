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
        SATDetailsData.getSATScoreDetails(dbn: self.dbn) { (data , error) in
            self.satData = data
            if(self.satData.count > 0){
                self.schoolName.text = self.satData[0].school_name
                self.numTestTakers.text = self.satData[0].num_of_sat_test_takers
                self.writingAvgScore.text = self.satData[0].sat_writing_avg_score
                self.mathAvgScore.text = self.satData[0].sat_math_avg_score
                self.readingAvgScore.text = self.satData[0].sat_critical_reading_avg_score
            }
            else{
                self.statusLabel.text = "No SAT scores available for selected school"
                self.schoolName.text = self.schoolNamePassed
                self.numTestTakers.text = ""
                self.writingAvgScore.text = ""
                self.mathAvgScore.text = ""
                self.readingAvgScore.text = ""
            }
        }
    }
    
    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet var schoolName: UILabel!
    @IBOutlet var numTestTakers: UILabel!
    @IBOutlet var readingAvgScore: UILabel!
    @IBOutlet var mathAvgScore: UILabel!
    @IBOutlet var writingAvgScore: UILabel!

    var dbn:String?
    var schoolNamePassed:String?
    var satData:[SATData] = [SATData]()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
