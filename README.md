# Swift Data Structures and Algorithms

* [Stack](#Stack)
* [Queue](#Queue)
* [HashMap on Chains](#HashMap-on-Chains)
* [HashMap on Open Addressing](#HashMap-on-Open-Addressing)

## Stack
TODO

## Queue
Queue implementation in Swift

### How to use

1. The initialization
```swift
let queue: Queue<Int> = Queue()
```

2. The insertion of element
```swift
queue.enqueue(3)
```

3. The check are there any elements in the queue
```swift
if !queue.isEmpty {
    // Some code here
}
```

4. The extraction of the element
```swift
// Use unwarping only when the queue is not Empty
let queueHead = queue.dequeue()!
```

5. The amount of elements in the queue
```swift
let amount = queue.count
```

6. The peek value
```swift
// Could be nil
let head = queue.peek()
```

## HashMap on Chains
TODO

## HashMap on Open Addressing
TODO
