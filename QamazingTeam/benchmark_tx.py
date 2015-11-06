#!/usr/bin/env python
#
# Copyright 2010,2011,2013 Free Software Foundation, Inc.
# 
# This file is part of GNU Radio
# 
# GNU Radio is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
# 
# GNU Radio is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with GNU Radio; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
# 
import sys, os


path = os.path.dirname(sys.argv[0]).split("share")[0] + "lib/python2.7/dist-packages"
sys.path.append(path)

os.environ['SHELL'] = "/bin/bash"
os.environ['LC_ALL'] = 'C'
os.environ['LANG'] = 'C'
os.environ['PYTHONPATH'] = os.path.dirname(sys.argv[0]).split("share")[0] +'lib/python2.7/dist-packages'
os.environ['PKG_CONFIG_PATH'] = os.path.dirname(sys.argv[0]).split("share")[0] +'lib/pkgconfig'

from gnuradio import gr
from gnuradio import blocks
from gnuradio import eng_notation
from gnuradio.eng_option import eng_option
from optparse import OptionParser

from usrp_spectrum_sense  import my_top_block as senseblock
from usrp_spectrum_sense  import main_loop as sense_loop


# From gr-digital
from gnuradio import digital

# from current dir
from transmit_path import transmit_path
from uhd_interface import uhd_transmitter

import time, struct, sys
import socket

#import os 
#print os.getpid()
#raw_input('Attach and press enter')

class my_top_block(gr.top_block):
   	
    def __init__(self, modulator, options):
        global modulator2,symbol_rate2,lala
	gr.top_block.__init__(self)

        #Initiate on fake transmit freq
	options.tx_freq=2359000000.0
        if(options.tx_freq is not None):
            # Work-around to get the modulation's bits_per_symbol
            args = modulator.extract_kwargs_from_options(options)
            symbol_rate = options.bitrate / modulator(**args).bits_per_symbol()
	    
            self.sink = uhd_transmitter(options.args, symbol_rate,
                                        options.samples_per_symbol, options.tx_freq,
                                        options.lo_offset, options.tx_gain,
                                        options.spec, options.antenna,
                                        options.clock_source, options.verbose)
            options.samples_per_symbol = self.sink._sps
 	    modulator2=modulator
	    symbol_rate2=symbol_rate
	    
     
        elif(options.to_file is not None):
            sys.stderr.write(("Saving samples to '%s'.\n\n" % (options.to_file)))
            self.sink = blocks.file_sink(gr.sizeof_gr_complex, options.to_file)
        else:
            sys.stderr.write("No sink defined, dumping samples to null sink.\n\n")
            self.sink = blocks.null_sink(gr.sizeof_gr_complex)

        # do this after for any adjustments to the options that may
        # occur in the sinks (specifically the UHD sink)
        self.txpath = transmit_path(modulator, options)

        self.connect(self.txpath, self.sink)
        print >> sys.stderr, options

# /////////////////////////////////////////////////////////////////////////////
#                                   main
# /////////////////////////////////////////////////////////////////////////////

