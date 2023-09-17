`timescale 1ns / 1ps

module ALU_tb ();

  // Declare the fixed parameters
  parameter A_width_TOP_tb = 16;
  parameter B_width_TOP_tb = 16;
  parameter ARITH_OUT_width_TOP_tb = 16;
  parameter LOGIC_OUT_width_TOP_tb = 16;
  parameter CMP_OUT_width_TOP_tb = 16;
  parameter SHIFT_OUT_width_TOP_tb = 16;


  // Declare the input/control signals for the DUT 
  reg [A_width_TOP_tb-1:0] A_IN_TOP_tb;
  reg [B_width_TOP_tb-1:0] B_IN_TOP_tb;
  reg [3:0] ALU_FUN_TOP_tb;

  // Declare the general signals for the DUT  
  reg CLK_TOP_tb;
  reg RST_TOP_tb;

  // Declare output flags from the DUT
  wire ARITH_Flag_TOP_tb;
  wire LOGIC_Flag_TOP_tb;
  wire CMP_Flag_TOP_tb;
  wire SHIFT_Flag_TOP_tb;

  // Declare the output buses from the DUT
  wire [ARITH_OUT_width_TOP_tb-1:0] ARITH_OUT_TOP_tb;
  wire [LOGIC_OUT_width_TOP_tb-1:0] LOGIC_OUT_TOP_tb;
  wire [CMP_OUT_width_TOP_tb-1:0] CMP_OUT_TOP_tb;
  wire [SHIFT_OUT_width_TOP_tb-1:0] SHIFT_OUT_TOP_tb;

  wire Carry_out_TOP_tb;


  // Instantiate the DUT
  ALU_TOP #(
      .A_width_TOP(A_width_TOP_tb),
      .B_width_TOP(B_width_TOP_tb),
      .ARITH_OUT_width_TOP(ARITH_OUT_width_TOP_tb),
      .LOGIC_OUT_width_TOP(LOGIC_OUT_width_TOP_tb),
      .CMP_OUT_width_TOP(CMP_OUT_width_TOP_tb),
      .SHIFT_OUT_width_TOP(SHIFT_OUT_width_TOP_tb)
  ) DUT (
      .A_IN_TOP(A_IN_TOP_tb),
      .B_IN_TOP(B_IN_TOP_tb),
      .ALU_FUN_TOP(ALU_FUN_TOP_tb),
      .CLK_TOP(CLK_TOP_tb),
      .RST_TOP(RST_TOP_tb),
      .ARITH_Flag_TOP(ARITH_Flag_TOP_tb),
      .LOGIC_Flag_TOP(LOGIC_Flag_TOP_tb),
      .CMP_Flag_TOP(CMP_Flag_TOP_tb),
      .SHIFT_Flag_TOP(SHIFT_Flag_TOP_tb),
      .ARITH_OUT_TOP(ARITH_OUT_TOP_tb),
      .Carry_out_TOP(Carry_out_TOP_tb),
      .LOGIC_OUT_TOP(LOGIC_OUT_TOP_tb),
      .CMP_OUT_TOP(CMP_OUT_TOP_tb),
      .SHIFT_OUT_TOP(SHIFT_OUT_TOP_tb)
  );

  // Declare the clock signal
  always begin 
    #4 CLK_TOP_tb = 1;
    #6 CLK_TOP_tb = 0;
  end 
  
  initial begin
    #210 $stop;
  end


  initial begin
    $dumpfile("ALU.vcd");
    $dumpvars;
    $monitor(
        "AT time %0t , A_output = %h ,Carry_out = %h ,L_output = %h ,C_output = %h ,S_output = %h , A_flag = %1b , L_flag = %1b , C_flag = %1b , S_flag = %1b",
        $time, ARITH_OUT_TOP_tb, Carry_out_TOP_tb, LOGIC_OUT_TOP_tb, CMP_OUT_TOP_tb,
        SHIFT_OUT_TOP_tb, ARITH_Flag_TOP_tb, LOGIC_Flag_TOP_tb, CMP_Flag_TOP_tb, SHIFT_Flag_TOP_tb);
    CLK_TOP_tb = 0;
    RST_TOP_tb = 1;
  end

  initial begin
    #10;
    A_IN_TOP_tb = 16'b0000_0000_0001_1000;  //24
    B_IN_TOP_tb = 16'b0000_0000_0000_0100;  // 4
    RST_TOP_tb = 0;
    
    #10 RST_TOP_tb = 1;
    
    #10 ALU_FUN_TOP_tb = 4'h0;


    #10 ALU_FUN_TOP_tb = 4'h1;


    #10 ALU_FUN_TOP_tb = 4'h2;


    #10 ALU_FUN_TOP_tb = 4'h3;


    #10 ALU_FUN_TOP_tb = 4'h4;


    #10 ALU_FUN_TOP_tb = 4'h5;


    #10 ALU_FUN_TOP_tb = 4'h6;


    #10 ALU_FUN_TOP_tb = 4'h7;


    #10 RST_TOP_tb = 0;

    #10 ALU_FUN_TOP_tb = 4'h8;

    #10 ALU_FUN_TOP_tb = 4'h9;



    #10 RST_TOP_tb = 1;

    #10 ALU_FUN_TOP_tb = 4'h8;


    #10 ALU_FUN_TOP_tb = 4'h9;


    #10 ALU_FUN_TOP_tb = 4'hA;


    #10 ALU_FUN_TOP_tb = 4'hB;


    #10 ALU_FUN_TOP_tb = 4'hC;


    #10 ALU_FUN_TOP_tb = 4'hD;


    #10 ALU_FUN_TOP_tb = 4'hE;


    #10 ALU_FUN_TOP_tb = 4'hF;

 
  end

endmodule
