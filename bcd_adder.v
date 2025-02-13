`timescale 1ns/1ps  

//bcd adder module
module bcd_adder (
    input wire a0, a1, a2, a3;
    input wire b0, b1, b2, b3;
    input wire clk, enable, store, reset;
    output wire c0, c1, c2, c3;
    //Internal variables
    reg [3:0] a, b, c;
    reg [4:0] sum;
    reg carry; 
    );

    always @(posedge clk and enable) begin
        a <= {a3, a2, a1, a0}; // combining four 1-bit inputs
        b <= {b3, b2, b1, b0};
        
        sum = a + b; // 4-bit addition

        //convert to bcd if required
        if (sum[3:0] >= 4'b1010) begin 
            temp = sum + 5'b00110; // converted to bcd
            c = temp[3:0];
            end
        
        else begin
            c = sum[3:0];
            end
        
        c0 = c[0]; c1 = c[1]; c2 = c[2]; c3 = c[3];
        // c is BCD
    end

    always @(store) begin
        storage s(.clk(clk), .reset(reset), .store(store), .data_in(c), .data_out(out_wire));
    end
endmodule

//storage module
module storage(
    input wire clk, reset;
    input wire [3:0] data_in;
    output wire [3:0] data_out;
    );

    d_flip_flop d_ff0 (.d(data_in[0]), .clk(clk), .reset(reset), .q(data_out[0]));
    d_flip_flop d_ff1 (.d(data_in[1]), .clk(clk), .reset(reset), .q(data_out[1]));
    d_flip_flop d_ff2 (.d(data_in[2]), .clk(clk), .reset(reset), .q(data_out[2]));
    d_flip_flop d_ff3 (.d(data_in[3]), .clk(clk), .reset(reset), .q(data_out[3]));

endmodule

//d flip flop
module d_flip_flop (
    input wire d, clk, reset,      // Data, Clock, Reset input
    output reg q   // Output
 );
 always @(posedge clk or posedge reset) begin
    if (reset) begin  // if reset is true
        q <= 1'b0;     // Reset the output to 0
    end else begin
        q <= d;        // On clock edge, set output to data input
    end
 end

endmodule
