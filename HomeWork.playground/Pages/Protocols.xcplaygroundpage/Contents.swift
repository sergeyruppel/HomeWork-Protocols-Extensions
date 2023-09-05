import Foundation

// MARK: - Требуемые свойства

protocol SomeProtocol {
    var mustBeSetteble: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

struct SomeStruct: SomeProtocol {
    var mustBeSetteble: Int
    let doesNotNeedToBeSettable: Int
    
    func getSum() -> Int {
        mustBeSetteble + doesNotNeedToBeSettable
    }
}

let someStruct = SomeStruct(mustBeSetteble: 42, doesNotNeedToBeSettable: 1)

print(someStruct.getSum())


protocol AnotherProtocol {
    static var someTypeProp: Int { get }
}

struct AnotherStruct: SomeProtocol, AnotherProtocol {
    var mustBeSetteble: Int
    let doesNotNeedToBeSettable: Int
    static var someTypeProp: Int = 4
    
    func getSum() -> Int {
        mustBeSetteble + doesNotNeedToBeSettable + AnotherStruct.someTypeProp
    }
}

let anotherStruct = AnotherStruct(mustBeSetteble: 33, doesNotNeedToBeSettable: 4)

print(anotherStruct.getSum())


// MARK: - Требуемые методы

protocol RandomNumberGenerator {
    var randomCollection: [Int] { get set }
    func getRandomNumber() -> Int?
    mutating func setNewRandomCollection(newValue: [Int])
}

struct RandomGenerator: RandomNumberGenerator {
    var randomCollection = [1,2,3,4,5]
    func getRandomNumber() -> Int? {
        guard let randomElement = randomCollection.randomElement() else {
            return nil
        }
        return randomElement
    }
    mutating func setNewRandomCollection(newValue: [Int]) {
        self.randomCollection = newValue
    }
}
class RandomGeneratorClass: RandomNumberGenerator {
    var randomCollection: [Int] = [1,2,3,4,5]
    func getRandomNumber() -> Int? {
        guard let randomElement = randomCollection.randomElement() else {
            return nil
        }
        return randomElement
    }
    func setNewRandomCollection(newValue: [Int]) {
        self.randomCollection = newValue
    }
}


let randomGenerator = RandomGenerator()
print(randomGenerator.getRandomNumber()!)

let randomGeneratorClass = RandomGeneratorClass()
randomGeneratorClass.setNewRandomCollection(newValue: Array(0...100))
print(randomGeneratorClass.getRandomNumber()!)


// MARK: - Требуемые инициализаторы

protocol Named {
    init(name: String)
}

class Person: Named {
    var name: String
    required init(name: String) {
        self.name = name
    }
}

let person = Person(name: "Vasya")
print(person.name)


// MARK: - Операторы as? и as!, is

protocol HasValue {
    var value: Int { get set }
}

class ClassWithValue: HasValue {
    var value: Int
    init(value: Int) {
        self.value = value
    }
}

struct StructWithValue: HasValue {
    var value: Int
}

let objects: [Any] = [2,
                      StructWithValue(value: 3),
                      true,
                      ClassWithValue(value: 6),
                      "Usov"]

/// as
for object in objects {
    if let elementWithValue = object as? HasValue {
        print("Значение \(elementWithValue.value)")
    }
}
/// is
for object in objects {
    print(object is HasValue)
}


// MARK: - Наследование протоколов

protocol GeometricFigureWithXAxis {
    var x: Int { get set }
}

protocol GeometricFigureWithYAxis {
    var y: Int { get set }
}

protocol GeometricFigureTwoAxis: GeometricFigureWithXAxis, GeometricFigureWithYAxis {
    var distanceFromCenter: Float { get }
}

struct Figure2D: GeometricFigureTwoAxis {
    var x: Int = 0
    var y: Int = 0
    var distanceFromCenter: Float {
        let xPow = pow(Double(self.x), 2)
        let yPow = pow(Double(self.y), 2)
        let length = sqrt(xPow + yPow)
        return Float(length)
    }
}

let figure = Figure2D(x: 10, y: 6)
print(figure.distanceFromCenter)


// MARK: - Классовые протоколы

protocol SuperProtocol { }
protocol SubProtocol: AnyObject, SuperProtocol { }

class  ClassWithProtocol: SubProtocol { } // correct
// struct StructWithProtocol: SubProtocol { } // error


// MARK: - Композиция протоколов

protocol Named2 {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person2: Named2, Aged {
    var name: String
    var age: Int
}

let birthdayPerson = Person2(name: "Джон Уик", age: 46)

func wishHappyBirthday(celebrator: Named2 & Aged) {
    print("С Днем рождения, \(celebrator.name)! Тебе уже \(celebrator.age)!")
}

wishHappyBirthday(celebrator: birthdayPerson)


//: [Extensions](@next)
