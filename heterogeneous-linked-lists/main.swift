protocol NodeType {
    associatedtype ValueType
    var value : ValueType { get }
}

struct TerminatingNode<ValueType> : NodeType {
    let value : ValueType
}

struct ListNode<ValueType, NextNodeType: NodeType> : NodeType {
    let value : ValueType
    let next : NextNodeType
}

let a = TerminatingNode(value: 123)
var b = ListNode(value: 456, next: a)
var c = ListNode(value: "asdf", next: b)

assert(c.value == "asdf")
assert(c.next.value == 456)
assert(c.next.next.value == 123)
assert(type(of:c.next.value) != type(of:c.value))

extension NodeType {
    func prepend<U>(value: U) -> ListNode<U, Self> {
        return ListNode(value: value, next: self)
    }
}

precedencegroup ListInfixPrecedence {
    associativity: right
}

infix operator >>> : ListInfixPrecedence

func >>><T, U: NodeType>(lhs: T, rhs: U) -> ListNode<T, U> {
    return ListNode(value: lhs, next: rhs)
}

prefix operator >>>

func >>><T, U>(lhs: T, rhs: U) -> ListNode<T, TerminatingNode<U>> {
    return TerminatingNode(value: rhs).prepend(value: lhs)
}

let list = "asdf" >>> 456 >>> 123
assert(list.value == c.value)
assert(list.next.value == c.next.value)
assert(list.next.next.value == c.next.next.value)
