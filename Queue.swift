public final class Queue<T> {
    
    private final class QNode<T> {
        var value: T
        var next: QNode?
        
        init (value: T) {
            self.value = value
        }
    }
    
    private var tail: QNode<T>?
    private var head: QNode<T>?
    private(set) var count: Int = 0
    
    public var isEmpty: Bool {
        guard head?.value != nil else { return true }
        return false
    }
    
    
    public func dequeue() -> T? {
        
        if let node = head {
            head = head?.next
            count -= 1
            if isEmpty {
                tail = nil
            }
            return node.value
        }
        
        return nil
    }
    
    public func enqueue(_ value: T) {
        
        let newNode = QNode(value: value)
        
        if let tailNode = tail {
            tailNode.next = newNode
            newNode.next = nil
            tail = newNode
        } else {
            head = newNode
            tail = newNode
        }
    
        count += 1
    }
    
    public func peek() -> T? {
        return head?.value
    }
}
