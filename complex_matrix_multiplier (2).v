module complex_matrix_multiplier(
    input signed [31:0] x11_real, x11_imag,
    input signed [31:0] x12_real, x12_imag,
    input signed [31:0] x21_real, x21_imag,
    input signed [31:0] x22_real, x22_imag,
    input signed [31:0] u11_real, u11_imag,
    input signed [31:0] u12_real, u12_imag,
    input signed [31:0] u21_real, u21_imag,
    input signed [31:0] u22_real, u22_imag,
    output signed [31:0] R11_real, R11_imag,
    output signed [31:0] R12_real, R12_imag,
    output signed [31:0] R21_real, R21_imag,
    output signed [31:0] R22_real, R22_imag
);
 
    assign R11_real = (x11_real * u11_real) - (x11_imag * u11_imag) + (x12_real * u21_real) - (x12_imag * u21_imag);
    assign R11_imag = (x11_real * u11_imag) + (x11_imag * u11_real) + (x12_real * u21_imag) + (x12_imag * u21_real);
    assign R12_real = (x11_real * u12_real) - (x11_imag * u12_imag) + (x12_real * u22_real) - (x12_imag * u22_imag);
    assign R12_imag = (x11_real * u12_imag) + (x11_imag * u12_real) + (x12_real * u22_imag) + (x12_imag * u22_real);
    assign R21_real = (x21_real * u11_real) - (x21_imag * u11_imag) + (x22_real * u21_real) - (x22_imag * u21_imag);
    assign R21_imag = (x21_real * u11_imag) + (x21_imag * u11_real) + (x22_real * u21_imag) + (x22_imag * u21_real);
    assign R22_real = (x21_real * u12_real) - (x21_imag * u12_imag) + (x22_real * u22_real) - (x22_imag * u22_imag);
    assign R22_imag = (x21_real * u12_imag) + (x21_imag * u12_real) + (x22_real * u22_imag) + (x22_imag * u22_real);
 
endmodule
module complex_matrix_multiplier_tb;
 
reg signed [31:0] x11_real, x11_imag, x12_real, x12_imag, x21_real, x21_imag, x22_real, x22_imag;
reg signed [31:0] u11_real, u11_imag, u12_real, u12_imag, u21_real, u21_imag, u22_real, u22_imag;
wire signed [31:0] R11_real, R11_imag, R12_real, R12_imag, R21_real, R21_imag, R22_real, R22_imag;
 
complex_matrix_multiplier DUT (
    .x11_real(x11_real), .x11_imag(x11_imag), .x12_real(x12_real), .x12_imag(x12_imag),
    .x21_real(x21_real), .x21_imag(x21_imag), .x22_real(x22_real), .x22_imag(x22_imag),
    .u11_real(u11_real), .u11_imag(u11_imag), .u12_real(u12_real), .u12_imag(u12_imag),
    .u21_real(u21_real), .u21_imag(u21_imag), .u22_real(u22_real), .u22_imag(u22_imag),
    .R11_real(R11_real), .R11_imag(R11_imag), .R12_real(R12_real), .R12_imag(R12_imag),
    .R21_real(R21_real), .R21_imag(R21_imag), .R22_real(R22_real), .R22_imag(R22_imag)
);
 
initial begin
    // Test case 1: Identity matrices
    x11_real = 9; x11_imag = 7; x12_real = 9; x12_imag = 8;
    x21_real = 4; x21_imag = 5; x22_real = 2; x22_imag = 5;
    
    u11_real = 1; u11_imag = 7; u12_real = 4; u12_imag = 3;
    u21_real = 2; u21_imag = 8; u22_real = 1; u22_imag = 5;
    
#10;
   $display("Test Case 1: Identity matrices");
    $display("Result: R11 = %d + %di, R12 = %d + %di", R11_real, R11_imag, R12_real, R12_imag);
    $display("        R21 = %d + %di, R22 = %d + %di", R21_real, R21_imag, R22_real, R22_imag);

    
    // Test case 2: Random matrices
    x11_real = 0; x11_imag = 1; x12_real = -1; x12_imag = 4;
    x21_real = 1; x21_imag = 6; x22_real = -2; x22_imag = -3;
    
    u11_real = -1; u11_imag = 2; u12_real = 3; u12_imag = 1;
    u21_real = 4; u21_imag = -5; u22_real = 2; u22_imag = -4;
    
    #10;
    $display("Test Case 2: Random matrices");
    $display("Result: R11 = %d + %di, R12 = %d + %di", R11_real, R11_imag, R12_real, R12_imag);
    $display("        R21 = %d + %di, R22 = %d + %di", R21_real, R21_imag, R22_real, R22_imag);
end
 
endmodule