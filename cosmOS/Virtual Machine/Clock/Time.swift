//
//  Time.swift
//  cosmOS
//
//  Created by Danial Haseeb on 04/11/2022.
//

extension Clock
{
  /// The system time.
  ///
  /// Measured as a monotonically non-decreasing integer that increments by 1 each clock cycle.
  typealias Time = Int
  
  /// The current time on the system clock.
  static var time = Time(0)
}
