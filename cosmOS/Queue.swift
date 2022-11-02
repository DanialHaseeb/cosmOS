//
//  Queue.swift
//  cosmOS
//
//  Created by Danial Haseeb on 31/10/2022.
//

/// A collection of entities that are maintained in a sequence.
///
/// Queues can be mutated by the addition of entities at one end and the removal of entities from the other.
struct Queue<Element>
{
  private var elements: [Element]
  
  /// Creates a new, empty queue.
  ///
  /// - Parameter elements: The sequence of elements to turn into a queue.
  init(_ elements: [Element])
  { self.elements = elements }
  
  /// Enqueues a new element to the back of the queue.
  ///
  /// Use this method to append a single element to the back of a queue.
  ///
  /// - Complexity: O(1)
  mutating func enqueue(element: Element)
  { elements.append(element) }
  
  /// Dequeues and returns the first element  of the queue.
  ///
  /// - Complexity: O(n)
  ///
  /// - Returns: The dequeued element or `nil` if the queue is empty.
  mutating func dequeue() -> Element?
  {
    guard !(self.isEmpty) else
    { return nil }
    
    return elements.removeFirst()
  }
  
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

extension Queue: CustomStringConvertible
{
  /// A textual representation of this queue.
  var description: String
  { elements.description }
}

extension Queue: ExpressibleByArrayLiteral
{
  init(arrayLiteral elements: Element...)
  { self.init(elements) }
}
