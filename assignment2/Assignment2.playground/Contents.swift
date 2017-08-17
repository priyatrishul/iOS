//: Playground - noun: a place where people can play

import UIKit


//Red id-818630469
//Padmapriya Virupakshaiah








//1    Add the method phoneFormat to the String class


extension String{
    
    subscript (str: Range<Int>) -> String {
        
        return substringWithRange(Range(start: startIndex.advancedBy(str.startIndex), end: startIndex.advancedBy(str.endIndex)))
    }
    
    func phoneFormat()->String?{
            
       
        let a1=self.stringByReplacingOccurrencesOfString("[\\.\\/\\ \\\\\\-\\(\\)]",withString:"",options: .RegularExpressionSearch) //removing the separating characters
            
            let count = a1.characters.count
            
            if count > 10 || count < 10{
                
                return nil
            }
            else{
                
            return a1[0...2]+"-"+a1[3...5]+"-"+a1[6...9]
        }
        
        
        }
  
}


"6195946191".phoneFormat()
"619.594.6191".phoneFormat()
"(619)-594-6191".phoneFormat()
"619 594 6191".phoneFormat()
"619 5946191".phoneFormat()
"619-594-6191".phoneFormat()







//2 Create a PhoneNumberstructure



enum PhoneTypes:String{
    
    
    case mobile,home,work,main,homefax,workfax,pager
}



struct PhoneNumber{
    
    var phoneNumber:String;
    
    var phoneType:PhoneTypes;
    
    var description:String{
        
        get{
        
            return String(phoneType)+":"+phoneNumber
        }
    }
   
 

    init(number:String,type:PhoneTypes){
 
            
            phoneNumber = number.phoneFormat()!;
            phoneType = type;
    
        
    }
    
    
     init(number:String){
        
       
        self.init(number :number ,type: PhoneTypes.home);
        
        
    }
    
    func isMobile()->Bool{
        
        if phoneType == PhoneTypes.mobile{
            
            return true
        }
        return false
    }
    
    func isLocal()->Bool{
        
        if phoneNumber[0...2] == "619" || phoneNumber[0...2] == "858"{
            
            return true
        }
        return false
    }
    
    
}

let phone1 = PhoneNumber(number: "(858)-777-9999")
phone1.isLocal()
phone1.isMobile()
phone1.description


let phone2 = PhoneNumber(number: "858-777-9999",type: .work)
phone2.isLocal()
phone2.isMobile()
phone2.description

let phone3 = PhoneNumber(number: "858-777-9999",type: .mobile)
phone3.isLocal()
phone3.isMobile()
phone3.description








//3 Add a method asPhoneNumber to the String  class



extension String{
    
    
    func asPhoneNumber()->PhoneNumber?{
        
        var stringArray=self.componentsSeparatedByString(":")
        
        var tValue:String="";
        
        if stringArray.count < 2{
            
            return nil
        }
        else{
        
        let phoneNum :String? = stringArray[1].phoneFormat();
        
        
        if let typeValue = PhoneTypes(rawValue: stringArray[0]){
            
            switch typeValue{
                
            case .mobile:
                
                tValue = PhoneTypes.mobile.rawValue
                
            case .home:
                
                tValue = PhoneTypes.home.rawValue
                
            case .work:
                
                tValue = PhoneTypes.work.rawValue
                
            case .main:
                
                tValue = PhoneTypes.main.rawValue
                
            case .workfax:
                
                tValue = PhoneTypes.workfax.rawValue
                
            case .homefax:
                
                tValue = PhoneTypes.homefax.rawValue
                
            case .pager:
                
                tValue = PhoneTypes.pager.rawValue
                
           
                
            }
            
            
        }
        
        if tValue == "" || phoneNum == nil {
            
            return nil
            
        }
        
        else
        {
            return PhoneNumber(number: phoneNum!,type: PhoneTypes(rawValue:tValue)!)

            
        }
            
        }
        
        
    }
    
    
}

let example1 = "work:858-777-9999".asPhoneNumber()

let example2 = ":858-777-9999".asPhoneNumber()

let example3 = "mobile:858-9999".asPhoneNumber()

let example4 = "main:".asPhoneNumber()






//4  Create a Name  structure



struct Name :Comparable{
    
    var FirstName:String;
    var LastName:String;
    
    init(FirstName:String,LastName:String){
        
        self.FirstName = FirstName;
        self.LastName = LastName;
        
    }
    
}

func < (lhs: Name, rhs: Name) -> Bool {
    
    return (lhs.FirstName < rhs.FirstName || lhs.LastName < rhs.LastName )
}




func == (lhs: Name, rhs: Name) -> Bool {
   return (lhs.FirstName == rhs.FirstName && lhs.LastName == rhs.LastName )
}



let name1 = Name(FirstName: "priya" , LastName: "v")

let name2 = Name(FirstName: "priya" , LastName: "v")


let name3 = Name(FirstName: "padmapriya" , LastName: "v")

let name4 = Name(FirstName: "padma" , LastName: "priya")


name1 == name2

name1.LastName == name2.LastName

