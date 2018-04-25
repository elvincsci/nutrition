//
//  FoodMainViewController.swift
//  nutrition
//
//  Created by elvin on 4/16/18.
//  Copyright © 2018 elvin. All rights reserved.
//

import UIKit
import Firebase


class FoodMainViewController:  UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var foodName: UITextField!
    
    @IBOutlet weak var proteins: UITextField!
    @IBOutlet weak var calories: UITextField!
    
    @IBOutlet weak var fat: UITextField!
    @IBOutlet weak var carbohydrates: UITextField!
    
    var foodselection = -1
    
    let foods = ["Breakfast", "Lunch", "Dinner", "Snack"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return foods[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return foods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        //label.text = foods[row]
        foodselection = row

        //print(foods[row])
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        fetch()
        // Do any additional setup after loading the view.
    }

    
    
    func fetch() {


        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func submitButton(_ sender: Any) {
        

        if foodselection == -1 || foodselection == 0
        {
            //"Breakfast"
            //print("breakfast")
            foodselection = 0
        }
//        }else if birthYear == 1
//        {
//            //"Lunch"
//            print("lunch")
//
//        }else if birthYear == 2
//        {
//            //"Dinner"
//            print("Dinner")
//        }else{
//            //"Snack"
//            print("snack")
//        }
    

        let ref = Database.database().reference()
        
        let uid = Auth.auth().currentUser?.uid
        
        let food = ref.child("users").child(uid!).child("foodIntake").childByAutoId()
        
        let foodNames = food.child("name")
        foodNames.setValue(foodName.text)

        let foodType = food.child("type")
        foodType.setValue(foods[foodselection])

        let foodCalories = food.child("calories")
        foodCalories.setValue(Int(calories.text!))

        let foodCarbohyrates = food.child("carbohyrates")
        foodCarbohyrates.setValue(Int(carbohydrates.text!))

        let foodFat = food.child("fat")
        foodFat.setValue(Int(fat.text!))

        let foodProtein = food.child("protein")
        foodProtein.setValue(Int(proteins.text!))
        
        
        let timestamp = NSDate().timeIntervalSince1970
        let StressTimestamp = food.child("TimeStamp")
        StressTimestamp.setValue(timestamp)

    
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
