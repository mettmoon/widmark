//: Playground - noun: a place where people can play

import UIKit
enum Gender {
    case male, female
}
struct Drink {
    var alcoholRate:Double
    var name:String
}
struct Drinking {
    var drink:Drink
    var amount:Double
}
struct DrunkenPerson {
    var name:String
    var weight:Double//몸무게
    var genderRate:Double//성별 계수 남자 0.7 여자 0.6
    var drinkings:[Drinking] = []
    var decompRate:Double = 0.00015 // 시간당 알코올 분해값
    init(name:String, weight:Double, gender:Gender) {
        self.name = name
        self.weight = weight
        self.genderRate = gender == .male ? 0.7 : 0.6
    }
    mutating func drinking(drink:Drink, amount:Double) {
        
        self.drinkings.append(Drinking(drink: drink, amount: amount))
    }
    
    func getInBloodAlcoholRate(when:TimeInterval) -> Double {
        var amountRate:Double = 0
        for drinking in drinkings {
            amountRate += drinking.amount * drinking.drink.alcoholRate * 0.7984
        }
        let hour = (when - 60 * 30) / 3600
        return amountRate / (self.weight * genderRate) / 10 - (self.decompRate * 100 * hour)
    }

}

let soju = Drink(alcoholRate: 0.25, name: "소주")
var peter = DrunkenPerson(name: "문유성", weight: 75, gender: .male)
var alpha = DrunkenPerson(name: "문유성", weight: 60, gender: .male)
alpha.drinking(drink: soju, amount: 180)
print(alpha.getInBloodAlcoholRate(when: 60 * 60 * 2.5))