name2 < name3

name4.FirstName < name3.FirstName

name4.LastName < name2.LastName




//5    Create a Person  class


class Person{
    
    var FirstName:String;
    var LastName:String;
    var arrayOfPhoneNumbers:[PhoneNumber]=[];
    
    
    init(FirstName:String,LastName:String,number:PhoneNumber){
        
        self.FirstName=FirstName;
        self.LastName=LastName;
        self.arrayOfPhoneNumbers.append(number)

        
    }
    init(FirstName:String,LastName:String){
        
        self.FirstName=FirstName;
        self.LastName=LastName;
        
    }
    
   
    
    func addPhoneNumber(number:String, phoneType : PhoneTypes = .home)->(){          //has defaullt .home type
        
        let add = PhoneNumber(number: number, type: phoneType)
        
        if hasNumber(number) == false{     // not adding if the number already exists
        
        arrayOfPhoneNumbers.append(add)
            
        }
    
    
    }
    
    func addPhoneNumber(phoneNumber:PhoneNumber)->(){                              // adds PhoneNumber Instance
        
        if hasNumber(phoneNumber.phoneNumber) == false{     // not adding if the number already exists
 
        
        arrayOfPhoneNumbers.append(phoneNumber)
            
        }
        
    }
    
    func phoneNumber(phoneType:PhoneTypes)->[PhoneNumber]?{                        // checks for particular phone type
        
        var foundNumbers:[PhoneNumber]=[]
        
        foundNumbers = arrayOfPhoneNumbers.filter({$0.phoneType == phoneType })
  
        if foundNumbers.count > 0{
            
            return foundNumbers
        }
        
            
        else{
            
            return nil
            
        }
        
        
      
    }
    
    func hasNumber(number:String) -> Bool{                            // checks for a number
        
        var foundNumbers:[PhoneNumber]=[]
        
        foundNumbers = arrayOfPhoneNumbers.filter({$0.phoneNumber == number })

        if foundNumbers.count > 0{
            
            return true
        }
            
            
        else{
            
            return false
            
        }
        

    }
    
}

let person1 = Person(FirstName: "Perry", LastName: "Mason")

person1.addPhoneNumber("444-467-6868",phoneType:.mobile)

person1.addPhoneNumber(phone1)

person1.addPhoneNumber("333-444-2222")

person1.addPhoneNumber("333-444-2222")

person1.hasNumber("444-467-6868")

person1.phoneNumber(.home)

person1.phoneNumber(.mobile)

person1.arrayOfPhoneNumbers


let person2 = Person(FirstName: "Della", LastName: "Street")

person2.addPhoneNumber("657-467-3223",phoneType:.work)

person1.addPhoneNumber(phone2)

person2.addPhoneNumber("889-258-6868", phoneType: .main)

person2.phoneNumber(.mobile)


let person3 = Person(FirstName: "Paul", LastName: "Drake")

person3.addPhoneNumber("111-222-3333",phoneType:.homefax)

person3.addPhoneNumber("444-555-6666", phoneType: .pager)

person3.phoneNumber(.pager)

person3.arrayOfPhoneNumbers






//6   Create a Contact List  class





class ContactList{
    
    var personList:[Person];
    
    init(){
        
        personList=[];
        
    }
    
    func hasPerson(person:Person)->Bool{      // checks if the person with same First and last name exists
        
        var dupList:[Person]=[]
        
        dupList = personList.filter({$0.FirstName == person.FirstName && $0.LastName == person.LastName  })
        
        if dupList.count > 0 {
            
            return true
        }
        else{
            
            
            return false
        }
        
    }
    
    func addPerson(person:Person)->(){        //adds Person Instance
        
        if hasPerson(person) == false{                          // not adding if the Person already exists
            
        
            personList.append(person)
        }
        
    }
    
    func orderedByName() ->[Person]{                            //sorts list by lastname
        
        let sortedList:[Person]=personList.sort({$0.LastName < $1.LastName})
        
        return sortedList;
        
    }
    
    func phoneNumberFor(lastName:String) -> [PhoneNumber]?{         //Given the lastName returns phone numbers for the first person
        
        var existingPeople:[Person]=[]
        
        for each in personList{
            
            if each.LastName == lastName{
                
                existingPeople.append(each)
                
                
            }
            
        }
        if existingPeople.count > 0{
            
            return existingPeople[0].arrayOfPhoneNumbers
        }
            
        else
        {
            
            return nil
        }
        
        
    }
    
    func nameForNumber(number:String) -> Person?{     // Return the Person with the given phone number
       
        var existingPerson:Person? = nil;
        
        for each in personList{
            
            for eachNumber in each.arrayOfPhoneNumbers{
                
                if eachNumber.phoneNumber == number{
                
                 existingPerson = each;
                }
                
            }
            
        }
       return existingPerson
    }
    
}


let list = ContactList()

list.addPerson(person1)
list.addPerson(person2)
list.addPerson(person3)
list.personList
list.nameForNumber("111-222-3333")
list.orderedByName()
list.phoneNumberFor("Mason")













