//Input: opcode (Instr[6:0])
//Output: RegWrite, ImmSrc, ALUSrc, Branch, MemWrite, ResultSrc, ALUOp, Jump
module main_decoder (
    opcode, RegWrite, ImmSrc, ALUSrc, Branch, MemWrite, ResultSrc, ALUOp ,Jump  
);
    input [6:0] opcode;
    output wire RegWrite, ALUSrc, Branch, MemWrite, ResultSrc, Jump;
    output wire [1:0] ImmSrc, ALUOp;
    /////////////////////////////////////////////////////////////
    reg [9:0] controls;
    /////////////////////////////////////////////////////////////
    assign {RegWrite, ImmSrc, ALUSrc, Branch, MemWrite, ResultSrc, ALUOp, Jump} = controls;
    always @(opcode) begin
        case (opcode)
            7'b0000011: controls = 10'b1_00_1_0_0_1_00_0;  //LW
            7'b0100011: controls = 10'b0_01_1_0_1_0_00_0;  //SW
            7'b1100011: controls = 10'b0_10_0_1_0_0_01_0;  //BEQ & BNE
            7'b0110011: controls = 10'b1_00_0_0_0_0_10_0;  //R-Type
            7'b0010011: controls = 10'b1_00_1_0_0_0_10_0;  //ADDI & ORI & ANDI
            7'b1101111: controls = 10'b1_11_0_0_0_0_00_1;  //JAL
            7'b1100111: controls = 10'b1_00_1_0_0_0_00_1;  //JALR
            default: controls = 10'bxxxxx_xxxxx; 
        endcase 
    end   
endmodule