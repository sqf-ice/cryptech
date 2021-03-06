#===================================================================
#
# Makefile
# --------
# Makefile for building core and top simulation.
#
#
# Author: Joachim Strombergson
# Copyright (c) 2011, NORDUnet A/S All rights reserved.
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

QR_SRC = ../src/rtl/chacha_qr.v
QR_TB_SRC = ../src/tb/tb_chacha_qr.v

CORE_SRC = ../src/rtl/chacha_core.v $(QR_SRC)
CORE_TB_SRC = ../src/tb/tb_chacha_core.v

TOP_SRC = ../src/rtl/chacha.v $(CORE_SRC)
TOP_TB_SRC = ../src/tb/tb_chacha.v

CC = iverilog
CC_FLAGS = -Wall

LINT = verilator
LINT_FLAGS = +1364-2001ext+ --lint-only  -Wall -Wno-fatal -Wno-DECLFILENAME


all: top core qr


top: $(TOP_TB_SRC) $(TOP_SRC)
	$(CC) $(CC_FLAGS) -o top.sim $(TOP_TB_SRC) $(TOP_SRC)


core: $(CORE_TB_SRC) $(CORE_SRC)
	$(CC) $(CC_FLAGS) -o core.sim $(CORE_SRC) $(CORE_TB_SRC)


qr: $(QR_TB_SRC) $(QR_SRC)
	$(CC) $(CC_FLAGS) -o qr.sim $(QR_SRC) $(QR_TB_SRC)


sim-top: top
	./top.sim


sim-core: core
	./core.sim


sim-qr: qr
	./qr.sim


lint:  $(TOP_SRC)
	$(LINT) $(LINT_FLAGS) $(TOP_SRC)


help:
	@echo "Supported targets:"
	@echo "------------------"
	@echo "all:      Build all simulation targets."
	@echo "top:      Build the top simulation target."
	@echo "core:     Build the core simulation target."
	@echo "qr  :     Build the qr simulation target."
	@echo "sim-top:  Run top simulation."
	@echo "sim-core: Run core simulation."
	@echo "sim-qr:   Run qr simulation."
	@echo "lint:     Lint the design."
	@echo "debug:    Print the internal varibles."

clean:
	rm -f top.sim
	rm -f core.sim
	rm -f qr.sim

#===================================================================
# EOF Makefile
#===================================================================
