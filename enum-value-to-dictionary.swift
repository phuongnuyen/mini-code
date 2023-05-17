enum MyEnum {
    case optionA(String)
    case optionB(a: Int, b: Double, c: [String])

    func toDictionary() -> [String: Any] {
        let enumMirror = Mirror(reflecting: self)
        guard enumMirror.displayStyle == .enum,
            let firstChild = enumMirror.children.first,
            let label = firstChild.label else {
            return [:]
        }
        
        let associatedValues = firstChild.value
        let valueMirror = Mirror(reflecting: associatedValues)
        let valueDic = valueMirror.children.reduce(into: [String: Any]()) { partialResult, item in
            if let key = item.label {
                partialResult[key] = item.value
            }
        }
        return [label: valueDic]
    }
}
let myValue = MyEnum.optionB(a: 42, b: 3.14, c: ["1", "2"])
print(myValue.toDictionary())
