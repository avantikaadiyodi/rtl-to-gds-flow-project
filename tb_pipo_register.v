module testbench;
    reg clk, reset, load;
    reg [7:0] data_in;
    wire [7:0] data_out;

    pipo_register uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin //clock generation
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock 
    end

    // Stimulus
    initial begin
        // Initialize inputs
        data_in = 8'b00000000; #100;
        reset = 1; #10;
        load = 1; #10;
      	reset = 0; #10;
        
        // Apply test vectors
        data_in = 8'b10111010; #10;
        #160
        $finish;
    end

    // Dumpfile and Dumpvars
    initial begin
        $dumpfile("waveform.vcd"); // Name of the VCD file
        $dumpvars(0, testbench); // Dump all variables
    end
endmodule