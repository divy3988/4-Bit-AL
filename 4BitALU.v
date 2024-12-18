// Verilog Code for 4-bit ALU Design

module ALU (
    input wire [3:0] A, B,      // 4-bit inputs A and B
    input wire [1:0] sel,       // 2-bit selection line
    output wire [3:0] result,   // 4-bit result output
    output wire carry_out,      // Carry out for addition/subtraction
    output wire borrow_out      // Borrow out for subtraction
);
    wire [3:0] sum, sub, nand_res, xor_res;
    wire c3_sum, c3_sub;

    // 4-bit Full Adder
    assign {c3_sum, sum} = A + B;

    // 4-bit Subtractor
    assign {borrow_out, sub} = A - B;

    // 4-bit NAND Gate
    assign nand_res = ~(A & B);

    // 4-bit XOR Gate
    assign xor_res = A ^ B;

    // 4-to-1 Multiplexer for result selection
    always @(*) begin
        case (sel)
            2'b00: result = sum;          // Addition
            2'b01: result = sub;          // Subtraction
            2'b10: result = nand_res;     // NAND operation
            2'b11: result = xor_res;      // XOR operation
            default: result = 4'b0000;    // Default to zero
        endcase
    end

    // Carry out for addition
    assign carry_out = c3_sum;

endmodule

// Testbench for ALU
module tb_ALU;
    reg [3:0] A, B;
    reg [1:0] sel;
    wire [3:0] result;
    wire carry_out, borrow_out;

    ALU uut (
        .A(A),
        .B(B),
        .sel(sel),
        .result(result),
        .carry_out(carry_out),
        .borrow_out(borrow_out)
    );

    initial begin
        // Test Addition
        A = 4'b0101; B = 4'b0011; sel = 2'b00; #10;
        $display("Addition: A=%b, B=%b, Result=%b, Carry=%b", A, B, result, carry_out);

        // Test Subtraction
        A = 4'b1000; B = 4'b0010; sel = 2'b01; #10;
        $display("Subtraction: A=%b, B=%b, Result=%b, Borrow=%b", A, B, result, borrow_out);

        // Test NAND
        A = 4'b1010; B = 4'b1100; sel = 2'b10; #10;
        $display("NAND: A=%b, B=%b, Result=%b", A, B, result);

        // Test XOR
        A = 4'b0110; B = 4'b1010; sel = 2'b11; #10;
        $display("XOR: A=%b, B=%b, Result=%b", A, B, result);

        $stop;
    end
endmodule
