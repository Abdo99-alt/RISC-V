module add_by_4 (
    PC, PCPlus4
);
    input [31:0] PC;
    output wire [31:0] PCPlus4;
    /////////////////////////////////////////////
    assign PCPlus4 = PC + 32'h0004;
endmodule