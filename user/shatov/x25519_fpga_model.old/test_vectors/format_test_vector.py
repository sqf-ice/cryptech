#
# format_test_vector.py
# -----------------------------------------
# Formats test vector for x25519_fpga_model
#
# Author: Pavel Shatov
# Copyright (c) 2017-2018, NORDUnet A/S
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


#
USAGE = "USAGE: format_test_vector.py [openssl_binary]"
#

#
# This script reads the test vector generated by regenerate_test_vector.py
# and writes nicely formatted C header file and Verilog include file.
#

#
# IMPORTANT: This will only work with OpenSSL 1.1.0, version 1.0.2 doesn't
# support the X25519 algoritm. If you system library is the older version,
# you can pass location of specific OpenSSL binary to use on the command line.
#


#
# imports
#
import sys
import subprocess
import pysodium


#
# variables
#
OPENSSL = ""


#
# format one test vector
#
def format_c_header(	f,
						da, qax,
						db, qbx,
						qabx):
	
		# convert to integers
	da_int   = int(da.hex(), 16)
	db_int   = int(db.hex(), 16)
	qax_int  = int(qax.hex(), 16)
	qbx_int  = int(qbx.hex(), 16)
	qabx_int = int(qabx.hex(), 16)
	
		# write all numbers in vector
	format_c_array(f, da_int,   "#define X25519_DA"    + " \\\n")
	format_c_array(f, qax_int,  "#define X25519_QA_X"  + " \\\n")

	format_c_array(f, db_int,   "#define X25519_DB"    + " \\\n")
	format_c_array(f, qbx_int,  "#define X25519_QB_X"  + " \\\n")

	format_c_array(f, qabx_int, "#define X25519_QAB_X" + " \\\n")
	
# #
# # format one test vector
# #
# def format_verilog_include(	f, curve, n,
							# da, qax, qay,
							# db, qbx, qby,
							# sx, sy,
							# gx, gy,
							# hx, hy,
							# qa2x, qa2y,
							# qb2x, qb2y):

	# if curve == CURVE_P256:
		# curve_str = "P_256"
		# msb_index = "255"

	# if curve == CURVE_P384:
		# curve_str = "P_384"
		# msb_index = "383"

		# # write all numbers in vector
	# format_verilog_concatenation(f, n,    "localparam [" + msb_index + ":0] " + curve_str + "_N"     + " =\n")

	# format_verilog_concatenation(f, da,   "localparam [" + msb_index + ":0] " + curve_str + "_DA"    + " =\n")
	# format_verilog_concatenation(f, qax,  "localparam [" + msb_index + ":0] " + curve_str + "_QA_X"  + " =\n")
	# format_verilog_concatenation(f, qay,  "localparam [" + msb_index + ":0] " + curve_str + "_QA_Y"  + " =\n")
	# format_verilog_concatenation(f, qa2x, "localparam [" + msb_index + ":0] " + curve_str + "_QA2_X" + " =\n")
	# format_verilog_concatenation(f, qa2y, "localparam [" + msb_index + ":0] " + curve_str + "_QA2_Y" + " =\n")

	# format_verilog_concatenation(f, db,   "localparam [" + msb_index + ":0] " + curve_str + "_DB"    + " =\n")
	# format_verilog_concatenation(f, qbx,  "localparam [" + msb_index + ":0] " + curve_str + "_QB_X"  + " =\n")
	# format_verilog_concatenation(f, qby,  "localparam [" + msb_index + ":0] " + curve_str + "_QB_Y"  + " =\n")
	# format_verilog_concatenation(f, qb2x, "localparam [" + msb_index + ":0] " + curve_str + "_QB2_X" + " =\n")
	# format_verilog_concatenation(f, qb2y, "localparam [" + msb_index + ":0] " + curve_str + "_QB2_Y" + " =\n")

	# format_verilog_concatenation(f, sx,   "localparam [" + msb_index + ":0] " + curve_str + "_S_X"   + " =\n")
	# format_verilog_concatenation(f, sy,   "localparam [" + msb_index + ":0] " + curve_str + "_S_Y"   + " =\n")

	# format_verilog_concatenation(f, gx,   "localparam [" + msb_index + ":0] " + curve_str + "_G_X"   + " =\n")
	# format_verilog_concatenation(f, gy,   "localparam [" + msb_index + ":0] " + curve_str + "_G_Y"   + " =\n")

	# format_verilog_concatenation(f, hx,   "localparam [" + msb_index + ":0] " + curve_str + "_H_X"   + " =\n")
	# format_verilog_concatenation(f, hy,   "localparam [" + msb_index + ":0] " + curve_str + "_H_Y"   + " =\n")

#
# nicely format multi-word integer into C array initializer
#
def format_c_array(f, n, s):

		# print '#define XYZ \'
	f.write(s)

		# convert number to hex string and prepend it with zeroes if necessary
	n_hex = hex(n).lstrip("0x").rstrip("L")
	while (len(n_hex) % 8) > 0:
		n_hex = "0" + n_hex
	
		# get number of 32-bit words
	num_words = len(n_hex) // 8

		# print all words in n
	w = 0
	while w < num_words:
	
		n_part = ""

			# add tab for every new line
		if w == 0:
			n_part += "\t{"
		elif (w % 4) == 0:
			n_part += "\t "
			
			# add current word
		n_part += "0x" + n_hex[8 * w : 8 * (w + 1)]
		
			# add separator or newline
		if (w + 1) == num_words:
			n_part += "}\n"
		else:
			n_part += ", "
			if (w % 4) == 3:
				n_part += "\\\n"		
				
		w += 1
		
			# write current part
		f.write(n_part)
	
		# write final newline
	f.write("\n")

