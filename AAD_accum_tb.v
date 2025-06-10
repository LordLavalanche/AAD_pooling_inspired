`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2025 01:21:16 PM
// Design Name: 
// Module Name: test_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//module tb2lf; // testbench for the 8-bit unsigned Kogge-Stone adder
//// exhaustive checking of all 256*256*2 possible cases
//reg [7:0] a, b; // 8-bit operands
//reg c0; // carry input
//wire [7:0] s; // 8-bit sum output
//wire c8; // carry output
//reg [8:0] check; // 9-bit value used to check correctess
//integer i, j, k; // loop variables
//integer num_correct; // counter to keep track of the number correct
//integer num_wrong; // counter to keep track of the number wrong
//// instantiate the 8-bit Kogge-Stone adder
//kogge_stone ks1(a, b, s, c0, c8);
//// exhaustive checking
//initial begin
//// initialize the counter variables
//num_correct = 0; num_wrong = 0;
//// loop through all possible cases and record the results
////for (i = 0; i < 256; i = i + 1) begin
////a = i;
//a=100;
//for (j = 0; j < 256; j = j + 1) begin
//b = j;
//for (k = 0; k < 2; k = k + 1) begin
//c0 = k;
//check = a + b + c0;
//// compute and check the product
//#10 if ({c8, s} == check)
//num_correct = num_correct + 1;
//else
//num_wrong = num_wrong + 1;
//// following line is for debugging
//// $display($time, " %d + %d + %d = %d (%d)", a, b, c0, {c8, s}, check);
 
//end
//end
//// print the final counter values
//$display("num_correct = %d, num_wrong = %d", num_correct, num_wrong);

//end
//endmodule

`timescale 1ns/1ps

module top_tb;
    reg [7:0] a, b;
    reg clk, rst;
    wire [7:0] prev;

    // Instantiate DUT
    top uut (
        .a(a),
        .b(b),
        .clk(clk),
        .rst(rst),
        .prev(prev)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Simple stimulus
    initial begin
        // Initialize
        rst = 1; a = 0; b = 0;
        #12;      // wait a bit extra to avoid clock edge
        rst = 0;

        // First input
        #1;  a = 8'd10;  b = 8'd3;
        #10; // wait 2 clk cycles

        // Second input
        a = 8'd20;  b = 8'd30;
        #10;

        // Third input
        a = 8'd5;   b = 8'd1;
        #10;

        // Fourth input
        a = 8'd100; b = 8'd100;
        #10;

        // Fifth input
        a = 8'd0;   b = 8'd255;
        #10;

        // Final result
        $display("Final accumulated absolute difference: %d", prev);
        #10;
        $finish;
    end
endmodule
