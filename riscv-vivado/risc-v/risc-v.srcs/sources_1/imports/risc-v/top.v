module top (
    clk, reset
);
    input clk, reset;
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    wire [31:0] PC, Instr, ALUResult, RD, WD;
    wire RegWrite, Zero, MemWrite, ResultSrc, ALUSrc, PCSrc, Jump;
    wire [1:0] ImmSrc, ALUCtrl;
    reg [8*4 : 1] op_literal;
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    datapath datapath (clk, reset, RegWrite, ALUSrc, PCSrc, ResultSrc, Jump, Instr, ALUCtrl, ImmSrc, RD, PC, ALUResult, WD, Zero);
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ctrl_unit ctrl_unit (Instr[6:0], Instr[14:12], Instr[30], Zero, ImmSrc, ALUCtrl, RegWrite, ALUSrc, MemWrite, ResultSrc, PCSrc, Jump);
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    instr_mem instr_mem (PC, Instr);
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    data_mem data_mem (clk, MemWrite, WD, ALUResult, RD);
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    always @(PC) begin
        case (Instr[6:0])
            7'b0000011: op_literal = "LW";
            7'b0100011: op_literal = "SW";
            7'b1100011: begin
                if (Instr[12] == 1'b0)
                    op_literal = "BEQ";
                else
                    op_literal = "BNE";
            end
            7'b0110011: op_literal = "ADD";
            7'b0010011: op_literal = "ADDI";
            7'b1101111: op_literal = "JAL";
        endcase
    end   
    initial $monitor("@%0t => CURRENT INSTRUCTION IS %s", $time, op_literal); 
endmodule