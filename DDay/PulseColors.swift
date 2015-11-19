//
//  PulseColors.swift
//  PulseApp
//
//  Created by Kumar Malana, Jatin on 01/07/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

// Colors according to priority

import UIKit

var globalTintColor = UIColor(red: 0.0/255, green: 153.0/255, blue: 255.0/255, alpha: 1)


var anonymousInfoViewColor = UIColor(red: 248.0/255.0, green: 231.0/255.0, blue: 59.0/255.0, alpha: 1)
var highPriorityColor = UIColor(red: 235.0/255.0, green: 41.0/255.0, blue: 46.0/255.0, alpha: 1)
var mediumPriorityColor = UIColor(red: 66.0/255.0, green: 143.0/255.0, blue: 212.0/255.0, alpha: 1)
var lowPriorityColor = UIColor(red: 31.0/255.0, green: 187.0/255.0, blue: 227.0/255.0, alpha: 1)
// Card Color for Cancelled Surveys
var cancelledCardColor = UIColor.grayColor()
var defaultPriorityColor = UIColor(red: 140.0/255.0, green: 215.0/255.0, blue: 237.0/255.0, alpha: 1)
var highPriorityContainerColor = UIColor(red: 253.0/255.0, green: 238.0/255.0, blue: 239.0/255.0, alpha: 1)
var mediumPriorityContainerColor = UIColor(red: 228.0/255.0, green: 239.0/255.0, blue: 249.0/255.0, alpha: 1)
var notesButtonColor = UIColor(red: 27.0/255.0, green:169.0/255.0, blue: 219.0/255.0, alpha: 1)
var lowPriorityContainerColor = UIColor(red: 223.0/255.0, green: 245.0/255.0, blue: 251.0/255.0, alpha: 1)
var defaultPriorityContainerColor = UIColor(red: 227.0/255.0, green: 245.0/255.0, blue: 251.0/255.0, alpha: 1)
var answerCardBackGroundColor = UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 243.0/255.0, alpha: 1)
var bottomGreenBackgroundColor = UIColor(red: 0.2, green: 0.718, blue:0.722, alpha: 1)
var topGreenBackgroundColor = UIColor(red: 0.016, green: 0.349, blue:0.42, alpha: 1)
var bottomBlueBackgroundColor = UIColor(red: 0.157, green: 0.718, blue:0.898, alpha: 1)
var topBlueBackgroundColor = UIColor(red: 0.184, green: 0.318, blue:0.647, alpha: 1)
var yesGreenBackgroundColor = UIColor(red: 102.0/255.0, green: 186.0/255.0, blue: 77.0/255.0, alpha: 1)
var settingsThemeColor = UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 214.0/255.0, alpha: 1)

//For graphs
var meterReportsColorArray = [UIColor(red: 99.0/255.0, green: 188.0/255.0, blue: 70.0/255.0, alpha: 1),UIColor(red: 183.0/255.0, green: 212.0/255.0, blue: 50.0/255.0, alpha: 1),UIColor(red: 183.0/255.0, green: 212.0/255.0, blue: 50.0/255.0, alpha: 1),UIColor(red: 250.0/255.0, green: 179.0/255.0, blue: 22.0/255.0, alpha: 1),UIColor(red: 238.0/255.0, green: 37.0/255.0, blue: 36.0/255.0, alpha: 1)]
// Notes Cell
var notesAlternateColor = UIColor(red: 241.0/255.0, green: 247.0/255.0, blue: 252.0/255.0, alpha: 1)




// Mark:-> QuestionCreation Colors

// SurveyTemplate
let newQuestionTextColor = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)

// QuestionCreationView
let barButtonTintColor                  =   UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 214.0/255.0, alpha: 1)
let mainHeaderBlackColor                =   UIColor(red: 0.0/255.0, green: 0.0/255.0,   blue: 0.0/255.0, alpha: 1)
let sectionHeaderColor                  =   UIColor(red: 109.0/255.0, green: 109.0/255.0,  blue: 114.0/255.0, alpha: 1)
let lightGrayOptionColor                =   UIColor(red: 167.0/255.0, green: 167.0/255.0,  blue: 10.0/255.0, alpha: 1)
let surveyTemplateBackgroundColor       =   UIColor(red: 38.0/255.0, green: 118.0/255.0,   blue: 118.0/255.0, alpha: 1)

let profileImageBezierColor = UIColor(red: 144.0/255.0, green: 172.0/255.0,   blue: 211.0/255.0, alpha: 1)
let profileInitialsBackgroundColor = UIColor(red: 51.0/255.0, green: 51.0/255.0,   blue: 51.0/255.0, alpha: 1)

class GradientColors {
    let colorTop = UIColor(red: 0.0/255, green: 153.0/255, blue: 255.0/255, alpha: 1).CGColor

    let colorBottom = UIColor(red: 52.0/255.0, green: 244.0/255.0, blue: 255.0/255.0, alpha: 1.0).CGColor

    
    let gl: CAGradientLayer
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [ colorTop, colorBottom]
        gl.locations = [ 0.0, 1.0]
    }
}


