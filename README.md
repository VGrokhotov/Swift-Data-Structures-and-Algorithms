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

3. The check is any elements in the queue
```swift
if !queue.isEmpty {
    // Some code here
}
```

4. The extraction of element
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
