//------------------------------------------------------------------------------
//
// point_mul_384.v
// -----------------------------------------------------------------------------
// Elliptic curve point scalar multiplier.
//
// Authors: Pavel Shatov
//
// Copyright (c) 2018, NORDUnet A/S
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// - Neither the name of the NORDUnet nor the names of its contributors may be
//   used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
//
//------------------------------------------------------------------------------

module point_mul_384
  (
   clk, rst_n,
   ena, rdy,
   k_addr, qx_addr, qy_addr, rx_addr, ry_addr,
   rx_wren, ry_wren,
   k_din, qx_din, qy_din,
   rx_dout, ry_dout
   );


   //
   // Constants
   //
   localparam	WORD_COUNTER_WIDTH	=  4;	// 0 .. 11
   localparam	OPERAND_NUM_WORDS	= 12;	// 12 * 32 = 384


   //
   // Ports
   //
   input	wire		clk;		// system clock
   input	wire		rst_n;		// active-low async reset

   input	wire		ena;		// enable input
   output	wire 		rdy;		// ready output

   output	wire [ 3: 0] 	k_addr;
   output	wire [ 3: 0] 	qx_addr;
   output	wire [ 3: 0] 	qy_addr;
   output	wire [ 3: 0] 	rx_addr;
   output	wire [ 3: 0] 	ry_addr;

   output	wire 		rx_wren;
   output	wire 		ry_wren;

   input	wire [31: 0]	k_din;
   input	wire [31: 0]	qx_din;
   input	wire [31: 0]	qy_din;   

   output	wire [31: 0]	rx_dout;
   output	wire [31: 0]	ry_dout;


   //
   // Temporary Variables
   //
   reg [ 3: 0]		bram_tx_wr_addr;
   reg [ 3: 0]		bram_ty_wr_addr;
   reg [ 3: 0]		bram_tz_wr_addr;

   reg [ 3: 0]		bram_rx_wr_addr;
   reg [ 3: 0]		bram_ry_wr_addr;
   reg [ 3: 0]		bram_rz_wr_addr;
   wire [ 3: 0] 	bram_rz1_wr_addr;

   wire [ 3: 0] 	bram_hx_wr_addr;
	wire [ 3: 0] 	bram_hy_wr_addr;
   
   reg [ 3: 0] 		bram_tx_rd_addr;
   reg [ 3: 0] 		bram_ty_rd_addr;
   reg [ 3: 0] 		bram_tz_rd_addr;

   reg [ 3: 0] 		bram_rx_rd_addr;
   reg [ 3: 0] 		bram_ry_rd_addr;
   reg [ 3: 0] 		bram_rz_rd_addr;
   wire [ 3: 0] 	bram_rz1_rd_addr;

	wire [ 3: 0] 	bram_hx_rd_addr;
	wire [ 3: 0] 	bram_hy_rd_addr;

   reg 			bram_tx_wr_en;
   reg 			bram_ty_wr_en;
   reg 			bram_tz_wr_en;

   reg 			bram_rx_wr_en;
   reg 			bram_ry_wr_en;
   reg 			bram_rz_wr_en;
   wire 		bram_rz1_wr_en;

	wire 		bram_hx_wr_en;
	wire 		bram_hy_wr_en;

   wire [31: 0] 	bram_tx_rd_data;
   wire [31: 0] 	bram_ty_rd_data;
   wire [31: 0] 	bram_tz_rd_data;

   wire [31: 0] 	bram_rx_rd_data;
   wire [31: 0] 	bram_ry_rd_data;
   wire [31: 0] 	bram_rz_rd_data;
   wire [31: 0] 	bram_rz1_rd_data;

	wire [31: 0] 	bram_hx_rd_data;
	wire [31: 0] 	bram_hy_rd_data;

   reg [31: 0] 		bram_tx_wr_data_in;
   reg [31: 0] 		bram_ty_wr_data_in;
   reg [31: 0] 		bram_tz_wr_data_in;

   reg [31: 0] 		bram_rx_wr_data_in;
   reg [31: 0] 		bram_ry_wr_data_in;
   reg [31: 0] 		bram_rz_wr_data_in;
   wire [31: 0] 	bram_rz1_wr_data_in;

	wire [31: 0] 	bram_hx_wr_data_in;
	wire [31: 0] 	bram_hy_wr_data_in;

   wire [31: 0] 	bram_tx_wr_data_out;
   wire [31: 0] 	bram_ty_wr_data_out;
   wire [31: 0] 	bram_tz_wr_data_out;

   wire [31: 0] 	bram_rx_wr_data_out;
   wire [31: 0] 	bram_ry_wr_data_out;
   wire [31: 0] 	bram_rz_wr_data_out;

   bram_1rw_1ro_readfirst # (.MEM_WIDTH(32), .MEM_ADDR_BITS(4))
   bram_tx (.clk(clk),
	    .a_addr(bram_tx_wr_addr), .a_wr(bram_tx_wr_en), .a_in(bram_tx_wr_data_in), .a_out(bram_tx_wr_data_out),
	    .b_addr(bram_tx_rd_addr),                                                  .b_out(bram_tx_rd_data));

   bram_1rw_1ro_readfirst # (.MEM_WIDTH(32), .MEM_ADDR_BITS(4))
   bram_ty (.clk(clk),
	    .a_addr(bram_ty_wr_addr), .a_wr(bram_ty_wr_en), .a_in(bram_ty_wr_data_in), .a_out(bram_ty_wr_data_out),
	    .b_addr(bram_ty_rd_addr),                                                  .b_out(bram_ty_rd_data));

   bram_1rw_1ro_readfirst # (.MEM_WIDTH(32), .MEM_ADDR_BITS(4))
   bram_tz (.clk(clk),
	    .a_addr(bram_tz_wr_addr), .a_wr(bram_tz_wr_en), .a_in(bram_tz_wr_data_in), .a_out(bram_tz_wr_data_out),
	    .b_addr(bram_tz_rd_addr),                                                  .b_out(bram_tz_rd_data));

   bram_1rw_1ro_readfirst # (.MEM_WIDTH(32), .MEM_ADDR_BITS(4))
   bram_rx (.clk(clk),
	    .a_addr(bram_rx_wr_addr), .a_wr(bram_rx_wr_en), .a_in(bram_rx_wr_data_in), .a_out(bram_rx_wr_data_out),
	    .b_addr(bram_rx_rd_addr),                                                  .b_out(bram_rx_rd_data));

   bram_1rw_1ro_readfirst # (.MEM_WIDTH(32), .MEM_ADDR_BITS(4))
   bram_ry (.clk(clk),
	    .a_addr(bram_ry_wr_addr), .a_wr(bram_ry_wr_en), .a_in(bram_ry_wr_data_in), .a_out(bram_ry_wr_data_out),
	    .b_addr(bram_ry_rd_addr),                                                  .b_out(bram_ry_rd_data));

   bram_1rw_1ro_readfirst # (.MEM_WIDTH(32), .MEM_ADDR_BITS(4))
   bram_rz (.clk(clk),
	    .a_addr(bram_rz_wr_addr), .a_wr(bram_rz_wr_en), .a_in(bram_rz_wr_data_in), .a_out(bram_rz_wr_data_out),
	    .b_addr(bram_rz_rd_addr),                                                  .b_out(bram_rz_rd_data));

   bram_1rw_1ro_readfirst # (.MEM_WIDTH(32), .MEM_ADDR_BITS(4))
   bram_rz1 (.clk(clk),
	     .a_addr(bram_rz1_wr_addr), .a_wr(bram_rz1_wr_en), .a_in(bram_rz1_wr_data_in), .a_out(),
	     .b_addr(bram_rz1_rd_addr),                                                    .b_out(bram_rz1_rd_data));

   bram_1rw_1ro_readfirst # (.MEM_WIDTH(32), .MEM_ADDR_BITS(4))
   bram_hx (.clk(clk),
	     .a_addr(bram_hx_wr_addr), .a_wr(bram_hx_wr_en), .a_in(bram_hx_wr_data_in), .a_out(),
	     .b_addr(bram_hx_rd_addr),                                                  .b_out(bram_hx_rd_data));

   bram_1rw_1ro_readfirst # (.MEM_WIDTH(32), .MEM_ADDR_BITS(4))
   bram_hy (.clk(clk),
	     .a_addr(bram_hy_wr_addr), .a_wr(bram_hy_wr_en), .a_in(bram_hy_wr_data_in), .a_out(),
	     .b_addr(bram_hy_rd_addr),                                                  .b_out(bram_hy_rd_data));


   //
   // FSM
   //
   localparam	[ 4: 0]	FSM_STATE_IDLE								= 5'd00;

   localparam	[ 4: 0]	FSM_STATE_PRECOMPUTE_PREPARE_TRIG	= {1'b0, 4'd01};
   localparam	[ 4: 0]	FSM_STATE_PRECOMPUTE_PREPARE_WAIT	= {1'b0, 4'd02};
   localparam	[ 4: 0]	FSM_STATE_PRECOMPUTE_DOUBLE_TRIG		= {1'b0, 4'd03};
   localparam	[ 4: 0]	FSM_STATE_PRECOMPUTE_DOUBLE_WAIT		= {1'b0, 4'd04};
   localparam	[ 4: 0]	FSM_STATE_PRECOMPUTE_COPY_TRIG		= {1'b0, 4'd05};
   localparam	[ 4: 0]	FSM_STATE_PRECOMPUTE_COPY_WAIT		= {1'b0, 4'd06};
   localparam	[ 4: 0]	FSM_STATE_PRECOMPUTE_INVERT_TRIG		= {1'b0, 4'd07};
   localparam	[ 4: 0]	FSM_STATE_PRECOMPUTE_INVERT_WAIT		= {1'b0, 4'd08};
   localparam	[ 4: 0]	FSM_STATE_PRECOMPUTE_CONVERT_TRIG	= {1'b0, 4'd09};
   localparam	[ 4: 0]	FSM_STATE_PRECOMPUTE_CONVERT_WAIT	= {1'b0, 4'd10};
	
   localparam	[ 4: 0]	FSM_STATE_MULTIPLY_PREPARE_TRIG		= {1'b1, 4'd01};
   localparam	[ 4: 0]	FSM_STATE_MULTIPLY_PREPARE_WAIT		= {1'b1, 4'd02};
   localparam	[ 4: 0]	FSM_STATE_MULTIPLY_DOUBLE_TRIG		= {1'b1, 4'd03};
   localparam	[ 4: 0]	FSM_STATE_MULTIPLY_DOUBLE_WAIT		= {1'b1, 4'd04};
   localparam	[ 4: 0]	FSM_STATE_MULTIPLY_ADD_TRIG			= {1'b1, 4'd05};
   localparam	[ 4: 0]	FSM_STATE_MULTIPLY_ADD_WAIT			= {1'b1, 4'd06};
   localparam	[ 4: 0]	FSM_STATE_MULTIPLY_COPY_TRIG			= {1'b1, 4'd07};
   localparam	[ 4: 0]	FSM_STATE_MULTIPLY_COPY_WAIT			= {1'b1, 4'd08};
   localparam	[ 4: 0]	FSM_STATE_MULTIPLY_INVERT_TRIG		= {1'b1, 4'd09};
   localparam	[ 4: 0]	FSM_STATE_MULTIPLY_INVERT_WAIT		= {1'b1, 4'd10};
   localparam	[ 4: 0]	FSM_STATE_MULTIPLY_CONVERT_TRIG		= {1'b1, 4'd11};
   localparam	[ 4: 0]	FSM_STATE_MULTIPLY_CONVERT_WAIT		= {1'b1, 4'd12};

   localparam	[ 4: 0]	FSM_STATE_DONE								= 5'd31;

   reg [4:0] 			     fsm_state = FSM_STATE_IDLE;


   //
   // Round Counter
   //
   reg [ 8: 0] 			     bit_counter;
   wire [ 8: 0] 		     bit_counter_max = 9'd383;
   wire [ 8: 0] 		     bit_counter_zero = 9'd0;
   wire [ 8: 0] 		     bit_counter_next =
				     (bit_counter < bit_counter_max) ? bit_counter + 1'b1 : bit_counter_zero;


   //
   // Round Completion
   //
   wire [ 4: 0] 		     fsm_state_round_next = (bit_counter < bit_counter_max) ?
				     FSM_STATE_MULTIPLY_DOUBLE_TRIG : FSM_STATE_MULTIPLY_INVERT_TRIG;


   //
   // OP Trigger Logic
   //
   reg 				     op_trig;
   wire 			     op_done;

   always @(posedge clk or negedge rst_n)
     //
     if (rst_n == 1'b0)	op_trig <= 1'b0;
     else case (fsm_state)
			FSM_STATE_PRECOMPUTE_PREPARE_TRIG,
			FSM_STATE_PRECOMPUTE_DOUBLE_TRIG,
			FSM_STATE_PRECOMPUTE_CONVERT_TRIG,
			FSM_STATE_MULTIPLY_PREPARE_TRIG,
			FSM_STATE_MULTIPLY_DOUBLE_TRIG,
			FSM_STATE_MULTIPLY_ADD_TRIG,
			FSM_STATE_MULTIPLY_CONVERT_TRIG:	op_trig <= 1'b1;
			default:										op_trig <= 1'b0;
		endcase

		
   //
   // Microprograms
   //
   wire [ 5: 0] 		     op_rom_addr;
   wire [19: 0] 		     op_rom_init_data;
   wire [19: 0] 		     op_rom_dbl_data;
   wire [19: 0] 		     op_rom_add_data;
   wire [19: 0] 		     op_rom_conv_data;
   wire [19: 0] 		     op_rom_init_ecdh_data;
   reg [19: 0] 			     op_rom_mux_data;

   (* RAM_STYLE="BLOCK" *)
   uop_init_rom op_rom_init
     (
      .clk	(clk),
      .addr	(op_rom_addr),
      .data	(op_rom_init_data)
      );

   (* RAM_STYLE="BLOCK" *)
   uop_dbl_rom op_rom_dbl
     (
      .clk	(clk),
      .addr	(op_rom_addr),
      .data	(op_rom_dbl_data)
      );

   (* RAM_STYLE="BLOCK" *)
   uop_add_rom op_rom_add
     (
      .clk	(clk),
      .addr	(op_rom_addr),
      .data	(op_rom_add_data)
      );

   (* RAM_STYLE="BLOCK" *)
   uop_conv_rom op_rom_conv
     (
      .clk	(clk),
      .addr	(op_rom_addr),
      .data	(op_rom_conv_data)
      );

   (* RAM_STYLE="BLOCK" *)
   uop_init_rom_ecdh op_rom_conv_ecdh
     (
      .clk	(clk),
      .addr	(op_rom_addr),
      .data	(op_rom_init_ecdh_data)
      );

	  
   always @(*)
   //
   case (fsm_state)
	 FSM_STATE_PRECOMPUTE_PREPARE_WAIT:	op_rom_mux_data = op_rom_init_ecdh_data;
     FSM_STATE_MULTIPLY_PREPARE_WAIT:		op_rom_mux_data = op_rom_init_data;
     FSM_STATE_PRECOMPUTE_DOUBLE_WAIT,
	 FSM_STATE_MULTIPLY_DOUBLE_WAIT:		op_rom_mux_data = op_rom_dbl_data;
     FSM_STATE_MULTIPLY_ADD_WAIT:			op_rom_mux_data = op_rom_add_data;
	 FSM_STATE_PRECOMPUTE_CONVERT_WAIT,
     FSM_STATE_MULTIPLY_CONVERT_WAIT:		op_rom_mux_data = op_rom_conv_data;
     default:			op_rom_mux_data = {20{1'bX}};
   endcase



   //
   // Modulus
   //
   reg [ 3: 0]			rom_q_addr;
   wire [31: 0]			rom_q_data;

   brom_p384_q rom_q
     (
      .clk	(clk),
      .b_addr	(rom_q_addr),
      .b_out	(rom_q_data)
      );


   //
   // Worker
   //
   wire [ 3: 0] 		     worker_addr_px;
   wire [ 3: 0] 		     worker_addr_py;
   wire [ 3: 0] 		     worker_addr_pz;

   wire [ 3: 0] 		     worker_addr_rx;
   wire [ 3: 0] 		     worker_addr_ry;
   wire [ 3: 0] 		     worker_addr_rz;

   wire [ 3: 0] 		     worker_addr_q;

   wire 			     worker_wren_rx;
   wire 			     worker_wren_ry;
   wire 			     worker_wren_rz;

   reg [31: 0] 			     worker_din_px;
   reg [31: 0] 			     worker_din_py;
   reg [31: 0] 			     worker_din_pz;

   reg [31: 0] 			     worker_din_rx;
   reg [31: 0] 			     worker_din_ry;
   reg [31: 0] 			     worker_din_rz;

   wire [31: 0] 		     worker_dout_rx;
   wire [31: 0] 		     worker_dout_ry;
   wire [31: 0] 		     worker_dout_rz;

   point_dbl_add_384 worker
     (
      .clk		(clk),
      .rst_n		(rst_n),

      .ena		(op_trig),
      .rdy		(op_done),

      .uop_addr		(op_rom_addr),
      .uop		(op_rom_mux_data),

	  .gx_addr		(qx_addr),
	  .gy_addr		(qy_addr),
		
	  .hx_addr		(bram_hx_rd_addr),
	  .hy_addr		(bram_hy_rd_addr),
	  
      .px_addr		(worker_addr_px),
      .py_addr		(worker_addr_py),
      .pz_addr		(worker_addr_pz),

      .rx_addr		(worker_addr_rx),
      .ry_addr		(worker_addr_ry),
      .rz_addr		(worker_addr_rz),

      .q_addr		(worker_addr_q),

      .v_addr		(bram_rz1_rd_addr),

      .rx_wren		(worker_wren_rx),
      .ry_wren		(worker_wren_ry),
      .rz_wren		(worker_wren_rz),

	  .gx_din		(qx_din),
	  .gy_din		(qy_din),
		
	  .hx_din		(bram_hx_rd_data),
	  .hy_din		(bram_hy_rd_data),

      .px_din		(worker_din_px),
      .py_din		(worker_din_py),
      .pz_din		(worker_din_pz),

      .rx_din		(worker_din_rx),
      .ry_din		(worker_din_ry),
      .rz_din		(worker_din_rz),

      .rx_dout		(worker_dout_rx),
      .ry_dout		(worker_dout_ry),
      .rz_dout		(worker_dout_rz),

      .q_din		(rom_q_data),

      .v_din		(bram_rz1_rd_data)
      );


   //
   // Mover
   //
   reg 				     move_trig;
   wire 			     move_done;

   wire [ 3: 0] 		     mover_addr_x;
   wire [ 3: 0] 		     mover_addr_y;

   wire 			     mover_wren_y;

   always @(posedge clk or negedge rst_n)
     //
     if (rst_n == 1'b0)	move_trig <= 1'b0;
     else case (fsm_state)
			FSM_STATE_PRECOMPUTE_COPY_TRIG,
			FSM_STATE_MULTIPLY_COPY_TRIG:			move_trig <= 1'b1;
			default: 									move_trig <= 1'b0;
	  endcase

   mw_mover #
     (
      .WORD_COUNTER_WIDTH	(4),
      .OPERAND_NUM_WORDS	(12)
      )
   mover
     (
      .clk	(clk),
      .rst_n	(rst_n),

      .ena	(move_trig),
      .rdy	(move_done),

      .x_addr	(mover_addr_x),
      .y_addr	(mover_addr_y),
      .y_wren	(mover_wren_y),

      .x_din	({32{1'bX}}),
      .y_dout	()
      );


   //
   // Invertor
   //
   reg 				     invert_trig;
   wire 			     invert_done;

   wire [ 3: 0] 		     invertor_addr_a;
   wire [ 3: 0] 		     invertor_addr_q;

   always @(posedge clk or negedge rst_n)
     //
     if (rst_n == 1'b0)	invert_trig <= 1'b0;
     else case (fsm_state)
			FSM_STATE_PRECOMPUTE_INVERT_TRIG,
			FSM_STATE_MULTIPLY_INVERT_TRIG:	invert_trig <= 1'b1;
			default:										invert_trig <= 1'b0;
		endcase

   modular_invertor #
     (
      .MAX_OPERAND_WIDTH(384)
      )
   invertor
     (
      .clk		(clk),
      .rst_n		(rst_n),

      .ena		(invert_trig),
      .rdy		(invert_done),

      .a_addr		(invertor_addr_a),
      .q_addr		(invertor_addr_q),
      .a1_addr		(bram_rz1_wr_addr),
      .a1_wren		(bram_rz1_wr_en),

      .a_din		(bram_rz_rd_data),
      .q_din		(rom_q_data),
      .a1_dout		(bram_rz1_wr_data_in)
      );


   //
   // FSM Transition Logic
   //
   always @(posedge clk or negedge rst_n)
     //
     if (rst_n == 1'b0)			fsm_state <= FSM_STATE_IDLE;
     else case (fsm_state)

	    FSM_STATE_IDLE:		fsm_state <= ena ? FSM_STATE_PRECOMPUTE_PREPARE_TRIG : FSM_STATE_IDLE;

		FSM_STATE_PRECOMPUTE_PREPARE_TRIG: 	fsm_state <= FSM_STATE_PRECOMPUTE_PREPARE_WAIT;
		FSM_STATE_PRECOMPUTE_PREPARE_WAIT:		fsm_state <= (!op_trig && op_done) ? FSM_STATE_PRECOMPUTE_DOUBLE_TRIG : FSM_STATE_PRECOMPUTE_PREPARE_WAIT;
		 
		FSM_STATE_PRECOMPUTE_DOUBLE_TRIG: 		fsm_state <= FSM_STATE_PRECOMPUTE_DOUBLE_WAIT;
		FSM_STATE_PRECOMPUTE_DOUBLE_WAIT:		fsm_state <= (!op_trig && op_done) ? FSM_STATE_PRECOMPUTE_COPY_TRIG : FSM_STATE_PRECOMPUTE_DOUBLE_WAIT;
		 
		FSM_STATE_PRECOMPUTE_COPY_TRIG:		fsm_state <= FSM_STATE_PRECOMPUTE_COPY_WAIT; 
		FSM_STATE_PRECOMPUTE_COPY_WAIT:		fsm_state <= (!move_trig && move_done) ? FSM_STATE_PRECOMPUTE_INVERT_TRIG : FSM_STATE_PRECOMPUTE_COPY_WAIT;
		 
		FSM_STATE_PRECOMPUTE_INVERT_TRIG:		fsm_state <= FSM_STATE_PRECOMPUTE_INVERT_WAIT;
		FSM_STATE_PRECOMPUTE_INVERT_WAIT:		fsm_state <= (!invert_trig && invert_done) ? FSM_STATE_PRECOMPUTE_CONVERT_TRIG : FSM_STATE_PRECOMPUTE_INVERT_WAIT;
		 
		FSM_STATE_PRECOMPUTE_CONVERT_TRIG:		fsm_state <= FSM_STATE_PRECOMPUTE_CONVERT_WAIT; 
		FSM_STATE_PRECOMPUTE_CONVERT_WAIT:		fsm_state <= (!op_trig && op_done) ? FSM_STATE_MULTIPLY_PREPARE_TRIG : FSM_STATE_PRECOMPUTE_CONVERT_WAIT;

	    FSM_STATE_MULTIPLY_PREPARE_TRIG:	fsm_state <= FSM_STATE_MULTIPLY_PREPARE_WAIT;
	    FSM_STATE_MULTIPLY_PREPARE_WAIT:	fsm_state <= (!op_trig && op_done) ? FSM_STATE_MULTIPLY_DOUBLE_TRIG : FSM_STATE_MULTIPLY_PREPARE_WAIT;

	    FSM_STATE_MULTIPLY_DOUBLE_TRIG:	fsm_state <= FSM_STATE_MULTIPLY_DOUBLE_WAIT;
	    FSM_STATE_MULTIPLY_DOUBLE_WAIT:	fsm_state <= (!op_trig && op_done) ? FSM_STATE_MULTIPLY_ADD_TRIG : FSM_STATE_MULTIPLY_DOUBLE_WAIT;

	    FSM_STATE_MULTIPLY_ADD_TRIG:		fsm_state <= FSM_STATE_MULTIPLY_ADD_WAIT;
	    FSM_STATE_MULTIPLY_ADD_WAIT:		fsm_state <= (!op_trig && op_done) ? FSM_STATE_MULTIPLY_COPY_TRIG : FSM_STATE_MULTIPLY_ADD_WAIT;

	    FSM_STATE_MULTIPLY_COPY_TRIG:	fsm_state <= FSM_STATE_MULTIPLY_COPY_WAIT;
	    FSM_STATE_MULTIPLY_COPY_WAIT:	fsm_state <= (!move_trig && move_done) ? fsm_state_round_next : FSM_STATE_MULTIPLY_COPY_WAIT;

	    FSM_STATE_MULTIPLY_INVERT_TRIG:	fsm_state <= FSM_STATE_MULTIPLY_INVERT_WAIT;
	    FSM_STATE_MULTIPLY_INVERT_WAIT:	fsm_state <= (!invert_trig && invert_done) ? FSM_STATE_MULTIPLY_CONVERT_TRIG : FSM_STATE_MULTIPLY_INVERT_WAIT;

	    FSM_STATE_MULTIPLY_CONVERT_TRIG:	fsm_state <= FSM_STATE_MULTIPLY_CONVERT_WAIT;
	    FSM_STATE_MULTIPLY_CONVERT_WAIT:	fsm_state <= (!op_trig && op_done) ? FSM_STATE_DONE : FSM_STATE_MULTIPLY_CONVERT_WAIT;

	    FSM_STATE_DONE:		fsm_state <= FSM_STATE_IDLE;

	    default:			fsm_state <= FSM_STATE_IDLE;

	  endcase


   //
   // Bit Counter Increment
   //
   always @(posedge clk) begin
      //
      if ((fsm_state == FSM_STATE_MULTIPLY_PREPARE_WAIT) && !op_trig && op_done)
	bit_counter <= bit_counter_zero;
      //
      if ((fsm_state == FSM_STATE_MULTIPLY_COPY_WAIT) && !move_trig && move_done)
	bit_counter <= bit_counter_next;
      //
   end


   //
   // K Latch Logic
   //
   reg	[ 3: 0]	k_addr_reg;
   reg [31: 0] 	k_din_reg;

   assign k_addr = k_addr_reg;

   always @(posedge clk) begin
      //
      if (fsm_state == FSM_STATE_MULTIPLY_DOUBLE_TRIG)
	k_addr_reg <= 4'd11 - bit_counter[8:5];
      //
      if (fsm_state == FSM_STATE_MULTIPLY_ADD_TRIG)
	k_din_reg <= (bit_counter[4:0] == 5'd0) ? k_din : {k_din_reg[30:0], 1'bX};
      //
   end



   //
   // Copy Inhibit Logic
   //
   wire	move_inhibit = k_din_reg[31];

   reg copy_t2r_int;

	always @*
		//
		case (fsm_state)
			FSM_STATE_PRECOMPUTE_COPY_WAIT:	copy_t2r_int = 1'b1;
			FSM_STATE_MULTIPLY_COPY_WAIT:		copy_t2r_int = mover_wren_y & ~move_inhibit;
			default:									copy_t2r_int = 1'b0;
		endcase

   always @(*) begin
      //
      // Q
      //
      case (fsm_state)
	FSM_STATE_PRECOMPUTE_DOUBLE_WAIT,
	FSM_STATE_MULTIPLY_DOUBLE_WAIT:	rom_q_addr = worker_addr_q;
	FSM_STATE_MULTIPLY_ADD_WAIT:		rom_q_addr = worker_addr_q;
	FSM_STATE_PRECOMPUTE_INVERT_WAIT,
	FSM_STATE_MULTIPLY_INVERT_WAIT:	rom_q_addr = invertor_addr_q;
	FSM_STATE_PRECOMPUTE_CONVERT_WAIT,
	FSM_STATE_MULTIPLY_CONVERT_WAIT:	rom_q_addr = worker_addr_q;
	default:		rom_q_addr = worker_addr_q;
      endcase

      //
      // R(X,Y,Z)
      //
      case (fsm_state)
	//
	FSM_STATE_PRECOMPUTE_PREPARE_WAIT,
	FSM_STATE_MULTIPLY_PREPARE_WAIT: begin
	   //
	   bram_rx_rd_addr    <= {4{1'bX}};      bram_ry_rd_addr    <= {4{1'bX}};      bram_rz_rd_addr    <= {4{1'bX}};
	   bram_rx_wr_addr    <= worker_addr_rx; bram_ry_wr_addr    <= worker_addr_ry; bram_rz_wr_addr    <= worker_addr_rz;
	   bram_rx_wr_en      <= worker_wren_rx; bram_ry_wr_en      <= worker_wren_ry; bram_rz_wr_en      <= worker_wren_rz;
	   bram_rx_wr_data_in <= worker_dout_rx; bram_ry_wr_data_in <= worker_dout_ry; bram_rz_wr_data_in <= worker_dout_rz;
	   //
	end
	//
	FSM_STATE_PRECOMPUTE_DOUBLE_WAIT,
	FSM_STATE_MULTIPLY_DOUBLE_WAIT: begin
	   //
	   bram_rx_rd_addr    <= worker_addr_px; bram_ry_rd_addr    <= worker_addr_py; bram_rz_rd_addr    <= worker_addr_pz;
	   bram_rx_wr_addr    <= {4{1'bX}};      bram_ry_wr_addr    <= {4{1'bX}};      bram_rz_wr_addr    <= {4{1'bX}};
	   bram_rx_wr_en      <= 1'b0;           bram_ry_wr_en      <= 1'b0;           bram_rz_wr_en      <= 1'b0;
	   bram_rx_wr_data_in <= {32{1'bX}};     bram_ry_wr_data_in <= {32{1'bX}};     bram_rz_wr_data_in <= {32{1'bX}};
	   //
	end
	//
	FSM_STATE_MULTIPLY_ADD_WAIT: begin
	   //
	   bram_rx_rd_addr    <= {4{1'bX}};      bram_ry_rd_addr    <= {4{1'bX}};      bram_rz_rd_addr    <= {4{1'bX}};
	   bram_rx_wr_addr    <= worker_addr_rx; bram_ry_wr_addr    <= worker_addr_ry; bram_rz_wr_addr    <= worker_addr_rz;
	   bram_rx_wr_en      <= worker_wren_rx; bram_ry_wr_en      <= worker_wren_ry; bram_rz_wr_en      <= worker_wren_rz;
	   bram_rx_wr_data_in <= worker_dout_rx; bram_ry_wr_data_in <= worker_dout_ry; bram_rz_wr_data_in <= worker_dout_rz;
	   //
	end
	//
	FSM_STATE_PRECOMPUTE_COPY_WAIT,
	FSM_STATE_MULTIPLY_COPY_WAIT: begin
	   //
	   bram_rx_rd_addr    <= {4{1'bX}};       bram_ry_rd_addr    <= {4{1'bX}};       bram_rz_rd_addr    <= {4{1'bX}};
	   bram_rx_wr_addr    <= mover_addr_y;    bram_ry_wr_addr    <= mover_addr_y;    bram_rz_wr_addr    <= mover_addr_y;
	   bram_rx_wr_en      <= copy_t2r_int;    bram_ry_wr_en      <= copy_t2r_int;    bram_rz_wr_en      <= copy_t2r_int;
	   bram_rx_wr_data_in <= bram_tx_rd_data; bram_ry_wr_data_in <= bram_ty_rd_data; bram_rz_wr_data_in <= bram_tz_rd_data;
	   //
	end
	//
	FSM_STATE_PRECOMPUTE_INVERT_WAIT,
	FSM_STATE_MULTIPLY_INVERT_WAIT: begin
	   //
	   bram_rx_rd_addr    <= {4{1'bX}};  bram_ry_rd_addr    <= {4{1'bX}};  bram_rz_rd_addr    <= invertor_addr_a;
	   bram_rx_wr_addr    <= {4{1'bX}};  bram_ry_wr_addr    <= {4{1'bX}};  bram_rz_wr_addr    <= {4{1'bX}};
	   bram_rx_wr_en      <= 1'b0;       bram_ry_wr_en      <= 1'b0;       bram_rz_wr_en      <= 1'b0;
	   bram_rx_wr_data_in <= {32{1'bX}}; bram_ry_wr_data_in <= {32{1'bX}}; bram_rz_wr_data_in <= {32{1'bX}};
	   //
	end
	//
	FSM_STATE_PRECOMPUTE_CONVERT_WAIT,
	FSM_STATE_MULTIPLY_CONVERT_WAIT: begin
	   //
	   bram_rx_rd_addr    <= worker_addr_px; bram_ry_rd_addr    <= worker_addr_py; bram_rz_rd_addr    <= worker_addr_pz;
	   bram_rx_wr_addr    <= {4{1'bX}};      bram_ry_wr_addr    <= {4{1'bX}};      bram_rz_wr_addr    <= {4{1'bX}};
	   bram_rx_wr_en      <= 1'b0;           bram_ry_wr_en      <= 1'b0;           bram_rz_wr_en      <= 1'b0;
	   bram_rx_wr_data_in <= {32{1'bX}};     bram_ry_wr_data_in <= {32{1'bX}};     bram_rz_wr_data_in <= {32{1'bX}};
	   //
	end

	//
	default: begin
	   //
	   bram_rx_rd_addr    <= {4{1'bX}};  bram_ry_rd_addr    <= {4{1'bX}};  bram_rz_rd_addr    <= {4{1'bX}};
	   bram_rx_wr_addr    <= {4{1'bX}};  bram_ry_wr_addr    <= {4{1'bX}};  bram_rz_wr_addr    <= {4{1'bX}};
	   bram_rx_wr_en      <= 1'b0;       bram_ry_wr_en      <= 1'b0;       bram_rz_wr_en      <= 1'b0;
	   bram_rx_wr_data_in <= {32{1'bX}}; bram_ry_wr_data_in <= {32{1'bX}}; bram_rz_wr_data_in <= {32{1'bX}};
	   //
	end
	//
      endcase
      //
      // T(X,Y,Z)
      //
      case (fsm_state)
	//
	FSM_STATE_PRECOMPUTE_DOUBLE_WAIT,
	FSM_STATE_MULTIPLY_DOUBLE_WAIT: begin
	   //
	   bram_tx_rd_addr    <= {4{1'bX}};      bram_ty_rd_addr    <= {4{1'bX}};      bram_tz_rd_addr    <= {4{1'bX}};
	   bram_tx_wr_addr    <= worker_addr_rx; bram_ty_wr_addr    <= worker_addr_ry; bram_tz_wr_addr    <= worker_addr_rz;
	   bram_tx_wr_en      <= worker_wren_rx; bram_ty_wr_en      <= worker_wren_ry; bram_tz_wr_en      <= worker_wren_rz;
	   bram_tx_wr_data_in <= worker_dout_rx; bram_ty_wr_data_in <= worker_dout_ry; bram_tz_wr_data_in <= worker_dout_rz;
	   //
	end
	//
	FSM_STATE_MULTIPLY_ADD_WAIT: begin
	   //
	   bram_tx_rd_addr    <= worker_addr_px; bram_ty_rd_addr    <= worker_addr_py; bram_tz_rd_addr    <= worker_addr_pz;
	   bram_tx_wr_addr    <= {4{1'bX}};      bram_ty_wr_addr    <= {4{1'bX}};      bram_tz_wr_addr    <= {4{1'bX}};
	   bram_tx_wr_en      <= 1'b0;           bram_ty_wr_en      <= 1'b0;           bram_tz_wr_en      <= 1'b0;
	   bram_tx_wr_data_in <= {32{1'bX}};     bram_ty_wr_data_in <= {32{1'bX}};     bram_tz_wr_data_in <= {32{1'bX}};
	   //
	end
	//
	FSM_STATE_PRECOMPUTE_COPY_WAIT,
	FSM_STATE_MULTIPLY_COPY_WAIT: begin
	   //
	   bram_tx_rd_addr    <= mover_addr_x; bram_ty_rd_addr    <= mover_addr_x; bram_tz_rd_addr    <= mover_addr_x;
	   bram_tx_wr_addr    <= {4{1'bX}};    bram_ty_wr_addr    <= {4{1'bX}};    bram_tz_wr_addr    <= {4{1'bX}};
	   bram_tx_wr_en      <= 1'b0;         bram_ty_wr_en      <= 1'b0;         bram_tz_wr_en      <= 1'b0;
	   bram_tx_wr_data_in <= {32{1'bX}};   bram_ty_wr_data_in <= {32{1'bX}};   bram_tz_wr_data_in <= {32{1'bX}};
	   //
	end

	//
	default: begin
	   //
	   bram_tx_rd_addr    <= {4{1'bX}};  bram_ty_rd_addr    <= {4{1'bX}};  bram_tz_rd_addr    <= {4{1'bX}};
	   bram_tx_wr_addr    <= {4{1'bX}};  bram_ty_wr_addr    <= {4{1'bX}};  bram_tz_wr_addr    <= {4{1'bX}};
	   bram_tx_wr_en      <= 1'b0;       bram_ty_wr_en      <= 1'b0;       bram_tz_wr_en      <= 1'b0;
	   bram_tx_wr_data_in <= {32{1'bX}}; bram_ty_wr_data_in <= {32{1'bX}}; bram_tz_wr_data_in <= {32{1'bX}};
	   //
	end
	//
      endcase
      //
      // Worker
      //
      case (fsm_state)
	//
	FSM_STATE_PRECOMPUTE_DOUBLE_WAIT,
	FSM_STATE_MULTIPLY_DOUBLE_WAIT: begin
	   //
	   worker_din_px <= bram_rx_rd_data;     worker_din_py <= bram_ry_rd_data;     worker_din_pz <= bram_rz_rd_data;
	   worker_din_rx <= bram_tx_wr_data_out; worker_din_ry <= bram_ty_wr_data_out; worker_din_rz <= bram_tz_wr_data_out;
	   //
	end
	//
	FSM_STATE_MULTIPLY_ADD_WAIT: begin
	   //
	   worker_din_px <= bram_tx_rd_data;     worker_din_py <= bram_ty_rd_data;     worker_din_pz <= bram_tz_rd_data;
	   worker_din_rx <= bram_rx_wr_data_out; worker_din_ry <= bram_ry_wr_data_out; worker_din_rz <= bram_rz_wr_data_out;
	   //
	end
	//
	FSM_STATE_PRECOMPUTE_CONVERT_WAIT,
	FSM_STATE_MULTIPLY_CONVERT_WAIT: begin
	   //
	   worker_din_px <= bram_rx_rd_data; worker_din_py <= bram_ry_rd_data; worker_din_pz <= bram_rz_rd_data;
	   worker_din_rx <= {32{1'bX}};      worker_din_ry <= {32{1'bX}};      worker_din_rz <= {32{1'bX}};
	   //
	end
	//
	default: begin
	   //
	   worker_din_px <= {32{1'bX}}; worker_din_py <= {32{1'bX}}; worker_din_pz <= {32{1'bX}};
	   worker_din_rx <= {32{1'bX}}; worker_din_ry <= {32{1'bX}}; worker_din_rz <= {32{1'bX}};
	   //
	end
	//
      endcase
      //
   end


   	//
	// Internal Mapping
	//
	assign bram_hx_wr_en = worker_wren_rx && (fsm_state == FSM_STATE_PRECOMPUTE_CONVERT_WAIT);
	assign bram_hy_wr_en = worker_wren_ry && (fsm_state == FSM_STATE_PRECOMPUTE_CONVERT_WAIT);

   assign bram_hx_wr_data_in = worker_dout_rx;
   assign bram_hy_wr_data_in = worker_dout_ry;

   assign bram_hx_wr_addr = worker_addr_rx;
   assign bram_hy_wr_addr = worker_addr_ry;

   
   //
   // Output Mapping
   //
   assign	rx_wren = worker_wren_rx && (fsm_state == FSM_STATE_MULTIPLY_CONVERT_WAIT);
   assign	ry_wren = worker_wren_ry && (fsm_state == FSM_STATE_MULTIPLY_CONVERT_WAIT);

   assign	rx_dout = worker_dout_rx;
   assign	ry_dout = worker_dout_ry;

   assign	rx_addr = worker_addr_rx;
   assign	ry_addr = worker_addr_ry;


   //
   // Ready Flag Logic
   //
   reg rdy_reg = 1'b1;
   assign rdy = rdy_reg;

   always @(posedge clk or negedge rst_n)

     if (rst_n == 1'b0) rdy_reg <= 1'b1;
     else begin

	/* clear flag */
	if ((fsm_state == FSM_STATE_IDLE) && ena)
	  rdy_reg <= 1'b0;

	/* set flag */
	if (fsm_state == FSM_STATE_DONE)
	  rdy_reg <= 1'b1;

     end


endmodule


//------------------------------------------------------------------------------
// End-of-File
//------------------------------------------------------------------------------
