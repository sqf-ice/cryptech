#===================================================================
#
# Makefile
# --------
# Makefile for building uart core simulations.
#
#
# Author: Joachim Strombergson
# Copyright (c) 2014, NORDUnet A/S
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# - Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#
# - Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the distribution.
#
# - Neither the name of the NORDUnet nor the names of its contributors may
#   be used to endorse or promote products derived from this software
#   without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#===================================================================

UART_SRC=../src/rtl/uart_core.v
UART_TB_SRC=../src/tb/tb_uart.v

CC=iverilog


all: uart


uart:  $(UART_TB_SRC) $(UART_SRC)
	$(CC) -o uart.sim $(UART_TB_SRC) $(UART_SRC)

sim-uart: uart.sim
	./uart.sim


clean:
	rm -f uart.sim


help:
	@echo "Supported targets:"
	@echo "------------------"
	@echo "all:      Build all simulation targets."
	@echo "uart:     Build the uart simulation target."
	@echo "sim-uart: Run the uart simulation."
	@echo "clean:    Delete all built files."

#===================================================================
# EOF Makefile
#===================================================================