def main():
    #Searches for static 1Mhz windows	
    def find_hole(power_list):
	bin_start=0
	bin_stop=0
	bins=0
	results = []
	for i in range(0,len(power_list)):
		if power_list[i]< 40.0 :
			bins=bins+1
			if bins == 34:
				bin_stop=i
				break
		else:
			bins=0
			bin_start=i+1
	if bin_stop == 0:
		return 0
	results.append(bin_start)
	results.append(bin_stop)
	return results
    #Attemp to find where opponent transmits
    def fuzz_target(power_list):
	bin_start=0
        bin_stop=0
        for i in range(0,len(power_list)):
                if power_list[i] > 60.0 :
                        bin_start = i
			if (i+34) <= len(power_list):
                        	bin_stop = i+34
                        else:
				bin_stop = len(power_list)
			break
   
        if bin_start == 0:
                return 0
        middle_bin = ((bin_stop-bin_start)/2) + bin_start
	result = (middle_bin*27902) + 2357500000.0 
        return result
	


    def send_pkt(payload='', eof=False):
        return tb.txpath.send_pkt(payload, eof)

    mods = digital.modulation_utils.type_1_mods()
    
    parser = OptionParser(option_class=eng_option, conflict_handler="resolve")
    expert_grp = parser.add_option_group("Expert")

    parser.add_option("-m", "--modulation", type="choice", choices=mods.keys(),
                      default='qpsk',
                      help="Select modulation from: %s [default=%%default]"
                            % (', '.join(mods.keys()),))

    parser.add_option("-s", "--size", type="eng_float", default=1500,
                      help="set packet size [default=%default]")
    parser.add_option("-M", "--megabytes", type="eng_float", default=1.0,
                      help="set megabytes to transmit [default=%default]")
    parser.add_option("","--discontinuous", action="store_true", default=False,
                      help="enable discontinous transmission (bursts of 5 packets)")
    parser.add_option("","--from-file", default=None,
                      help="use intput file for packet contents")
    parser.add_option("","--to-file", default=None,
                      help="Output file for modulated samples")
    parser.add_option("","--server", action="store_true", default=False,
                      help="To take data from the server")

    transmit_path.add_options(parser, expert_grp)
    uhd_transmitter.add_options(parser)

    for mod in mods.values():
        mod.add_options(expert_grp)

    (options, args) = parser.parse_args ()

    if len(args) != 0:
        parser.print_help()
        sys.exit(1)
           
    if options.from_file is not None:
        source_file = open(options.from_file, 'r')

    # build the graph
   # tb = my_top_block(mods[options.modulation], options)

    r = gr.enable_realtime_scheduling()
    if r != gr.RT_OK:
        print "Warning: failed to enable realtime scheduling"
    
    sb = senseblock()
    freq_list = []
    packet_list = []
   
    #Initialise
    tb = my_top_block(mods[options.modulation], options)
    tb.start()                       # start flow graph


#Fake tranmission phase, to provoke opponent attacks
    payload_fake = struct.pack('!H', 666 & 0xffff) + "Qamazing team, if we lose handshake freq we are done for!"    
    for i in range(0, 4000):
    	send_pkt(payload_fake)
	sys.stderr.write('.')

#Sense and fuzz phase
    tb.lock()
    time.sleep(2)
    sb.start()
    freq_list = sense_loop(sb)
    for i in range(0,1000):
        fuzz_result = fuzz_target(freq_list)
    print "Sensing complete, stoping senseblock, prepare to fuzz"
    sb.stop()
    sb.wait()
    tb.unlock()
    if fuzz_result != 0:
    	options.tx_freq= fuzz_result
    	sink = uhd_transmitter(options.args, symbol_rate2,
                                        options.samples_per_symbol, options.tx_freq,
                                        options.lo_offset, options.tx_gain,
                                        options.spec, options.antenna,
                                        options.clock_source, options.verbose)
    	txpath = transmit_path(modulator2, options)
    	for i in range(0, 4000):
       		send_pkt(payload_fake)
        	sys.stderr.write('.')
    else:
	time.sleep(1)
	print "Did not find fuzz targets"
    time.sleep(2)
    print "Fuzzing phase complete"	
    
    

#Initial sense and then send the result at handshake freq
    tb.lock()
    sb.start()
    freq_list = sense_loop(sb)
    while True :
    	bin_results = find_hole(freq_list)
        if bin_results != 0 :
        	break;
    middle_bin = int(((bin_results[1]-bin_results[0])/2) + bin_results[0])
    print "Sensing complete, stoping senseblock preparation"
    sb.stop()
    sb.wait()
    tb.unlock()
    #Jump to handshake freq
    options.tx_freq=2362000000
    sink = uhd_transmitter(options.args, symbol_rate2,
                                        options.samples_per_symbol, options.tx_freq,
                                        options.lo_offset, options.tx_gain,
                                        options.spec, options.antenna,
                                        options.clock_source, options.verbose)
    txpath = transmit_path(modulator2, options)

    #Special pktno to distinguish sensing packets
    number = 3333
    #Set new transmit freq to midpoint of discovered window
    new_freq = str((middle_bin*27902) + 2357500000.0)
    payload_sense = struct.pack('!H', number & 0xffff) + new_freq
    #Send a large number of sensing packets (may change if ACK is developed), and then jump
    #to new freq
    for i in range(0, 2000):
    	send_pkt(payload_sense)
    time.sleep(1)
    options.tx_freq=(middle_bin*27902) + 2357500000.0
    sink = uhd_transmitter(options.args, symbol_rate2,
                                        options.samples_per_symbol, options.tx_freq,
                                        options.lo_offset, options.tx_gain,
                                        options.spec, options.antenna,
                                        options.clock_source, options.verbose)
    txpath = transmit_path(modulator2, options)

