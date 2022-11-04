//
//  Interrupt Line.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension Kernel
{
  /// The universal **cosmOS** interrupt handler.
  static func raise(_ interrupt: any Handleable)
  {
    interruptedProcess = currentProcess
    switchContext(to: Kernel.task)
    interrupt.handle()
    switchContext(to: interruptedProcess)
  }
}
