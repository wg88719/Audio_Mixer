// (c) Copyright 1995-2016 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.

// IP VLNV: user.org:user:zed_audio:1.0
// IP Revision: 1

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
Audio_Mixer_Design_zed_audio_0_0 your_instance_name (
  .clk_100(clk_100),                            // input wire clk_100
  .AC_ADR0(AC_ADR0),                            // output wire AC_ADR0
  .AC_ADR1(AC_ADR1),                            // output wire AC_ADR1
  .AC_GPIO0(AC_GPIO0),                          // output wire AC_GPIO0
  .AC_GPIO1(AC_GPIO1),                          // input wire AC_GPIO1
  .AC_GPIO2(AC_GPIO2),                          // input wire AC_GPIO2
  .AC_GPIO3(AC_GPIO3),                          // input wire AC_GPIO3
  .hphone_l(hphone_l),                          // input wire [23 : 0] hphone_l
  .hphone_l_valid(hphone_l_valid),              // input wire hphone_l_valid
  .hphone_r(hphone_r),                          // input wire [23 : 0] hphone_r
  .hphone_r_valid_dummy(hphone_r_valid_dummy),  // input wire hphone_r_valid_dummy
  .line_in_l(line_in_l),                        // output wire [23 : 0] line_in_l
  .line_in_r(line_in_r),                        // output wire [23 : 0] line_in_r
  .new_sample(new_sample),                      // output wire new_sample
  .sample_clk_48k(sample_clk_48k),              // output wire sample_clk_48k
  .AC_MCLK(AC_MCLK),                            // output wire AC_MCLK
  .AC_SCK(AC_SCK),                              // output wire AC_SCK
  .AC_SDA(AC_SDA)                              // inout wire AC_SDA
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

