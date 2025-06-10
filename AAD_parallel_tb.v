
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2025 02:11:27 PM
// Design Name: 
// Module Name: final_pooling_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for final_pooling module with divide_by_12 functionality
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module final_pooling_tb();

    reg [7:0] matrix[0:7][0:7];
    wire [8:0] hor_pool_out [0:15];
    wire [8:0] ver_pool_out [0:15];
    wire [8:0] hor_div_out [0:15];
    wire [8:0] ver_div_out [0:15];

    integer i, j;

    // Instantiate the module
    final_pooling uut (
        .matrix(matrix),
        .hor_pool_out(hor_pool_out),
        .ver_pool_out(ver_pool_out),
        .hor_div_out(hor_div_out),
        .ver_div_out(ver_div_out)
    );

    initial begin
        $display("===== Testbench for final_pooling =====");

        // Initialize input matrix with known values (row-major increasing)
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                matrix[i][j] = i * 8 + j;
            end
        end

        #10; // wait for output to stabilize

        // Display horizontal pool output
        $display("Horizontal Pool Output:");
        for (i = 0; i < 16; i = i + 1) begin
            $display("hor_pool_out[%0d] = %0d", i, hor_pool_out[i]);
        end

        // Display vertical pool output
        $display("Vertical Pool Output:");
        for (i = 0; i < 16; i = i + 1) begin
            $display("ver_pool_out[%0d] = %0d", i, ver_pool_out[i]);
        end

        // Display horizontal divided output
        $display("Horizontal Divided Output (hor_div_out):");
        for (i = 0; i < 16; i = i + 1) begin
            $display("hor_div_out[%0d] = %0d", i, hor_div_out[i]);
        end

        // Display vertical divided output
        $display("Vertical Divided Output (ver_div_out):");
        for (i = 0; i < 16; i = i + 1) begin
            $display("ver_div_out[%0d] = %0d", i, ver_div_out[i]);
        end

        $finish;
    end

endmodule