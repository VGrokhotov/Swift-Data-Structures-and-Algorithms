
//Hashmap on chains
public final class HashMap<Key: Hashable, Value> {
    
    private typealias Element = (key: Key, value: Value)
    private typealias Chain = [Element]
    
    private var chains: [Chain]
    
    private(set) public var count = 0 {
        didSet {
            if loadFactor > 0.75 {
                resize()
            }
        }
    }
    
    private var loadFactor: Double {
        return Double(count) / Double(chains.count)
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public init(capacity: Int = 11) {
        assert(capacity > 0)
        chains = Array<Chain>(repeating: [], count: capacity)
    }
    
    private func index(for key: Key) -> Int {
        return abs(key.hashValue) % chains.count
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
    
    public func value(for key: Key) -> Value? {
        let index = self.index(for: key)
        return chains[index].first { $0.key == key }?.value
    }
    
    public func update(value: Value, for key: Key) -> Value? {
        
        let index = self.index(for: key)
        
        if let (i, element) = chains[index].enumerated().first(where: { $0.1.key == key }) {
            let oldValue = element.value
            chains[index][i].value = value
            return oldValue
        }
        
        chains[index].append((key: key, value: value))
        count += 1
        
        return nil
    }
    
    public func removeValue(for key: Key) -> Value? {
        
        let index = self.index(for: key)
        
        if let (i, element) = chains[index].enumerated().first(where: { $0.1.key == key }) {
            chains[index].remove(at: i)
            count -= 1
            return element.value
        }
        
        return nil
    }
    
    private func resize() {
        
        count = 0
        
        let oldChains = chains
        
        let newSize = chains.count * 2
        chains = Array<Chain>(repeating: [], count: newSize)
        
        for chain in oldChains {
            for (key, value) in chain {
                update(value: value, for: key)
            }
        }
    }
    
}
