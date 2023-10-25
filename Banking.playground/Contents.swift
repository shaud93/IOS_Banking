import UIKit
//interface
protocol bank {
    var customer:String {get set}
    var accountNumber:Int {get set}
    var balance:Double {get set}
    var tag:String {get set}
    
    mutating func deposit(amount:Double)
    mutating func withdraw(amount:Double)
}

//checkings bank
struct checking:bank {
    var customer:String
    var accountNumber:Int
    var balance:Double
    var tag:String = "CHECK"
    var overDraftFee:Bool = false
    
    mutating func deposit(amount:Double) {
        if(self.balance <= 0.00){
            overDraftFee = false
            self.balance += amount
        }
        else{
            self.balance += amount
        }
        
    }
    
    mutating func withdraw(amount:Double) {
        
        if (balance - amount < -300.00){
            print("Insufficient Funds")
        }
        else{
            self.balance -= amount
        }
        if (balance <= 0){
            overDraftFee = true
        }
    }
}

//savings bank
struct savings:bank {
    var customer:String
    var accountNumber:Int
    var balance:Double = 25.00
    var tag:String = "SAVING"
    
    mutating func deposit(amount:Double) {
        self.balance += amount
    }
    
    mutating func withdraw(amount:Double) {
        
        if (balance - amount < 25.00){
            print("Insufficient Funds")
        }
        else{
            self.balance -= amount
        }
    }
    
    func calculateInterest() -> Double{
        return 10/100 * self.balance
    }
}

// business bank
struct business:bank {
    var customer:String
    var accountNumber:Int
    var balance:Double
    var tag:String = "BUSI"
    var overDraftFee:Bool = false
    
    mutating func deposit(amount:Double) {
        if(self.balance <= 0.00){
            overDraftFee = false
            self.balance += amount
        }
        else{
            self.balance += amount
        }
        
    }
    
    mutating func withdraw(amount:Double) {
        
        if (balance - amount < -300.00){
            print("Insufficient Funds")
        }
        else{
            self.balance -= amount
        }
        if (balance <= 0){
            overDraftFee = true
        }
    }
}

//adding billy bank account
var billyCheckings = checking(customer: "Billy Bob", accountNumber: 111111, balance: 100.00)
var billySavings = savings(customer: "Billy Bob", accountNumber: 222222)
var billyBusiness = business(customer: "Billy Bob", accountNumber: 333333, balance: 10000.00)

// adding timmy bank account
var timmyCheckings = checking(customer: "Timmy Tom", accountNumber: 444444, balance: 200.00)
var timmySavings = savings(customer: "Timmy Tom", accountNumber: 555555)
var timmyBusiness = business(customer: "Timmy Tom", accountNumber: 777777, balance: 20000.00)

//adding ronald bank account
var ronaldCheckings = checking(customer: "Ronald Mcdonald", accountNumber: 888888, balance: 300.00)
var ronaldSavings = savings(customer: "Ronald Mcdonald", accountNumber: 999999)
var ronaldBusiness = business(customer: "Ronald Mcdonald", accountNumber: 000000, balance: 30000.00)

// empty bank
var emptyBank = business(customer: "none", accountNumber: 0, balance: 0.00)

// list of all banks
var accounts: [bank] = [billyCheckings, billySavings, billyBusiness, timmySavings, timmyBusiness, timmyCheckings, ronaldSavings, ronaldBusiness, ronaldCheckings]


// returns a list of account by givin name
func findAllAccountByName(name:String) -> Array<bank> {
    var acct = [bank]()
    for x in accounts {
        if (x.customer == name){
            acct.append(x.self)
        }
    }
    return acct
}

// finds account by acct #
func findAccountByAccountNumber(acctNum:Int) -> bank {
    for x in accounts{
        if (x.accountNumber == acctNum){
            return x
        }
    }
    return emptyBank
}


// gets total balance of bank
func totalBank() -> Double {
    var total = 0.00
    
    for x in accounts {
        total += x.balance
    }
    return total
}

// transer money to others account
func zelle(acctNum1:Int, acctNum2:Int, amount:Double){
    if(acctNum1 == acctNum2){
        print("can not transfer to same account")
    }
    else if(findAccountByAccountNumber(acctNum: acctNum1).customer == "none" || findAccountByAccountNumber(acctNum: acctNum2).customer == "none"){
        print("Error Account Do Not Exist")
    }
    else if(findAccountByAccountNumber(acctNum: acctNum1).tag == "SAVING" && findAccountByAccountNumber(acctNum: acctNum1).balance < 25) {
        print("This Savings Acct Balance Is to Low For Transfer")
    }
    else if(findAccountByAccountNumber(acctNum: acctNum1).balance < -300.00){
        print("This Savings Acct Balance Is to Low For Transfer")
    }
    else{
        //deposit the givin amount
        switch acctNum2 {
        case 111111:
            billyCheckings.deposit(amount: amount)
        case 222222:
            billySavings.deposit(amount: amount)
        case 333333:
            billyBusiness.deposit(amount: amount)
        case 444444:
            timmyCheckings.deposit(amount: amount)
        case 555555:
            timmySavings.deposit(amount: amount)
        case 777777:
            timmyBusiness.deposit(amount: amount)
        case 888888:
            ronaldCheckings.deposit(amount: amount)
        case 999999:
            ronaldSavings.deposit(amount: amount)
        default:
            ronaldBusiness.deposit(amount: amount)
        }
        
        //withdraw the givin amount
        switch acctNum1 {
        case 111111:
            billyCheckings.withdraw(amount: amount)
        case 222222:
            billySavings.withdraw(amount: amount)
        case 333333:
            billyBusiness.withdraw(amount: amount)
        case 444444:
            timmyCheckings.withdraw(amount: amount)
        case 555555:
            timmySavings.withdraw(amount: amount)
        case 777777:
            timmyBusiness.withdraw(amount: amount)
        case 888888:
            ronaldCheckings.withdraw(amount: amount)
        case 999999:
            ronaldSavings.withdraw(amount: amount)
        default:
            ronaldBusiness.withdraw(amount: amount)
        }
        
    }
}

// finds All account by customer name
findAllAccountByName(name: "Ronald Mcdonald")
var foundAccount:[bank] = findAllAccountByName(name: "Ronald Mcdonald")
print(foundAccount)

// find Account by Account #0
print(findAccountByAccountNumber(acctNum:999999))

// total balance of bank
totalBank()

//transfer to others
ronaldBusiness.balance
timmyBusiness.balance

zelle(acctNum1: ronaldBusiness.accountNumber, acctNum2: timmyBusiness.accountNumber, amount: 20000)

ronaldBusiness.balance
timmyBusiness.balance

//cx act bal can not go lower than -300
//if act is neg overdraft fee is true
billyCheckings.withdraw(amount: 400.00)
billyCheckings.balance
billyCheckings.overDraftFee

// cx can add to bal
// if bal was neg then positive overdraft fee is false
billyCheckings.deposit(amount: 500)
billyCheckings.balance
billyCheckings.overDraftFee

//cx avings acct can not go lower than 25 [test 1]
billySavings.balance
billySavings.withdraw(amount: 1.00)
billySavings.balance

//cx avings acct can not go lower than 25 [test 2]
billySavings.deposit(amount: 75.00)
billySavings.balance
billySavings.withdraw(amount: 75.00)
billySavings.balance

//calulating cx saving acct monthly interest
billySavings.balance
billySavings.deposit(amount: 75.00)
billySavings.balance
billySavings.calculateInterest()
