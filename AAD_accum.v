`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2025 12:17:50 PM
// Design Name: 
// Module Name: AAD_accumulatorbased
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
//i have ommited the divider
//module gray_cell(Gkj, Pik, Gik, G);
//    // gray cell
//    input Gkj, Pik, Gik;
//    output G;
//    wire Y;
//    and(Y, Gkj, Pik);
//    or(G, Y, Gik);
//endmodule

//module black_cell(Gkj, Pik, Gik, Pkj, G, P);
//    // black cell
//    input Gkj, Pik, Gik, Pkj;
//    output G, P;
//    wire Y;
//    and(Y, Gkj, Pik);
//    or(G, Gik, Y);
//    and(P, Pkj, Pik);
//endmodule

//module and_xor(a, b, p, g);
    
//    input a, b;
//    output p, g;
//    xor(p, a, b);
//    and(g, a, b);
//endmodule

//module kogge_stone (x, w, sum, cin, cout);
//    // kogge stone structural model
//    input [7:0] w, x;
//    output [7:0] sum;
//    input cin;
//    output cout;

//    wire [7:0] y;
//    assign y = (~w) + 1;

//    wire [7:0] G_Z, P_Z;
//    wire [7:0] G_A, P_A;
//    wire [7:0] G_B, P_B;
//    wire [7:0] G_C, P_C;

//    // level 0
//    and_xor level_Z0(x[0], y[0], P_Z[0], G_Z[0]);
//    and_xor level_Z1(x[1], y[1], P_Z[1], G_Z[1]);
//    and_xor level_Z2(x[2], y[2], P_Z[2], G_Z[2]);
//    and_xor level_Z3(x[3], y[3], P_Z[3], G_Z[3]);
//    and_xor level_Z4(x[4], y[4], P_Z[4], G_Z[4]);
//    and_xor level_Z5(x[5], y[5], P_Z[5], G_Z[5]);
//    and_xor level_Z6(x[6], y[6], P_Z[6], G_Z[6]);
//    and_xor level_Z7(x[7], y[7], P_Z[7], G_Z[7]);

//    // level 1
//    gray_cell level_0A(cin, P_Z[0], G_Z[0], G_A[0]);
//    black_cell level_1A(G_Z[0], P_Z[1], G_Z[1], P_Z[0], G_A[1], P_A[1]);
//    black_cell level_2A(G_Z[1], P_Z[2], G_Z[2], P_Z[1], G_A[2], P_A[2]);
//    black_cell level_3A(G_Z[2], P_Z[3], G_Z[3], P_Z[2], G_A[3], P_A[3]);
//    black_cell level_4A(G_Z[3], P_Z[4], G_Z[4], P_Z[3], G_A[4], P_A[4]);
//    black_cell level_5A(G_Z[4], P_Z[5], G_Z[5], P_Z[4], G_A[5], P_A[5]);
//    black_cell level_6A(G_Z[5], P_Z[6], G_Z[6], P_Z[5], G_A[6], P_A[6]);
//    black_cell level_7A(G_Z[6], P_Z[7], G_Z[7], P_Z[6], G_A[7], P_A[7]);

//    // level 2
//    gray_cell level_1B(cin, P_A[1], G_A[1], G_B[1]);
//    gray_cell level_2B(G_A[0], P_A[2], G_A[2], G_B[2]);
//    black_cell level_3B(G_A[1], P_A[3], G_A[3], P_A[1], G_B[3], P_B[3]);
//    black_cell level_4B(G_A[2], P_A[4], G_A[4], P_A[2], G_B[4], P_B[4]);
//    black_cell level_5B(G_A[3], P_A[5], G_A[5], P_A[3], G_B[5], P_B[5]);
//    black_cell level_6B(G_A[4], P_A[6], G_A[6], P_A[4], G_B[6], P_B[6]);
//    black_cell level_7B(G_A[5], P_A[7], G_A[7], P_A[5], G_B[7], P_B[7]);

//    // level 3
//    gray_cell level_3C(cin, P_B[3], G_B[3], G_C[3]);
//    gray_cell level_4C(G_A[0], P_B[4], G_B[4], G_C[4]);
//    gray_cell level_5C(G_B[1], P_B[5], G_B[5], G_C[5]);
//    gray_cell level_6C(G_B[2], P_B[6], G_B[6], G_C[6]);
//    black_cell level_7C(G_B[3], P_B[7], G_B[7], P_B[3], G_C[7], P_C[7]);

//    // level 4
//    gray_cell level_7D(cin, P_C[7], G_C[7], cout);

//    // output sum
//    xor(sum[0], cin, P_Z[0]);
//    xor(sum[1], G_A[0], P_Z[1]);
//    xor(sum[2], G_B[1], P_Z[2]);
//    xor(sum[3], G_B[2], P_Z[3]);
//    xor(sum[4], G_C[3], P_Z[4]);
//    xor(sum[5], G_C[4], P_Z[5]);
//    xor(sum[6], G_C[5], P_Z[6]);
//    xor(sum[7], G_C[6], P_Z[7]);
//endmodule

//module abs(input clk, input rst, input [7:0] a, output reg [7:0] b);
//    always @(posedge clk or posedge rst) begin
//        if (rst)
//            b <= 8'd0;
//        else if (a[7] == 1'b1)
//            b <= (~a) + 1;
//        else
//            b <= a;
//    end
//endmodule

//module sum(input [7:0] a, input [7:0] b, input clk, input rst, output reg [7:0] c);
//    always @(posedge clk or posedge rst) begin
//        if (rst)
//            c <= 8'd0;
//        else
//            c <= a + b;
//    end
//endmodule

//module top(input [7:0] a, input [7:0] b, input clk, input rst, output reg [7:0] prev);
//    wire [7:0] temp;
//    wire [7:0] addin;
//    wire [7:0] feed;

 
//    kogge_stone k0(.x(a), .w(b), .cin(1'b0), .sum(temp), .cout());
//    abs a0(.clk(clk), .rst(rst), .a(temp), .b(addin));
//    sum s0(.a(addin), .b(prev), .clk(clk), .rst(rst), .c(feed));

//    always @(posedge clk or posedge rst) begin
//        if (rst)
//            prev <= 8'd0;
//        else
//            prev <= feed;
//    end
//endmodule
//i have ommited the divider
module abs(input [7:0] a, output [7:0] b);
    assign b = (a[7] == 1'b1) ? (~a + 1) : a;
endmodule
module top(input [7:0] a, input [7:0] b, input clk, input rst, output reg [7:0] prev);
    wire [7:0] temp;
    wire [7:0] addin;
    wire [7:0] feed;

    // temp = a - b
    kogge_stone k0(.x(a), .y(~b + 1), .cin(1'b0), .sum(temp), .cout());

    // addin = |a - b|
    abs a0(.a(temp), .b(addin));

    // feed = prev + addin
    kogge_stone k1(.x(addin), .y(prev), .cin(1'b0), .sum(feed), .cout());

    always @(posedge clk or posedge rst) begin
        if (rst)
            prev <= 8'd0;
        else
            prev <= feed;
    end
endmodule
module gray_cell(Gkj, Pik, Gik, G);
    input Gkj, Pik, Gik;
    output G;
    wire Y;
    and(Y, Gkj, Pik);
    or(G, Y, Gik);
endmodule
module black_cell(Gkj, Pik, Gik, Pkj, G, P);
    input Gkj, Pik, Gik, Pkj;
    output G, P;
    wire Y;
    and(Y, Gkj, Pik);
    or(G, Gik, Y);
    and(P, Pkj, Pik);
endmodule
module and_xor(a, b, p, g);
    input a, b;
    output p, g;
    xor(p, a, b);
    and(g, a, b);
endmodule
module kogge_stone(x, y, sum, cin, cout);
    input [7:0] y, x;
    output [7:0] sum;
    input cin;
    output cout;

    wire [7:0] G_Z, P_Z;
    wire [7:0] G_A, P_A;
    wire [7:0] G_B, P_B;
    wire [7:0] G_C, P_C;

    // level 0
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen0
            and_xor ax(x[i], y[i], P_Z[i], G_Z[i]);
        end
    endgenerate

    // level 1
    gray_cell gc0(cin, P_Z[0], G_Z[0], G_A[0]);
    black_cell bc1(G_Z[0], P_Z[1], G_Z[1], P_Z[0], G_A[1], P_A[1]);
    black_cell bc2(G_Z[1], P_Z[2], G_Z[2], P_Z[1], G_A[2], P_A[2]);
    black_cell bc3(G_Z[2], P_Z[3], G_Z[3], P_Z[2], G_A[3], P_A[3]);
    black_cell bc4(G_Z[3], P_Z[4], G_Z[4], P_Z[3], G_A[4], P_A[4]);
    black_cell bc5(G_Z[4], P_Z[5], G_Z[5], P_Z[4], G_A[5], P_A[5]);
    black_cell bc6(G_Z[5], P_Z[6], G_Z[6], P_Z[5], G_A[6], P_A[6]);
    black_cell bc7(G_Z[6], P_Z[7], G_Z[7], P_Z[6], G_A[7], P_A[7]);

    // level 2
    gray_cell gc1(cin, P_A[1], G_A[1], G_B[1]);
    gray_cell gc2(G_A[0], P_A[2], G_A[2], G_B[2]);
    black_cell bc3b(G_A[1], P_A[3], G_A[3], P_A[1], G_B[3], P_B[3]);
    black_cell bc4b(G_A[2], P_A[4], G_A[4], P_A[2], G_B[4], P_B[4]);
    black_cell bc5b(G_A[3], P_A[5], G_A[5], P_A[3], G_B[5], P_B[5]);
    black_cell bc6b(G_A[4], P_A[6], G_A[6], P_A[4], G_B[6], P_B[6]);
    black_cell bc7b(G_A[5], P_A[7], G_A[7], P_A[5], G_B[7], P_B[7]);

    // level 3
    gray_cell gc3(cin, P_B[3], G_B[3], G_C[3]);
    gray_cell gc4(G_A[0], P_B[4], G_B[4], G_C[4]);
    gray_cell gc5(G_B[1], P_B[5], G_B[5], G_C[5]);
    gray_cell gc6(G_B[2], P_B[6], G_B[6], G_C[6]);
    black_cell bc7c(G_B[3], P_B[7], G_B[7], P_B[3], G_C[7], P_C[7]);

    // level 4
    gray_cell gc7(cin, P_C[7], G_C[7], cout);

    // sum generation
    xor(sum[0], cin, P_Z[0]);
    xor(sum[1], G_A[0], P_Z[1]);
    xor(sum[2], G_B[1], P_Z[2]);
    xor(sum[3], G_B[2], P_Z[3]);
    xor(sum[4], G_C[3], P_Z[4]);
    xor(sum[5], G_C[4], P_Z[5]);
    xor(sum[6], G_C[5], P_Z[6]);
    xor(sum[7], G_C[6], P_Z[7]);
endmodule


