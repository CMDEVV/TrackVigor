//
//  ExerciseBodyPartModel.swift
//  TrackVigor
//
//  Created by Carlos Mendez on 10/10/23.
//

import Foundation

struct ExerciseBodyPart: Codable{
    let bodyPart: String
    let equipment: String
    let gifUrl: String
    let id: String
    let name: String
    let target: String
    let secondaryMuscles: [String]
    let instructions: [String]
}



//bodyPart:"back"
//equipment:"cable"
//gifUrl:"https://v2.exercisedb.io/image/B9Vy3n9X-klUQp"
//id:"0007"
//name:"alternate lateral pulldown"
//target:"lats"
//secondaryMuscles:
//0:"biceps"
//1:"rhomboids"
//instructions:
//0:"Sit on the cable machine with your back straight and feet flat on the ground."
//1:"Grasp the handles with an overhand grip, slightly wider than shoulder-width apart."
//2:"Lean back slightly and pull the handles towards your chest, squeezing your shoulder blades together."
//3:"Pause for a moment at the peak of the movement, then slowly release the handles back to the starting position."
//4:"Repeat for the desired number of repetitions."
