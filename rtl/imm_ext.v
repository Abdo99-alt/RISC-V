//This models the unit necessary to extend the immediate field//
////////////////////////////////////////////////////////////////
module imm_ext (
    Instr, ImmSrc, ImmExt 
);
    input [31:7] Instr;
    input [1:0] ImmSrc;
    output reg [31:0] ImmExt;
    //////////////////////////////////////////////////////////
    always @(Instr or ImmSrc) begin
        ImmExt[31:12] = {20{Instr[31]}};
        case (ImmSrc)
            2'b00: ImmExt[11:0] = {Instr[31:20]};
            2'b01: ImmExt[11:0] = {Instr[31:25], Instr[11:7]};
            2'b10: ImmExt[11:0] = {Instr[7], Instr[30:25], Instr[11:8], 1'b0};   
            2'b11: ImmExt[19:0] = {Instr[19:12], Instr[20], Instr[30:21], 1'b0};
            default: ImmExt = 32'h0000;
        endcase    
    end
endmodule