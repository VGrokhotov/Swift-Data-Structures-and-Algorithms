public final class HashMap<Key: Hashable, Value> {
    
    private let GAP = 307
    
    private var loadFactor: Double {
        return Double(count) / Double(items.count)
    }
    
    private(set) public var count = 0 {
        didSet {
            if loadFactor > 0.7 {
                resize()
            }
        }
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    fileprivate typealias Element = (key: Key, value: Value)
    fileprivate var items: [Element?]
    private var deleted: [Bool]
    
    
    public init(capacity: Int = 11) {
        assert(capacity > 0)
        items = Array(repeating: nil, count: capacity)
        deleted = Array(repeating: false, count: capacity)
    }
    
    private func index(for key: Key) -> Int {
        return abs(key.hashValue) % items.count
    }
    
    private func indexInTable(_ key: Key) -> Int {
        
        var hash = index(for: key)
        
        let firstHash = hash
        
        while deleted[hash] || items[hash] != nil && key != items[hash]?.key {
            hash = (hash + GAP) % items.count
            if (hash == firstHash){
                return indexToPut(key)
            }
        }
        
        return hash
    }
    
    private func indexToPut(_ key: Key) -> Int {
        
        var hash = index(for: key)
        
        while items[hash] != nil {
            hash = (hash + GAP) % items.count
        }
        
        return hash
    }
    
    public func update(value: Value, for key: Key) -> Value? {
        
        var index = indexInTable(key)
        
        guard
            let oldValue = items[index]?.value
        else {
            index = indexToPut(key);
            
            if (deleted[index]) {
                deleted[index] = false;
            }
            
            items[index] = (key: key, value: value)
            count += 1
            
            return nil
        }
        
        items[index]?.value = value
        return oldValue
    }
    
    public func value(for key: Key) -> Value? {
        
        let index = indexInTable(key)
        
        return items[index]?.value
    }
    
    public func removeValue(for key: Key) -> Value? {
        
        let index = indexInTable(key)
        
        guard let element = items[index] else {
            return nil
        }
        
        deleted[index] = true
        items.remove(at: index)
        count -= 1
        
        return element.value
    }
    
    private func resize() {
        
        let oldItems = items
        let newSize = items.count * 2
        
        items = Array(repeating: nil, count: newSize)
        deleted = Array(repeating: false, count: newSize)
        count = 0;
        
        for element in oldItems {
            if let (key, value) = element {
                update(value: value, for: key)
            }
        }
    }
    
    public subscript(key: Key) -> Value? {
        get {
            return value(for: key)
        }
        set {
            if let value = newValue {
                update(value: value, for: key)
            } else {
                removeValue(for: key)
            }
        }
    }
    
}
