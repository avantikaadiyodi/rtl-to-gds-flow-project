module pipo_register (clk, reset, load, data_in, data_out);
    input wire clk, reset, load;
    input reg [3:0] data_in;
    output reg [3:0] data_out;

    always@(posedge clk or posedge reset) begin
        if (reset) begin
            data_out<=4'b0000;
        end
        else if (load) begin
            data_out <= data_in;
        end
    end
endmodule
