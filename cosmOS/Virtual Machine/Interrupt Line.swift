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
    switch interrupt
    {
      case let interrupt as Programme.Interrupt:
        interrupt.handle()
      case let interrupt as Process.Interrupt:
        interrupt.handle()
      default:
        interrupt.handle()
    }
  }
}
