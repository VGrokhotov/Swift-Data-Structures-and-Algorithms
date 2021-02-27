
public final class Stack<T> {
    
    private var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public func push(_ element: T) {
        array.append(element)
    }
    
    public func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
}
