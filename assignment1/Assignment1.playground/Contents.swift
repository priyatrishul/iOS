//: Playground - noun: a place where people can play

import UIKit



//Assignment1 Red ID-818630469
//Padmapriya Virupakshaiah




infix operator ** { associativity left precedence 160 }//defining a infix function for exponent operation

func ** (left: Int, right: Int) -> Int {
    return Int(pow(Double(left), Double(right)))
}



//1   given Integer input N function evaluates values for values from 0..N prints value for each input.Output can be seen in the console window


func quadTable(N:Int){
    for k in 1...N {
        
        print(" k= \(k) k*k + 3k - 1=\((k**2) + (3*k) - 1)")
        
    }
}

quadTable(N: 3)







//2   given an Integer input  N function evaluates values from 1..N  and returns  Integer array


func polyTable(N:Int)->[Int]{
    var resultArray=[Int]()
    for k in 1...N {
        
        resultArray.append((k ** 3) + (2*k) + 4)
        
    }
    return resultArray;
}


polyTable(N: 3)

polyTable(N: 10)








//3 Retrieve common elements from the Array of Sets


func busyStudents(arrayOfSets:[Set<String>])->Set<String>{
    
    var commonStudents=Set<String>();
    
    
    for index in 0 ..< arrayOfSets.count{
        
        if index == 0{
            commonStudents=arrayOfSets[index]
        }
        else
        {
            commonStudents.formIntersection(arrayOfSets[index]) //each loop replaces commonStudent varible              with common elemets of two compared sets
        }
        
        
    }
    return commonStudents;
    
}


let courseA: Set = ["Peter", "Paul", "Mary"]
let courseB: Set = ["Peter", "Paul", "Dylan"]
let courseC: Set = ["Tom","Peter",]
let courseD: Set = ["Tom"]

busyStudents(arrayOfSets: [courseA, courseB, courseC])

busyStudents(arrayOfSets: [courseA,courseB])

busyStudents(arrayOfSets: [courseA,courseB,courseC,courseD])




//4  average of elements in a array ,where array can be empty


func average(arrayOfInts:[Int])->Double?{
    
    var averageValue:Double=0.0;
    
    if arrayOfInts.count>0{
        
        
        for  value in arrayOfInts{
            
            averageValue += Double(value);
            
            
        }
        
        return (averageValue/Double(arrayOfInts.count));
        
    }
    else
    {
        return nil; //function returns nil if array is empty
    }
    
}

average(arrayOfInts: [])

average(arrayOfInts: [1,2,3,4])






//5 average of array elements where the array elements can be optional so can be the returned value


func average2(arrayOfInts:[Int?])->Double?{  //input is array of optionals
    
    var averageValue:Double=0.0;
    
    if arrayOfInts.count>0{
        
        
        for  values in arrayOfInts{
            
            if let notNillValue=values{   //check for nil values
                
                averageValue += Double(notNillValue);
                
            }
                
            else
            {
                return nil;
            }
            
        }
        
        return (averageValue/Double(arrayOfInts.count));
        
    }
    else
    {
        return nil;
    }
    
}




average2(arrayOfInts: [])
average2(arrayOfInts: [1,nil,3,4])
average2(arrayOfInts: [1,2,3,4])




//6 To calculate cost using price and quantity from a dictionary type which can optionals



func cost(dictionary:[String:String])->Double{
    
    var cost:Double=0.0
    
 

    if  let priceValue=dictionary["price"], let quantityValue=dictionary["quantity"] //to check for nil value and access optionals if not nill
        
    {
        
        cost = Double(priceValue)! * Double(quantityValue)!
        
        return cost;
    }
    else
    {
        
        return cost;
        
    }

    
}


let iceCreamA = ["name":"Mochie Green Tea", "quantity": "2", "price": "2.3"]
let iceCreamB = ["name":"Mochie Green Tea", "price": "2.3"]
let iceCreamc = ["name":"Mochie Green Tea"]

cost(dictionary: iceCreamA)

cost(dictionary: iceCreamB)

cost(dictionary: iceCreamc)








//7  returns a dictionary  which contains keys  with values equal or more than the input int argument



func wordCount(words sampleString:String,count:Int)->[String:Int]{

     let wordCollection=sampleString.components(separatedBy: " ")
    
     var dictionary=Dictionary<String,Int>()
    
    for word in wordCollection{
        
        let eachWord = word
        var eachWordCount:Int=0
       
        
        for word in wordCollection{
            
            if eachWord == word{
                
                 eachWordCount += 1
            }
        }
            if eachWordCount >= count{
                
                 dictionary[eachWord]=eachWordCount  //retrieve the words which occur as many or more times the input Int argument
            }
           
        }
        
    
    
    return dictionary;
    
}

wordCount(words:"cat bat cat rat mouse bat", count:1)