# def format_verilog_concatenation(f, n, s):

		# # print 'localparam ZZZ ='
	# f.write(s)
	
		# # convert number to hex string and prepend it with zeroes if necessary
	# n_hex = hex(n).split("0x")[1]
	# while (len(n_hex) % 8) > 0:
		# n_hex = "0" + n_hex
	
		# # get number of 32-bit words
	# num_words = len(n_hex) // 8

		# # print all words in n
	# w = 0
	# while w < num_words:
	
		# n_part = ""
		
		# if w == 0:
			# n_part += "\t{"
		# elif (w % 4) == 0:
			# n_part += "\t "
			
		# n_part += "32'h" + n_hex[8 * w : 8 * (w + 1)]
		
		# if (w + 1) == num_words:
			# n_part += "};\n"
		# else:
			# n_part += ", "
			# if (w % 4) == 3:
				# n_part += "\n"		
		# w += 1
		
		# f.write(n_part)
	
	# f.write("\n")


	#
	# returns d, qx where
	# d is private key and qx is the corresponding public key
	#
def get_key(openssl, party):

		# generate private key filename
	key_file = party + ".key"
		
		# retrieve key components using openssl
	openssl_command = [openssl, "pkey", "-in", key_file, "-noout", "-text"]	
	openssl_stdout = subprocess.check_output(openssl_command).decode("utf-8")
	stdout_lines = openssl_stdout.splitlines()
	
	key_priv = ""
	key_pub = ""

	found_priv = False
	found_pub = False
	
		# process lines looking for "priv:" and "pub:" markers
	for line in stdout_lines:
	
			# found private key marker?
		if line == "priv:":
			found_priv = True
			found_pub = False
			continue
			
			# found public key marker?
		if line == "pub:":
			found_pub = True
			found_priv = False
			continue
			
			# found part of private key?
		if found_priv:
			if not line.startswith(" "):
				found_priv = False
				continue
			else:
				key_priv += line.strip()
			
			# found part of public key?
		if found_pub:
			if not line.startswith(" "):
				found_pub = False
				continue
			else:
				key_pub += line.strip()
			
		# do some cleanup and sanity checking on private key
		#  * remove colons
		#  * check length (256 bits or 384 bits)		
	key_priv = key_priv.replace(":", "")
	if len(key_priv) != (256 / 4): sys.exit()
	
		# do some cleanup and sanity checking on public key
		#  * remove colons
		#  * check length (256 bits)
	key_pub = key_pub.replace(":", "")
	if len(key_pub) != (256 / 4): sys.exit()

		# convert to byte arrays
	key_priv_bytes = bytes.fromhex(key_priv)
	key_pub_bytes = bytes.fromhex(key_pub)

		# change byte order to msb...lsb
	key_priv_bytes = key_priv_bytes[::-1]
	key_pub_bytes = key_pub_bytes[::-1]
	
		# convert to integers
	key_priv_int = int(key_priv_bytes.hex(), 16)
	key_pub_int = int(key_pub_bytes.hex(), 16)
	
		# another sanity check (make sure, that key_pub is actually key_priv * G)
	key_pub_calc_bytes = pysodium.crypto_scalarmult_curve25519_base(key_priv_bytes[::-1])[::-1]
	key_pub_calc_int = int(key_pub_calc_bytes.hex(), 16)
	
	if (key_pub_int != key_pub_calc_int): sys.exit()
		
		# done
	return key_priv_bytes, key_pub_bytes

	#
	# returns the shared secret key
	#
def calc_shared_key(key_priv_bytes, key_pub_bytes):

	key_shared_bytes = pysodium.crypto_scalarmult_curve25519(key_priv_bytes[::-1], key_pub_bytes[::-1])[::-1]
	return key_shared_bytes

	
if __name__ == "__main__":

		# detect whether user requested some specific binary
	if len(sys.argv) == 1:
		OPENSSL = "openssl"
		print("Using system OpenSSL library.")
	elif len(sys.argv) == 2:
		OPENSSL = sys.argv[1]
		print("Using OpenSSL binary '" + OPENSSL + "'...")
	else:
		print(USAGE)

	if len(OPENSSL) > 0:
	
			# open output files
		file_h = open('x25519_test_vector.h', 'w')
		#file_v = open('ecdh_test_vectors.v', 'w')
		
			# write headers
		file_h.write("/* Generated automatically, do not edit. */\n\n")
		#file_v.write("/* Generated automatically, do not edit. */\n\n")
		
			# load keys
		da, qax = get_key(OPENSSL, "alice")
		db, qbx = get_key(OPENSSL, "bob")
					
			# we derive the shared secret two different ways (from Alice's and
			# from Bob's perspective, they must be identical of course
		qabx = calc_shared_key(da, qbx)	# Alice's secret
		qbax = calc_shared_key(db, qax)	# Bob's secret
		
		if (qabx != qbax): sys.exit()
			
		print("Derived shared secret.");

			# format numbers and write to file
		format_c_header(	file_h,
							da, qax,
							db, qbx,
							qabx)
							
	#	format_verilog_include(	file_v, next_curve, n,
	#							da, qax, qay,
	#							db, qbx, qby,
	#							QAB.x, QBA.y,
	#							G.x, G.y,
	#							H.x, H.y,
	#							QA2.x, QA2.y,
	#							QB2.x, QB2.y)

			# done
		file_h.close()
		#file_v.close()
		
			# everything went just fine
		print("Test vector formatted.")

#
# End of file
#