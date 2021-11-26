import UIKit

var str = "Hello, playground"
print(str)
let median = findMedianSortedArrays([], [1])
private func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    var nums: [Int] = nums1
    nums.append(contentsOf: nums2)
    nums.sort()
    if nums.count % 2 == 0{
       return Double(nums[nums.count/2] + nums[nums.count/2-1])/2
    }else{
        return Double(nums[Int(nums.count/2)])
    }
}
print(median)
func isPalindrome(x: Int) -> Bool {
    var reverse = 0
    var num = x
    while(num > 0){
        let digit = num % 10
        reverse = reverse * 10 + digit
        num = num / 10
    }
    return reverse == x ? true : false
}
print(isPalindrome(x: 96633669))

func solution(numbers: [Int]) -> Int {
    let num = numbers.sorted()
    return num.isEmpty ? 0 : num[num.count-1]
}
print(solution(numbers: [8,6,12,5,23,45,35,99,43]))
print(solution(numbers: []))
func solution(arr: [Int]) -> String {
    if (arr.isEmpty) {
        return ""
    }
    let left = sum(arr: arr, idx: 2)
    let right = sum(arr: arr, idx: 3)
    return left == right ? "" : (left > right ) ? "Left" : "Right"
}
func sum(arr:[Int], idx:Int) -> Int{
    if(idx-1 < arr.count){
        if(arr[idx-1] == -1){
            return 0
        }
        return arr[idx-1] + sum(arr: arr, idx: idx*2) + sum(arr:arr, idx: idx*2+1)
    }
    return 0
}
print(solution(arr: [3,6,2,9,-1,10,]))


func solution(keys: [String], values: [Int], capacity: Int) -> [[Int]] {
    // Cache the provided keys and values (in order), then return the concatenated contents of the cache after each write
    let cache = LRUCache<String, Int>(capacity: capacity)
    var results = [[Int]]()
    for (key, value) in zip(keys, values) {
        cache.addValue(value, for: key)
        if let value = cache.getValue(for: key){
            results.append([value])
        }
        
    }
    return results
}
typealias DoublyLinkedListNode<T> = DoublyLinkedList<T>.Node<T>

final class DoublyLinkedList<T>{
    final class Node<T> {
        var payLoad: T
           var prev : Node<T>?
           var next : Node<T>?
        init(payload : T) {
            self.payLoad = payload
        }
   }
    private(set) var count: Int = 0
    private var head, tail : Node<T>?
    func addHEAD(_ payload: T) -> Node<T> {
        let node = Node(payload: payload)
        defer {
            head = node
            count += 1
        }
        guard let head = head else {
            tail = node
            return node
        }
        head.prev = node
        node.prev = nil
        node.next = head
        return node
    }
    func moveToHead(_ node: Node<T>){
        guard node !== head else { return }
        let prev = node.prev
        let next = node.next
        prev?.next = next
        next?.prev = prev
        
        node.next = head
        node.prev = nil
        if node === tail {
            tail = prev
        }
        self.head = node
    }
    func removeLast() -> Node<T>? {
        guard let tail = self.tail else { return nil }
        let prev = tail.prev
        prev?.next = nil
        self.tail = prev
        if count == 1 {
            head = nil
        }
        count -= 1
        return tail
    }
    
}
final class LRUCache<Key: Hashable, Value>{
    private struct CachePayload {
        let key : Key
        let value : Value
    }
    private let list = DoublyLinkedList<CachePayload>()
    private var nodesDict = [Key : DoublyLinkedListNode<CachePayload>]()
    private let capacity: Int
    init(capacity : Int) {
        self.capacity = max(0, capacity)
    }
    func addValue(_ value : Value, for key : Key) {
        let payLoad = CachePayload(key: key, value: value)
        
        if let node = nodesDict[key]{
            node.payLoad = payLoad
            list.moveToHead(node)
        }else {
            let node = list.addHEAD(payLoad)
            nodesDict[key] = node
        }
        
        if list.count > capacity {
            let nodeRemoved = list.removeLast()
            if let key = nodeRemoved?.payLoad.key {
                nodesDict[key] = nil
            }
        }
    }
    
    func getValue(for key : Key) -> Value? {
        guard let node = nodesDict[key] else { return nil }
        list.moveToHead(node)
        return node.payLoad.value
    }
    
}

let cache = LRUCache<Int, String>(capacity: 2)
cache.addValue("a", for: 1)
cache.getValue(for: 1)
cache.addValue("b", for: 2)
cache.getValue(for: 1)
cache.addValue("c", for: 3)
cache.getValue(for: 2)
cache.addValue("d", for: 3)
cache.getValue(for: 2)
cache.getValue(for: 3)
cache.getValue(for: 1)
// max sum of conecutive integers
func solution2(numbers: [Int]) -> Int {
    if numbers.isEmpty {
        return 0
    }else if numbers.count == 1 {
        return numbers[0]
    }
    var set : Set<Int> = Set<Int>()
    var maxSum = 0
    for i in 0 ..< numbers.count - 1 {
        if(numbers[i+1] - numbers[i] == 1){
            set.insert(numbers[i])
            set.insert(numbers[i+1])
        }else{
            let tempSum = set.reduce(0, +)
            set.removeAll()
            maxSum = tempSum > maxSum ? tempSum : maxSum
        }
        let tempSum = set.reduce(0, +)
        maxSum = tempSum > maxSum ? tempSum : maxSum
    }
    print(set)
    return maxSum
}
print(solution2(numbers: [1,3,4,5,9,10,6]))
print([1,2,3,3].map(Double.init).map {pow($0, $0)} == [1,4,9,16])
print([1,2,3,4].compactMap{$0 % 2 == 0 ? $0 : nil} )

