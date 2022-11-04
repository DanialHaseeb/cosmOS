//
//  Core.swift
//  cosmOS
//
//  Created by Danial Haseeb on 29/10/2022.
//

/// The virtual machine's processing core.
class Core
{
  /// The current state of the virtual machine core.
  static var state = Process.State.ready
  
  /// Copies the process control block of the given process into the virtual machine core's registers.
  static func load(_ process: Process)
  {
    state = process.state
    R = process.R
    S = process.S
  }
}
