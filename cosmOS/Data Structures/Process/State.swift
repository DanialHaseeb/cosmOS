//
//  State.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension Process
{
  /// The set of states of a process.
  enum State
  {
    /// The starting state.
    ///
    /// A process is in this state when it has been instantiated
    /// but has not entered the **cosmOS** dispatcher.
    case new
    
    /// A process in this state exists in one of the dispatch queues of **cosmOS**.
    case ready
    
    /// A process in this state is fetching (and decoding) an instruction from main memory.
    case fetching
    
    /// A process in this state has its instruction being executed by the virtual core.
    case executing
    
    /// A process may transition to this state, either by completing its execution or by explicitly being killed.
    case terminated
  }
}
