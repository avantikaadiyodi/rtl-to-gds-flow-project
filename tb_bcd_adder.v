`timescale 1ns/1ps

module testbench;
    wire a0, a1, a2, a3;
    wire b0, b1, b2, b3;
    wire clk, enable, store, reset;
    wire c0, c1, c2, c3;
    
    bcd_adder uut (
      .a0(a0), .a1(a1), .a2(a2), .a3(a3),
      .b0(b0), .b1(b1), .b2(b2), .b3(b3),
      .clk(clk), .enable(enable), .store(store), .reset(reset),
      .c0(c0), .c1(c1), .c2(c2), .c3(c3),
      );

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
        reset = 1; #10;
        
        // Release reset
        reset = 0; #10;
        
        enable = 1; #50; // Enable the adder

        store = 1; #50; // Enable storage
      	
        store = 0; #10; // Disable storage
    	end
        
        // Finish simulation
        $finish;

    // Monitor signals
    initial begin
      $monitor("At time %t, c0 = %b, c1 = %b, c2 = %b, c3 = %b, store = %b, enable = %b, reset = %b", $time, c0, c1, c2, c3, store, enable, reset);
    end
  
  	// Dumpfile and Dumpvars
	initial begin
  		$dumpfile("waveform.vcd"); // Name of the VCD file
  		$dumpvars(0, testbench); // Dump all variables
  
	end
endmodule