#Main transmit phase 
    # generate and send packets
    nbytes = int(1e6 * options.megabytes)
    n = 0
    pktno = 0
    pkt_size = int(options.size)
    
    # connect to server
    if options.server:
    	sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	server_address = ('10.0.0.200', 50000)
    	print >>sys.stderr, 'connecting to %s port %s' % server_address
    	sock.connect(server_address)


    while pktno <= 1000 and options.server:
	#print "nbytes :%s , pkt_size : %s , n : %s " %(nbytes, pkt_size, n)
        if options.server:
            data = "";
            while len(data) < pkt_size:
                data += sock.recv(pkt_size - len(data))
                if data == '':
                    # No more data received from server
                    sock.close()
                    break;
        elif options.from_file is None:
            data = (pkt_size - 2) * chr(pktno & 0xff)
        else:
            data = source_file.read(pkt_size - 2)
	pktno+=1
	packet_list.append(data)
    #Send packets in bursts of 100 or 165 and then sense again
    #Repeat process, until end of expirement
    loop_check = True
    while(1):
	for i in range(0, len(packet_list)):
		data=packet_list[i]
        	payload = struct.pack('!H', i & 0xffff) + data
        	send_pkt(payload)
        	sys.stderr.write('.')
        	#Alternate 2 loops, so that the system jumps at different packet numbers
		#This is to ensure, we dont lose packets due to transmitter jumping slightly faster
        	if i % 100 == 0 and i > 0 and loop_check:
			tb.lock()
    			    	
        		sb.start()
        		freq_list = sense_loop(sb)
			while True :
                		bin_results = find_hole(freq_list)
                		if bin_results != 0 :
                        		break;

        		middle_bin = int(((bin_results[1]-bin_results[0])/2) + bin_results[0])		
    			print "Sensing complete, stoping senseblock main"
			sb.stop()
			sb.wait()
			tb.unlock()
		        number = 3333
	        	new_freq = str((middle_bin*27902) + 2357500000.0)
       	        	payload_sense = struct.pack('!H', number & 0xffff) + new_freq

			for i in range(0, 2000):
				send_pkt(payload_sense)
			time.sleep(1)
			options.tx_freq=(middle_bin*27902) + 2357500000.0
        		sink = uhd_transmitter(options.args, symbol_rate2,
                                        options.samples_per_symbol, options.tx_freq,
                                        options.lo_offset, options.tx_gain,
                                        options.spec, options.antenna,
                                        options.clock_source, options.verbose)
        		txpath = transmit_path(modulator2, options)
		elif i % 165 == 0 and i > 0 and not loop_check:
                        tb.lock()

                        sb.start()
                        freq_list = sense_loop(sb)
                        while True :
                                bin_results = find_hole(freq_list)
                                if bin_results != 0 :
                                        break;

                        middle_bin = int(((bin_results[1]-bin_results[0])/2) + bin_results[0])
                        print "Sensing complete, stoping senseblock main"
                        sb.stop()
                        sb.wait()
                        tb.unlock()
                        number = 3333
                        new_freq = str((middle_bin*27902) + 2357500000.0)
                        payload_sense = struct.pack('!H', number & 0xffff) + new_freq

                        for i in range(0, 2000):
                                send_pkt(payload_sense)
                        time.sleep(1)
                        options.tx_freq=(middle_bin*27902) + 2357500000.0
                        sink = uhd_transmitter(options.args, symbol_rate2,
                                        options.samples_per_symbol, options.tx_freq,
                                        options.lo_offset, options.tx_gain,
                                        options.spec, options.antenna,
                                        options.clock_source, options.verbose)
                        txpath = transmit_path(modulator2, options)
	loop_check = not(loop_check)
        
    send_pkt(eof=True)

    tb.wait()                       # wait for it to finish

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        pass
