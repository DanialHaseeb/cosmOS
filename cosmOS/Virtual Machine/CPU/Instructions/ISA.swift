//
//  ISA.swift
//  cosmOS
//
//  Created by Danial Haseeb on 05/11/2022.
//

extension Core
{
  /// The dictionary that maps each opcode to its corresponding instruction in the virtual machine's ISA.
  static let ISA: [Byte: Instruction] =
  [
    // Register-Register
    0x16: MOV,
    0x17: ADD, 0x18: SUB,
    0x19: MUL, 0x1A: DIV,
    0x1B: AND, 0x1C: OR,

    // Register-Immediate
    0x30: MOVI,
    0x31: ADDI, 0x32: SUBI,
    0x33: MULI, 0x34: DIVI,
    0x35: ANDI, 0x36: ORI,

    // Control Flow
    0x37: BZ,  0x38: BNZ,
    0x39: BC,  0x3A: BS,
    0x3B: JMP, 0x3C: CALL,
    0x3D: ACT,

    // Memory
    0x51: MOVL, 0x52: MOVS,

    // Register
    0x71: SHL,  0x72: SHR,
    0x73: RTL,  0x74: RTR,
    0x75: INC,  0x76: DEC,
    0x77: PUSH, 0x78: POP,

    // No-Operand
    0xF1: RETURN,
    0xF2: NOOP,
    0xF3: END
  ]
}
