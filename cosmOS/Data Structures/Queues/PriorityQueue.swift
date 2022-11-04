//
//  Queue.swift
//  cosmOS
//
//  Created by Danial Haseeb on 31/10/2022.
//

/// A collection of entities that are maintained in a sequence.
///
/// Queues can be mutated by the addition of entities at one end and the removal of entities from the other.
struct PriorityQueue<Element: Comparable>
{
  var elements: [Element] = Array()
  
  /// Creates a new, empty priority queue.
  ///
  /// - Parameter elements: The sequence of elements to turn into a priority queue.
  init(_ elements: [Element])
  { self.elements = elements }
  
  /// Enqueues a new element to the priority queue.
  ///
  /// - Complexity: O(_n_ log _n_), where _n_ is the length of the priority queue.
  mutating func enqueue(_ element: Element)
  {
    elements.append(element)
    elements.sort()
  }
  
  /// Dequeues and returns the highest-priority element of the priority queue.
  ///
  /// Use this method to append a single element to the back of a queue.
  ///
  /// - Complexity: O(1)
  mutating func dequeue() -> Element?
  { elements.popLast() }
  
  /// The first element of the queue.
  ///
  /// If the queue is empty, the value of this property is `nil`.
  var first: Element?
  { elements.first }
  
  /// A Boolean value indicating whether the queue is empty.
  ///
  /// - Complexity: O(1)
  var isEmpty: Bool
  { elements.isEmpty }
}

extension PriorityQueue: CustomStringConvertible
{
  /// A textual representation of this queue.
  var description: String
  { elements.description }
}

extension PriorityQueue: ExpressibleByArrayLiteral
{
  init(arrayLiteral elements: Element...)
  { self.init(elements) }
}
