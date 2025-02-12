`timescale 1ns/1ps

module testbench;
    wire a0, a1, a2, a3;
    wire b0, b1, b2, b3;
    wire c0, c1, c2, c3;
    wire carry_out, clk, enable;
	
    bcd_adder uut (.a0(a0), .a1(a1), .a2(a2), .a3(a3),
                   .b0(b0), .b1(b1), .b2(b2), .b3(b3),
                   .c0(c0), .c1(c1), .c2(c2), .c3(c3),
                   .carry_out(carry_out),
                   .clk(clk), .enable(enable));

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock (changing every 5ns)
    end

    // Stimulus
    initial begin
        // Initialize inputs
        a0 = 0; a1 = 1; a2 = 0; a3 = 0;
        b0 = 1; b1 = 0; b2 = 0; b3 = 0;
        reset = 1;
        #10; // wait for 10 units of time (10ns) before moving to next line
        
        // Release reset
        reset = 0; #10;
        
        enable = 1; #10; // Enable the adder

        store = 1; #10; // Enable storage
      	
        store = 0; #10; // Disable storage
        // Apply test vectors
      	integer i;
      	for (i = 1; i < 5; i = i + 1) begin
          	d = i % 2;
         	#10;
    	end
        
        // Finish simulation
        $finish;
    end

    // Monitor signals
    initial begin
      $monitor("At time %t, d = %b, clk = %b, reset = %b, q = %b, q_ = %b", $time, d, clk, reset, q, q_);
    end
  
  	// Dumpfile and Dumpvars
	initial begin
  		$dumpfile("waveform.vcd"); // Name of the VCD file
  		$dumpvars(0, testbench); // Dump all variables
  
	end
endmodule