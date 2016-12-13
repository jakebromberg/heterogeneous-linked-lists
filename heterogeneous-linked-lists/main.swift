protocol NodeType {
    associatedtype ValueType
    var value : ValueType { get }
}

struct TerminatingNode<ValueType> : NodeType {
    let value : ValueType
}

struct Node<ValueType, NextNodeType: NodeType> : NodeType {
    let value : ValueType
    let next : NextNodeType
}

let a = TerminatingNode(value: 123)
var b = Node(value: 456, next: a)
var c = Node(value: "asdf", next: b)
var d = Node(value: 123, next: c)

assert(d.value == 123)
assert(d.next.value == "asdf")
assert(d.next.next.value == 456)
assert(d.next.next.next.value == 123)
assert(d.value == a.value)
assert(type(of:d.value) == Int.self)
assert(type(of:d.next.value) == String.self)
