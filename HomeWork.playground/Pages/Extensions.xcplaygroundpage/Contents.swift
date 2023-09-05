//: [Protocols](@previous)

import Foundation

// MARK: - Вычисляемые свойства в расширениях

extension Double {
    var asKM: Double { return self / 1000.0 }
    var asM: Double { return self }
    var asCM: Double { return self * 100.0 }
    var asMM: Double { return self * 1000.0 }
}

let length: Double = 25
length.asKM
length.asMM

extension Double {
    var asFT: Double {
        get {
            return self / 0.3048
        }
        set(newValue) {
            self = newValue * 0.3048
        }
    } }
var distance: Double = 100
distance.asFT
distance.asFT = 150


// MARK: - Методы в расширениях

extension Int {
    func repetitions(task: () -> ()) {
        for _ in 0..<self { task() }
    }
}

3.repetitions {
    print("Swift")
}

extension Int {
    mutating func squared() {
        self = self * self
    }
}

var someInt = 4

someInt.squared()


// MARK: - Инициализаторы в расширениях

struct Line {
    var pointOne: (Double, Double)
    var pointTwo: (Double, Double)
}

extension Double {
    init(line: Line) {
        self = sqrt(pow((line.pointTwo.0 - line.pointOne.0), 2) +
                    pow((line.pointTwo.1 - line.pointOne.1), 2))
    }
}
var myLine = Line(pointOne: (10,10), pointTwo: (14,10))
var lineLength = Double(line: myLine)
print(lineLength)


// MARK: - Сабскрипты в расширениях

extension Int {
    subscript(digitIndex: Int)  -> Int {
        var base = 1
        var index = digitIndex
        while index > 0 {
            base *= 10
            index -= 1
        }
        return (self / base) % 10
    }
}

746381295[0]
746381295[1]

// MARK: - Расширения протоколов

/// Подпись объектного типа на протокол
protocol TextRepresentable {
    func asText() -> String
}

extension Int: TextRepresentable {
    func asText() -> String {
        return String(self)
    }
}

print(type(of: 5.asText()))

/// Расширение протоколов и реализации по умолчанию
protocol Descriptional {
    func getDescription() -> String
}

extension Descriptional {
    func getDescription() -> String {
        return "Описание объектного типа"
    }
}

class myClass: Descriptional {}

print(myClass().getDescription())

class myStruct: Descriptional {
    func getDescription() -> String {
        return "Описание структуры"
    }
}

myStruct().getDescription()


extension TextRepresentable {
    func about() -> String {
        return "Данный тип поддерживает протокол TextRepresentable"
    }
}

5.about()
