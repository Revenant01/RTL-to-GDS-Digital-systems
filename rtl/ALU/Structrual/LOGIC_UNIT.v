module LOGIC_UNIT #(
    parameter A_width = 16,
    parameter B_width = 16,
    parameter LOGIC_OUT_width = 16
) (
    input wire [A_width- 1:0] A_IN_LOGIC,
    input wire [B_width- 1:0] B_IN_LOGIC,
    input wire CLK_LOGIC,
    input wire RST_LOGIC,
    input wire [1:0] ALU_FUN_LOGIC,
    input wire LOGIC_EN,
    output reg LOGIC_FLAG,
    output reg [LOGIC_OUT_width- 1:0] LOGIC_OUT
);

  localparam LOGIC_AND = 2'b00;
  localparam LOGIC_OR = 2'b01;
  localparam LOGIC_NAND = 2'b10;
  localparam LOGIC_NOR = 2'b11;

  always @(posedge CLK_LOGIC or negedge RST_LOGIC) begin
    if (!RST_LOGIC) begin
      LOGIC_OUT  <= 0;
      LOGIC_FLAG <= 0;
    end else begin
      if (LOGIC_EN) begin
        LOGIC_FLAG <= 1;
        case (ALU_FUN_LOGIC)
          LOGIC_AND:  LOGIC_OUT = A_IN_LOGIC & B_IN_LOGIC;
          LOGIC_OR:   LOGIC_OUT = A_IN_LOGIC | B_IN_LOGIC;
          LOGIC_NAND: LOGIC_OUT = ~(A_IN_LOGIC & B_IN_LOGIC);
          LOGIC_NOR:  LOGIC_OUT = ~(A_IN_LOGIC & B_IN_LOGIC);
        endcase
      end else begin
        LOGIC_OUT <= 0;
        LOGIC_FLAG <= 0;
      end

    end


  end

endmodule

