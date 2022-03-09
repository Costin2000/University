//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Thu Jun  3 13:19:12 2021
//Host        : catalin-vm running 64-bit Linux Mint 20.1
//Command     : generate_target ceas_figure.bd
//Design      : ceas_figure
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "ceas_figure,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=ceas_figure,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=6,numReposBlks=6,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=6,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "ceas_figure.hwdef" *) 
module ceas_figure
   (BCD0_0,
    BCD0_1,
    BCD1_0,
    BCD1_1,
    clk_out_led_0,
    data_0,
    direction_0,
    load_0,
    pauza_0,
    reset_0);
  output [3:0]BCD0_0;
  output [3:0]BCD0_1;
  output [3:0]BCD1_0;
  output [3:0]BCD1_1;
  input clk_out_led_0;
  input [5:0]data_0;
  input direction_0;
  input load_0;
  input pauza_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_0;

  wire [3:0]bin2bcd_0_BCD0;
  wire [3:0]bin2bcd_0_BCD1;
  wire [3:0]bin2bcd_1_BCD0;
  wire [3:0]bin2bcd_1_BCD1;
  wire clk_out_led_0_1;
  wire [5:0]data_0_1;
  wire direction_0_1;
  wire load_0_1;
  wire numarator_59_0_carry_out;
  wire [5:0]numarator_59_0_valoare_bin;
  wire [5:0]numarator_59_1_valoare_bin;
  wire pAND_0_C;
  wire pOR_0_C;
  wire pauza_0_1;
  wire reset_0_1;

  assign BCD0_0[3:0] = bin2bcd_0_BCD0;
  assign BCD0_1[3:0] = bin2bcd_1_BCD0;
  assign BCD1_0[3:0] = bin2bcd_0_BCD1;
  assign BCD1_1[3:0] = bin2bcd_1_BCD1;
  assign clk_out_led_0_1 = clk_out_led_0;
  assign data_0_1 = data_0[5:0];
  assign direction_0_1 = direction_0;
  assign load_0_1 = load_0;
  assign pauza_0_1 = pauza_0;
  assign reset_0_1 = reset_0;
  ceas_figure_bin2bcd_0_1 bin2bcd_0
       (.BCD0(bin2bcd_0_BCD0),
        .BCD1(bin2bcd_0_BCD1),
        .valoare_bin(numarator_59_0_valoare_bin));
  ceas_figure_bin2bcd_1_1 bin2bcd_1
       (.BCD0(bin2bcd_1_BCD0),
        .BCD1(bin2bcd_1_BCD1),
        .valoare_bin(numarator_59_1_valoare_bin));
  ceas_figure_numarator_59_0_1 numarator_59_0
       (.carry_out(numarator_59_0_carry_out),
        .clk_out_led(clk_out_led_0_1),
        .data(data_0_1),
        .direction(direction_0_1),
        .load(load_0_1),
        .pauza(pauza_0_1),
        .reset(reset_0_1),
        .valoare_bin(numarator_59_0_valoare_bin));
  ceas_figure_numarator_59_1_1 numarator_59_1
       (.clk_out_led(pAND_0_C),
        .data(data_0_1),
        .direction(direction_0_1),
        .load(load_0_1),
        .pauza(pauza_0_1),
        .reset(reset_0_1),
        .valoare_bin(numarator_59_1_valoare_bin));
  ceas_figure_pAND_0_0 pAND_0
       (.A(pOR_0_C),
        .B(clk_out_led_0_1),
        .C(pAND_0_C));
  ceas_figure_pOR_0_0 pOR_0
       (.A(numarator_59_0_carry_out),
        .B(load_0_1),
        .C(pOR_0_C));
endmodule