wordCount(words: "cat bat cat rat mouse bat", count: 2)

wordCount(words: "cat bat cat rat mouse bat", count: 3)




//8  This function Returns a dictionary  which contains keys  with values equal or more than the input Int argument which has a default value



func wordCount2(words sampleString:String,count:Int = 2)->[String:Int]{ //takes default int value=2
    
    let wordCollection=sampleString.components(separatedBy:" ")
    
    var dictionary=Dictionary<String,Int>()
    
    for word in wordCollection{
        
        let eachWord = word
        var eachWordCount:Int=0
        
        
        for word in wordCollection{
            
            if eachWord == word{
                
                eachWordCount += 1
            }
            
        }
            if eachWordCount >= count{
                
                dictionary[eachWord]=eachWordCount //retrieve the words which occur as many or more times the input Int argument

            }
            
        }
    
    
    
    
    return dictionary;
    
}


wordCount2(words:"cat bat cat rat mouse bat")

wordCount2(words:"cat bat cat rat mouse bat" ,count:3)

wordCount2(words:"cat bat cat rat mouse bat" ,count:1)

wordCount2(words: "" ,count:3)



//9 function wordCount3 returns a function which returns the dictionary with keys with values = input integer of wordCount3 function



func wordCount3(number:Int)->((_ words :String)->[String:Int]){
    
    
    func countAgain(words stringSample:String)->[String:Int]{
        
    let wordCollection = stringSample.components(separatedBy: NSLinguisticTagWhitespace)
        
        
        var dictionary=Dictionary<String,Int>()
        
        for word in wordCollection{
            
            let eachWord = word
            var eachWordCount:Int=0
            
            
            for word in wordCollection{
                
                if eachWord == word{
                    
                    eachWordCount += 1
                }
            }
                if eachWordCount == number{  // if eachWordCount >= number gives values >= the input Integer
                    
                    dictionary[eachWord]=eachWordCount
                }
                
            
        }
        
        
        return dictionary;
        
        
    }
    

    return countAgain;
    
    //return {countAgain(words:$0)}

}



let testA = wordCount3(number: 2)

testA("cat bat cat rat mouse bat")

testA("a a a b c c")

let testB = wordCount3(number: 3)

testB("a a a b c c")






//10 function evaluate takes function polytable as second argument.
//polytable2 takes int as agrument and returns double ,polytable2 can be replaced by any function which takes Int as argument and returns Double.




func evaluate(number:Int,another:(Int)->Double)->[Double]{
    
    
    var returnArray=[Double]()
    
    for number in 1...number{
        
        returnArray.append(polyTable2(N: number))
    
        
    }
    
    return returnArray;
    
}



func polyTable2(N:Int)->Double{

    let doubleValue = Double((N * N * N) + (2 * N) + 4);
        
    return doubleValue;
    

}


evaluate(number: 3,another:polyTable2)

evaluate(number: 3,another:{Double(($0 ** 3) + (2 * $0) + 4)})

evaluate(number: 10,another:{Double(($0 ** 3) + (2 * $0) + 4)})//polytable can be replaced by a closure function





//11   Extra credit Cost2 takes price as String or Double and quantity as String or Int.




func cost2(dictionary:[String:Any])->Double{
    
    
    var cost:Double=0.0
    
    if  let priceValue=dictionary["price"] as? String , let quantityValue=dictionary["quantity"] as? String
        
    {
        
        cost = Double(priceValue)! * Double(quantityValue)!
        
        return cost;
    }
        
    else if let priceValue=dictionary["price"] as? Double , let quantityValue=dictionary["quantity"] as? Int{
        
        cost = (priceValue) * Double(quantityValue)
        
        return cost;
        
    }
    else if let priceValue=dictionary["price"] as? String , let quantityValue=dictionary["quantity"] as? Int{
        
        cost = Double(priceValue)! * Double(quantityValue)
        
        return cost;
        
    }
    else if let priceValue=dictionary["price"] as? Double , let quantityValue=dictionary["quantity"] as? String{
        
        cost = (priceValue) * Double(quantityValue)!
        
        return cost;
        
    }
    else{
        return cost;
    }
    
}



cost2(dictionary: ["name":"Mochie Green Tea", "quantity": "2", "price": "2.3"])

cost2(dictionary: ["name":"Mochie Green Tea", "quantity": "2", "price": 2.3])

cost2(dictionary: ["name":"Mochie Green Tea", "quantity": 2, "price": 2.3])

cost2(dictionary: ["name":"Mochie Green Tea", "quantity": 2, "price": "2.3"])

cost2(dictionary: ["name":"Mochie Green Tea", "price": "2.3"])


cost2(dictionary: ["name":"Mochie Green Tea", "quantity": "2"])

cost2(dictionary: ["name":"Mochie Green Tea"])