var valueToPass = "foo"
var updated = valueToPass + "bar"
print(updated)
final class Item {
    let value: Int
    init(value : Int) {
        self.value = value
    }
    func log()  {
        print("\(self.value)")
    }
}
func addAndOutput(_ items:[Item?], to start: Int = 5){
    let result = items
        .compactMap{$0?.value}
        .reduce(start, +)
    print("\(result)")
    
}
let items = [Item(value: 4), nil, Item(value: 2)]
items.forEach {$0?.log()}
addAndOutput(items)

func isPalindrome(_ value: String) -> Bool
{
    let len = value.count / 2

    for i in 0..<len
    {
        let start = value.index(value.startIndex, offsetBy: i)
        let end = value.index(value.endIndex, offsetBy: (i * -1) - 1)

        if value[start] != value[end] {
            return false
        }
    }

    return true
}
print(isPalindrome("122331"))

class A {
    var a = 10
}
class B {
    var a = 10
}
var a = A()
var b = a
print(a === b)
var view = UIView()
let view1 = UIView(frame: .init(x:50, y:50, width: 100, height: 100))
view.addSubview(view1)
let view2 = UIView(frame: .init(x:10, y:0, width: 100, height: 100))
view1.addSubview(view2)
let origin = view.convert(view2.bounds.origin, from:view2)
print(origin)



struct RequestError: Error {
    let info: String?
}
func downloadData(completion: @escaping (Result<Data,RequestError>) -> Void){
                    let request = URLRequest(url: URL(string: "https://test-api.hired.com/endpoint")!)
                    URLSession.shared.dataTask(with : request){
                    data, _, error in
                    if error == nil, let data = data {
                    completion(.success(data))
                    }else{
                    completion(.failure(.init(info: error?.localizedDescription)))
                    }
                    }
                    
}
print(downloadData{ result in
    switch result {
    case .success(let data):
        print("Received \(data.count) bytes")
    case .failure(let error):
        print("Request failed with error: \(error)")
    }
})

func solutionTanks(tanks:[[Int]], guesses: [[Int]]) -> [String]{
    var result = [String]()
    for guess in guesses{
        for (i, tank) in tanks.enumerated() {
            if guess[0] == tank[0] {
                if guess[1] == tank[1] {
                    result.append("h")
                    break
                }else if guess[1] - tank[1] == 1 || guess[1] - tank[1] == -1 {
                    result.append("nh")
                    break
                }else {
                    result.append("m")
                    break
                }
            }else {
                if(i == tanks.count-1){
                    result.append("m")
                }
            }
        }
        
    }
  
    return result
}
print(solutionTanks(tanks: [[3,2],[0,3],[1,2],[4,1]], guesses: [[0,5],[3,1],[2,2],[1,2]]))

func bounceSolution(steps : [Int]) -> Int {
    let min = steps.filter{$0 > 0}.min()
    var count = 0
    for i in 0...steps.count-2 {
        if (steps[i+1] == min) {
            count += 1
        }
    }
    return count
}
print(bounceSolution(steps: [0,3,0,2,4,1,3,2,3,1,2,1]))

public class Invoice {
    
    var invoiceNumber: Int
    var invoiceDate: Date
    var lineItems : [InvoiceLine]
    
    init(_ invoiceNumber:Int,_ invoiceDate :Date, _ lineItems : [InvoiceLine]) {
        self.invoiceNumber = invoiceNumber
        self.invoiceDate = invoiceDate
        self.lineItems = lineItems
   }
    func mergeInvoices(sourceInvoice: Invoice) {
        //TODO need to implement
        lineItems.append(contentsOf: sourceInvoice.lineItems)
    }
    
    func clone() -> Invoice {
        //TODO need to implement
        return Invoice(self.invoiceNumber, self.invoiceDate, self.lineItems)
    }
    
    func toString() -> String {
        //TODO need to implement
        return "Invoice Number: \(invoiceNumber), InvoiceDate: \(convertDateToDD_MM_YYYY(invoiceDate)), LineItemCount: \(lineItems.count), lineItemid: \(lineItems[0].description)"
    }
    
    func convertDateToDD_MM_YYYY(_ date : Date)-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        formatter.timeZone = TimeZone(abbreviation: "UTC")

        return formatter.string(from: date as Date)
    }
    
    
}
public class InvoiceLine {
    
    var invoiceLineId: Int
    var description: String
    var quantity: Int
    var cost: Double
    
    init(invoiceLineId: Int, description: String, quantity: Int, cost: Double) {
        self.invoiceLineId = invoiceLineId
        self.description = description
        self.quantity = quantity
        self.cost = cost
    }
}

var fruit = ["bar", "mango", "grapes", "orange"]
var veg = ["potato", "onion","beans"]
fruit.append(contentsOf: veg)
print(fruit)
print(fruit.enumerated().filter{$0.offset <= 3})

print(fruit)

func convertDate(){
            let date = Date.init()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            formatter.timeZone = TimeZone(abbreviation: "UTC")

            let strdate1 = formatter.string(from: date as Date)

            print(strdate1)
}

print(convertDate())

var invoice1 = Invoice(1, Date.init(), [InvoiceLine(invoiceLineId: 1, description: "cake", quantity: 1, cost: 5)])

var invoice2 = invoice1.clone()
print(invoice1.toString())

print(invoice2.toString())

print(invoice1 === invoice2)







