module DECODER_UNIT (
    input wire [1:0] ALU_FUN_DEC,
    input wire CLK_DEC,
    input wire RST_DEC,
    output reg ARITH_EN_DEC,
    LOGIC_EN_DEC,
    CMP_EN_DEC,
    SHIFT_EN_DEC
);

  localparam ARITH_PROCESS = 2'b00;
  localparam LOGIC_PROCESS = 2'b01;
  localparam CMP_PROCESS = 2'b10;
  localparam SHIFT_PROCESS = 2'b11;

  always @(*) begin
    if (!RST_DEC) begin
      ARITH_EN_DEC = 1'b0;
      LOGIC_EN_DEC = 1'b0;
      CMP_EN_DEC   = 1'b0;
      SHIFT_EN_DEC = 1'b0;
    end else begin
      case (ALU_FUN_DEC)
        ARITH_PROCESS:begin 
        ARITH_EN_DEC = 1'b1;
        LOGIC_EN_DEC = 1'b0;
      CMP_EN_DEC   = 1'b0;
      SHIFT_EN_DEC = 1'b0;
        end
        LOGIC_PROCESS: begin
        LOGIC_EN_DEC = 1'b1;
        CMP_EN_DEC   = 1'b0;
      SHIFT_EN_DEC = 1'b0;
      ARITH_EN_DEC = 1'b0;
        end
        CMP_PROCESS:  begin
         ARITH_EN_DEC = 1'b0;
      LOGIC_EN_DEC = 1'b0;
         CMP_EN_DEC = 1'b1;
         SHIFT_EN_DEC = 1'b0;
         end
        SHIFT_PROCESS: begin
        ARITH_EN_DEC = 1'b0;
      LOGIC_EN_DEC = 1'b0;
      CMP_EN_DEC   = 1'b0;
        SHIFT_EN_DEC = 1'b1;
        end
      endcase
    end

  end

endmodule

