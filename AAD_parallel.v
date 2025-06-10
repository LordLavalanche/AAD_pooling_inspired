`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2025 02:02:58 AM
// Design Name: 
// Module Name: AAD_parallel
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

module abs(input [7:0] a, output [7:0] b);
    assign b = (a[7] == 1'b1) ? (~a + 1) : a;
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
module SA(input [7:0] a, input [7:0] b, output [7:0] abs_diff);
    wire [7:0] diff;

    // Calculate the difference: diff = a - b
    kogge_stone subtractor(
        .x(a),
        .y(~b + 1), // Two's complement for subtraction
        .cin(1'b0),
        .sum(diff),
        .cout()
    );

    // Calculate the absolute value of the difference
    abs abs_module(
        .a(diff),
        .b(abs_diff)
    );
endmodule




//module pooling (
//    input  wire [7:0] matrix [0:7][0:7], 
//    output wire [7:0] horizontal_bus_0 [0:31], 
//    output wire [7:0] horizontal_bus_1 [0:31], 
//    output wire [7:0] vertical_bus_0 [0:31], 
//    output wire [7:0] vertical_bus_1 [0:31]
//);
//    genvar i, j;

//    // Generate for horizontal buses (even and odd rows)
//    generate
//        for (i = 0; i < 4; i = i + 1) begin : h_rows
//            for (j = 0; j < 8; j = j + 1) begin : h_cols
//                assign horizontal_bus_0[i * 8 + j] = matrix[i * 2][j];
//                assign horizontal_bus_1[i * 8 + j] = matrix[i * 2 + 1][j];
//            end
//        end
//    endgenerate

//    // Generate for vertical buses (even and odd columns)
//    generate
//        for (i = 0; i < 8; i = i + 1) begin : v_rows
//            for (j = 0; j < 4; j = j + 1) begin : v_cols
//                assign vertical_bus_0[i * 4 + j] = matrix[i][j * 2];
//                assign vertical_bus_1[i * 4 + j] = matrix[i][j * 2 + 1];
//            end
//        end
//    endgenerate
//endmodule
module pooling (
    input [7:0] matrix [0:7][0:7], 
    output reg [7:0] horizontal_bus_0 [0:31], 
    output reg [7:0] horizontal_bus_1 [0:31], 
    output reg [7:0] vertical_bus_0 [0:31], 
    output reg [7:0] vertical_bus_1 [0:31]
);
    integer i, j;
    integer h_idx_0, h_idx_1, v_idx_0, v_idx_1;

    always @(*) begin
        h_idx_0 = 0;
        h_idx_1 = 0;
        v_idx_0 = 0;
        v_idx_1 = 0;

        // Serialize for horizontal buses (alternate rows, stride = 1)
        for (i = 0; i < 8; i = i + 2) begin
            for (j = 0; j < 8; j = j + 1) begin
                horizontal_bus_0[h_idx_0] = matrix[i][j];
                h_idx_0 = h_idx_0 + 1;

                horizontal_bus_1[h_idx_1] = matrix[i+1][j];
                h_idx_1 = h_idx_1 + 1;
            end
        end

        // Serialize for vertical buses (alternate columns, stride = 1)
        for (i = 0; i < 8; i = i + 2) begin
            for (j = 0; j < 8; j = j + 1) begin
                vertical_bus_0[v_idx_0] = matrix[j][i];
                v_idx_0 = v_idx_0 + 1;

                vertical_bus_1[v_idx_1] = matrix[j][i+1];
                v_idx_1 = v_idx_1 + 1;
            end
        end
    end
endmodule

module divide_by_12 #(
    parameter stride = 2 // Configurable stride, default is 2
)(
    input [8:0] hor_pool_out [0:(32 / stride) - 1], // Input horizontal pool output
    input [8:0] ver_pool_out [0:(32 / stride) - 1], // Input vertical pool output
    output [8:0] hor_div_out [0:(32 / stride) - 1], // Output horizontal divided by 12
    output [8:0] ver_div_out [0:(32 / stride) - 1]  // Output vertical divided by 12
);
    genvar i;

    // Divide each element of hor_pool_out by 12
    generate
        for (i = 0; i < (32 / stride); i = i + 1) begin : hor_div_gen
            assign hor_div_out[i] = hor_pool_out[i] / 12;
        end
    endgenerate

    // Divide each element of ver_pool_out by 12
    generate
        for (i = 0; i < (32 / stride); i = i + 1) begin : ver_div_gen
            assign ver_div_out[i] = ver_pool_out[i] / 12;
        end
    endgenerate
endmodule

// module final_pooling #(
//     parameter stride = 2 // Configurable stride, default is 2
// )(
//     input [7:0] matrix [0:7][0:7],
//     output [8:0] hor_pool_out [0:(32 / stride) - 1], // Adjusted based on stride
//     output [8:0] ver_pool_out [0:(32 / stride) - 1]  // Adjusted based on stride
// );
//     wire [7:0] horizontal_bus_0 [0:31];
//     wire [7:0] horizontal_bus_1 [0:31];
//     wire [7:0] vertical_bus_0 [0:31];
//     wire [7:0] vertical_bus_1 [0:31];

//     // Instantiate the pooling module
//     pooling pool_inst(
//         .matrix(matrix),
//         .horizontal_bus_0(horizontal_bus_0),   
//         .horizontal_bus_1(horizontal_bus_1),
//         .vertical_bus_0(vertical_bus_0),
//         .vertical_bus_1(vertical_bus_1)
//     );

//     genvar i;

//     // Adjust lengths dynamically based on stride
//     wire [7:0] hor_sa_0 [0:(32 / stride) - 1];
//     wire [7:0] hor_sa_1 [0:(32 / stride) - 1];
//     wire [7:0] ver_sa_0 [0:(32 / stride) - 1];
//     wire [7:0] ver_sa_1 [0:(32 / stride) - 1];

//     // Generate absolute differences for horizontal buses
//     generate
//         for (i = 0; i < (32 / stride); i = i + 1) begin : hor_sa_gen
//             SA sa_hor0(.a(horizontal_bus_0[i * stride]), .b(horizontal_bus_0[i * stride + 1]), .abs_diff(hor_sa_0[i]));
//             SA sa_hor1(.a(horizontal_bus_1[i * stride]), .b(horizontal_bus_1[i * stride + 1]), .abs_diff(hor_sa_1[i]));
//         end
//     endgenerate

//     // Generate absolute differences for vertical buses
//     generate
//         for (i = 0; i < (32 / stride); i = i + 1) begin : ver_sa_gen
//             SA sa_ver0(.a(vertical_bus_0[i * stride]), .b(vertical_bus_0[i * stride + 1]), .abs_diff(ver_sa_0[i]));
//             SA sa_ver1(.a(vertical_bus_1[i * stride]), .b(vertical_bus_1[i * stride + 1]), .abs_diff(ver_sa_1[i]));
//         end
//     endgenerate

//     // Compute final sums for horizontal pooling
//     generate
//         for (i = 0; i < (32 / stride); i = i + 1) begin : hor_sum_gen
//             kogge_stone ks_hor(.x(hor_sa_0[i]), .y(hor_sa_1[i]), .cin(1'b0), .sum(hor_pool_out[i]), .cout());
//         end
//     endgenerate

//     // Compute final sums for vertical pooling
//     generate
//         for (i = 0; i < (32 / stride); i = i + 1) begin : ver_sum_gen
//             kogge_stone ks_ver(.x(ver_sa_0[i]), .y(ver_sa_1[i]), .cin(1'b0), .sum(ver_pool_out[i]), .cout());
//         end
//     endgenerate
// endmodule
module final_pooling #(
    parameter stride = 2 
)(
    input [7:0] matrix [0:7][0:7],
    output [8:0] hor_pool_out [0:(32 / stride) - 1], // Adjusted based on stride
    output [8:0] ver_pool_out [0:(32 / stride) - 1], // Adjusted based on stride
    output [8:0] hor_div_out [0:(32 / stride) - 1], // Horizontal pool output divided by 12
    output [8:0] ver_div_out [0:(32 / stride) - 1]  // Vertical pool output divided by 12
);
    wire [7:0] horizontal_bus_0 [0:31];
    wire [7:0] horizontal_bus_1 [0:31];
    wire [7:0] vertical_bus_0 [0:31];
    wire [7:0] vertical_bus_1 [0:31];

    pooling pool_inst(
        .matrix(matrix),
        .horizontal_bus_0(horizontal_bus_0),   
        .horizontal_bus_1(horizontal_bus_1),
        .vertical_bus_0(vertical_bus_0),
        .vertical_bus_1(vertical_bus_1)
    );

    genvar i;

    // Adjust lengths dynamically based on stride
    wire [7:0] hor_sa_0 [0:(32 / stride) - 1];
    wire [7:0] hor_sa_1 [0:(32 / stride) - 1];
    wire [7:0] ver_sa_0 [0:(32 / stride) - 1];
    wire [7:0] ver_sa_1 [0:(32 / stride) - 1];

    generate
        for (i = 0; i < (32 / stride); i = i + 1) begin : hor_sa_gen
            SA sa_hor0(.a(horizontal_bus_0[i * stride]), .b(horizontal_bus_0[i * stride + 1]), .abs_diff(hor_sa_0[i]));
            SA sa_hor1(.a(horizontal_bus_1[i * stride]), .b(horizontal_bus_1[i * stride + 1]), .abs_diff(hor_sa_1[i]));
        end
    endgenerate

    generate
        for (i = 0; i < (32 / stride); i = i + 1) begin : ver_sa_gen
            SA sa_ver0(.a(vertical_bus_0[i * stride]), .b(vertical_bus_0[i * stride + 1]), .abs_diff(ver_sa_0[i]));
            SA sa_ver1(.a(vertical_bus_1[i * stride]), .b(vertical_bus_1[i * stride + 1]), .abs_diff(ver_sa_1[i]));
        end
    endgenerate

    generate
        for (i = 0; i < (32 / stride); i = i + 1) begin : hor_sum_gen
            kogge_stone ks_hor(.x(hor_sa_0[i]), .y(hor_sa_1[i]), .cin(1'b0), .sum(hor_pool_out[i]), .cout());
        end
    endgenerate

  
    generate
        for (i = 0; i < (32 / stride); i = i + 1) begin : ver_sum_gen
            kogge_stone ks_ver(.x(ver_sa_0[i]), .y(ver_sa_1[i]), .cin(1'b0), .sum(ver_pool_out[i]), .cout());
        end
    endgenerate


    divide_by_12 #(
        .stride(stride)
    ) div_inst (
        .hor_pool_out(hor_pool_out),
        .ver_pool_out(ver_pool_out),
        .hor_div_out(hor_div_out),
        .ver_div_out(ver_div_out)
    );
endmodule