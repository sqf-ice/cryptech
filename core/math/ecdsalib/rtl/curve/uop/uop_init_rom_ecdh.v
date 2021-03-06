`timescale 1ns / 1ps

module uop_init_rom_ecdh
  (
   input wire 	      clk,
   input wire [ 5: 0] addr,
   output reg [19: 0] data
   );


   //
   // Microcode
   //
`include "../uop_ecdsa.v"


   //
   // Initialization Microprogram for ECDH Mode
   //
   always @(posedge clk)

     case (addr)

       6'd00:	data <= {OPCODE_MOV, UOP_SRC_G_X,  UOP_SRC_DUMMY, UOP_DST_RX, UOP_EXEC_ALWAYS};
       6'd01:	data <= {OPCODE_MOV, UOP_SRC_G_Y,  UOP_SRC_DUMMY, UOP_DST_RY, UOP_EXEC_ALWAYS};
       6'd02:	data <= {OPCODE_MOV, UOP_SRC_ONE,  UOP_SRC_DUMMY, UOP_DST_RZ, UOP_EXEC_ALWAYS};

       default:	data <= {OPCODE_RDY, UOP_SRC_DUMMY, UOP_SRC_DUMMY, UOP_DST_DUMMY, UOP_EXEC_ALWAYS};

     endcase


endmodule
