`timescale 1ns/1ps  

//bcd adder module
module bcd_adder (
    input wire a0, a1, a2, a3;
    input wire b0, b1, b2, b3;
    output wire c0, c1, c2, c3;
    output wire carry_out, out_wire;
    input wire clk;
    input wire enable, store;
    //Internal variables
    reg [3:0] a, b, c, c_in;
    //reg [4:0] sum_temp;
    reg [4:0] sum;
    reg carry; 
    );

    always @(posedge clk or posedge enable) begin
        //combined_reg <= {in_wires[3], in_wires[2], in_wires[1], in_wires[0]};
        a <= {a3, a2, a1, a0}; // combining four 1-bit inputs
        b <= {b3, b2, b1, b0};
        
        sum = a + b + c_in; // 4-bit addition
        carry = sum[4]; // msb as carry
        //4_bit_adder adder(.in_wire1(a), .in_wire2(b), .out_wire(sum), .carry_out(carry)); // addition using extra module

        //convert to bcd if required
        if (sum[3:0] >= 4'b1010) begin 
            sum[4] = 1'b0; // to make msb equal to 0, in case of overflow
            temp[4:0] = sum[4:0] + 5'b00110; // converted to bcd
            c = temp[3:0];
            end
        
        else begin
            c = sum[3:0];
            end
        
        c0 = c[0]; c1 = c[1]; c2 = c[2]; c3 = c[3];
        carry_out = carry;
        // c is BCD
    end

    always @(store) begin
        storage s(.clk(clk), .reset(reset), .store(store), .data_in(c), .data_out(out_wire));
    end
endmodule

//storage module
module storage(
    input wire clk;
    input wire reset;
    input wire store;
    input wire [3:0] data_in;
    output wire [3:0] data_out;

    );

    d_flip_flop d_ff0 (.d(data_in[0]), .clk(store), .reset(reset), .q(data_out[0]));
    d_flip_flop d_ff1 (.d(data_in[1]), .clk(store), .reset(reset), .q(data_out[1]));
    d_flip_flop d_ff2 (.d(data_in[2]), .clk(store), .reset(reset), .q(data_out[2]));
    d_flip_flop d_ff3 (.d(data_in[3]), .clk(store), .reset(reset), .q(data_out[3]));

endmodule

//d flip flop
module d_flip_flop (
    input wire d,      // Data input
    input wire clk,    // Clock input
    input wire reset,  // Reset input
    output reg q   // Outputs
 );
 always @(posedge clk or posedge reset) begin
    if (reset) begin  // if reset is true
        q <= 1'b0;     // Reset the output to 0
    end else begin
        q <= d;        // On clock edge, set output to data input
    end
 end

endmodule

//module to add two 4-bit numbers
module 4bit_adder (
    input wire[3:0] in_wire1;
    input wire [3:0] in_wire2;
    output wire [3:0] out_wire;
    output carry_out;
    wire [3:0] temp_wire;
    );

 always @(posedge clk or posedge reset) begin
        temp_wire1 <= 1'b0;
        temp_wire2 <= 1'b0;
        full_adder f0(.a(in_wire1[0]), .b(in_wire2[0]), .c_in(temp_wire[0]), .sum(out_wire[0]), .c_out(temp_wire[1]));
        full_adder f1(.a(in_wire1[1]), .b(in_wire2[1]), .c_in(temp_wire[1]), .sum(out_wire[1]), .c_out(temp_wire[2]));
        full_adder f2(.a(in_wire1[2]), .b(in_wire2[2]), .c_in(temp_wire[2]), .sum(out_wire[2]), .c_out(temp_wire[3]));
        full_adder f3(.a(in_wire1[3]), .b(in_wire2[3]), .c_in(temp_wire[3]), .sum(out_wire[3]), .c_out(carry_out));
 end

endmodule

// module to add three 1-bit numbers
module full_adder (
    input wire a, b, c_in;
    output wire sum, c_out;
    );

    assign sum = (a ^ b ^ c_in);
    assign c_out = ((a & b) | (a & c_in) | (b & c_in));

endmodule