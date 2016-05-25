
################################################################
# This is a generated script based on design: Audio_Mixer_Design
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source Audio_Mixer_Design_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z020clg484-1
#    set_property BOARD_PART em.avnet.com:zed:part0:1.3 [current_project]

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name Audio_Mixer_Design

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Create ports
  set AC_ADR0 [ create_bd_port -dir O AC_ADR0 ]
  set AC_ADR1 [ create_bd_port -dir O AC_ADR1 ]
  set AC_GPIO0 [ create_bd_port -dir O AC_GPIO0 ]
  set AC_GPIO1 [ create_bd_port -dir I AC_GPIO1 ]
  set AC_GPIO2 [ create_bd_port -dir I AC_GPIO2 ]
  set AC_GPIO3 [ create_bd_port -dir I AC_GPIO3 ]
  set AC_MCLK [ create_bd_port -dir O AC_MCLK ]
  set AC_SCK [ create_bd_port -dir O AC_SCK ]
  set AC_SDA [ create_bd_port -dir IO AC_SDA ]

  # Create instance: FILTER_IIR_0, and set properties
  set FILTER_IIR_0 [ create_bd_cell -type ip -vlnv tsotnep:userLibrary:FILTER_IIR:1.0 FILTER_IIR_0 ]

  # Create instance: FILTER_IIR_1, and set properties
  set FILTER_IIR_1 [ create_bd_cell -type ip -vlnv tsotnep:userLibrary:FILTER_IIR:1.0 FILTER_IIR_1 ]

  # Create instance: Volume_Pregain_0, and set properties
  set Volume_Pregain_0 [ create_bd_cell -type ip -vlnv tsotnep:userLibrary:Volume_Pregain:1.0 Volume_Pregain_0 ]

  # Create instance: Volume_Pregain_1, and set properties
  set Volume_Pregain_1 [ create_bd_cell -type ip -vlnv tsotnep:userLibrary:Volume_Pregain:1.0 Volume_Pregain_1 ]

  # Create instance: audio_to_axi_interface_0, and set properties
  set audio_to_axi_interface_0 [ create_bd_cell -type ip -vlnv user.org:user:audio_to_axi_interface:1.0 audio_to_axi_interface_0 ]

  # Create instance: axi_to_audio_interface_0, and set properties
  set axi_to_audio_interface_0 [ create_bd_cell -type ip -vlnv user.org:user:axi_to_audio_interface:1.0 axi_to_audio_interface_0 ]

  # Create instance: axi_to_audio_interface_1, and set properties
  set axi_to_audio_interface_1 [ create_bd_cell -type ip -vlnv user.org:user:axi_to_audio_interface:1.0 axi_to_audio_interface_1 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_IRQ_F2P_INTR {1} \
CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.preset {ZedBoard} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {7} \
 ] $processing_system7_0_axi_periph

  # Create instance: rst_processing_system7_0_100M, and set properties
  set rst_processing_system7_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_100M ]

  # Create instance: top_level_0, and set properties
  set top_level_0 [ create_bd_cell -type ip -vlnv user.org:user:top_level:1.0 top_level_0 ]

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {5} \
 ] $xlconcat_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create instance: zed_audio_0, and set properties
  set zed_audio_0 [ create_bd_cell -type ip -vlnv user.org:user:zed_audio:1.0 zed_audio_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins audio_to_axi_interface_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins axi_to_audio_interface_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins FILTER_IIR_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins FILTER_IIR_1/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M04_AXI [get_bd_intf_pins Volume_Pregain_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M05_AXI [get_bd_intf_pins Volume_Pregain_1/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M06_AXI [get_bd_intf_pins axi_to_audio_interface_1/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M06_AXI]

  # Create port connections
  connect_bd_net -net AC_GPIO1_1 [get_bd_ports AC_GPIO1] [get_bd_pins zed_audio_0/AC_GPIO1]
  connect_bd_net -net AC_GPIO2_1 [get_bd_ports AC_GPIO2] [get_bd_pins zed_audio_0/AC_GPIO2]
  connect_bd_net -net AC_GPIO3_1 [get_bd_ports AC_GPIO3] [get_bd_pins zed_audio_0/AC_GPIO3]
  connect_bd_net -net FILTER_IIR_0_AUDIO_OUT_L [get_bd_pins FILTER_IIR_0/AUDIO_OUT_L] [get_bd_pins top_level_0/audio_channel_a_left_in]
  connect_bd_net -net FILTER_IIR_0_AUDIO_OUT_R [get_bd_pins FILTER_IIR_0/AUDIO_OUT_R] [get_bd_pins top_level_0/audio_channel_a_right_in]
  connect_bd_net -net FILTER_IIR_0_FILTER_DONE [get_bd_pins FILTER_IIR_0/FILTER_DONE] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net FILTER_IIR_1_AUDIO_OUT_L [get_bd_pins FILTER_IIR_1/AUDIO_OUT_L] [get_bd_pins top_level_0/audio_channel_b_right_in]
  connect_bd_net -net FILTER_IIR_1_AUDIO_OUT_R [get_bd_pins FILTER_IIR_1/AUDIO_OUT_R] [get_bd_pins top_level_0/audio_channel_b_left_in]
  connect_bd_net -net FILTER_IIR_1_FILTER_DONE [get_bd_pins FILTER_IIR_1/FILTER_DONE] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net Net [get_bd_ports AC_SDA] [get_bd_pins zed_audio_0/AC_SDA]
  connect_bd_net -net Volume_Pregain_0_OUT_RDY [get_bd_pins FILTER_IIR_0/SAMPLE_TRIG] [get_bd_pins Volume_Pregain_0/OUT_RDY]
  connect_bd_net -net Volume_Pregain_0_OUT_VOLCTRL_L [get_bd_pins FILTER_IIR_0/AUDIO_IN_L] [get_bd_pins Volume_Pregain_0/OUT_VOLCTRL_L]
  connect_bd_net -net Volume_Pregain_0_OUT_VOLCTRL_R [get_bd_pins FILTER_IIR_0/AUDIO_IN_R] [get_bd_pins Volume_Pregain_0/OUT_VOLCTRL_R]
  connect_bd_net -net Volume_Pregain_1_OUT_RDY [get_bd_pins FILTER_IIR_1/SAMPLE_TRIG] [get_bd_pins Volume_Pregain_1/OUT_RDY]
  connect_bd_net -net Volume_Pregain_1_OUT_VOLCTRL_L [get_bd_pins FILTER_IIR_1/AUDIO_IN_L] [get_bd_pins Volume_Pregain_1/OUT_VOLCTRL_L]
  connect_bd_net -net Volume_Pregain_1_OUT_VOLCTRL_R [get_bd_pins FILTER_IIR_1/AUDIO_IN_R] [get_bd_pins Volume_Pregain_1/OUT_VOLCTRL_R]
  connect_bd_net -net audio_to_axi_interface_0_irq_out [get_bd_pins audio_to_axi_interface_0/irq_out] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net axi_to_audio_interface_0_hphone_l_out [get_bd_pins Volume_Pregain_0/IN_SIG_L] [get_bd_pins axi_to_audio_interface_0/hphone_l_out]
  connect_bd_net -net axi_to_audio_interface_0_hphone_r_out [get_bd_pins Volume_Pregain_0/IN_SIG_R] [get_bd_pins axi_to_audio_interface_0/hphone_r_out]
  connect_bd_net -net axi_to_audio_interface_0_irq_out [get_bd_pins axi_to_audio_interface_0/irq_out] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net axi_to_audio_interface_1_hphone_l_out [get_bd_pins Volume_Pregain_1/IN_SIG_L] [get_bd_pins axi_to_audio_interface_1/hphone_l_out]
  connect_bd_net -net axi_to_audio_interface_1_hphone_r_out [get_bd_pins Volume_Pregain_1/IN_SIG_R] [get_bd_pins axi_to_audio_interface_1/hphone_r_out]
  connect_bd_net -net axi_to_audio_interface_1_irq_out [get_bd_pins axi_to_audio_interface_1/irq_out] [get_bd_pins xlconcat_0/In4]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins FILTER_IIR_0/s00_axi_aclk] [get_bd_pins FILTER_IIR_1/s00_axi_aclk] [get_bd_pins Volume_Pregain_0/s00_axi_aclk] [get_bd_pins Volume_Pregain_1/s00_axi_aclk] [get_bd_pins audio_to_axi_interface_0/s00_axi_aclk] [get_bd_pins axi_to_audio_interface_0/s00_axi_aclk] [get_bd_pins axi_to_audio_interface_1/s00_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/M05_ACLK] [get_bd_pins processing_system7_0_axi_periph/M06_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_100M/slowest_sync_clk] [get_bd_pins zed_audio_0/clk_100]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_100M/ext_reset_in]
  connect_bd_net -net rst_processing_system7_0_100M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_100M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_100M_peripheral_aresetn [get_bd_pins FILTER_IIR_0/s00_axi_aresetn] [get_bd_pins FILTER_IIR_1/s00_axi_aresetn] [get_bd_pins Volume_Pregain_0/s00_axi_aresetn] [get_bd_pins Volume_Pregain_1/s00_axi_aresetn] [get_bd_pins audio_to_axi_interface_0/s00_axi_aresetn] [get_bd_pins axi_to_audio_interface_0/s00_axi_aresetn] [get_bd_pins axi_to_audio_interface_1/s00_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M05_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M06_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn]
  connect_bd_net -net top_level_0_audio_mixed_a_b_left_out [get_bd_pins top_level_0/audio_mixed_a_b_left_out] [get_bd_pins zed_audio_0/hphone_l]
  connect_bd_net -net top_level_0_audio_mixed_a_b_right_out [get_bd_pins top_level_0/audio_mixed_a_b_right_out] [get_bd_pins zed_audio_0/hphone_r]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins processing_system7_0/IRQ_F2P] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins xlconstant_0/dout] [get_bd_pins zed_audio_0/hphone_l_valid] [get_bd_pins zed_audio_0/hphone_r_valid_dummy]
  connect_bd_net -net zed_audio_0_AC_ADR0 [get_bd_ports AC_ADR0] [get_bd_pins zed_audio_0/AC_ADR0]
  connect_bd_net -net zed_audio_0_AC_ADR1 [get_bd_ports AC_ADR1] [get_bd_pins zed_audio_0/AC_ADR1]
  connect_bd_net -net zed_audio_0_AC_GPIO0 [get_bd_ports AC_GPIO0] [get_bd_pins zed_audio_0/AC_GPIO0]
  connect_bd_net -net zed_audio_0_AC_MCLK [get_bd_ports AC_MCLK] [get_bd_pins zed_audio_0/AC_MCLK]
  connect_bd_net -net zed_audio_0_AC_SCK [get_bd_ports AC_SCK] [get_bd_pins zed_audio_0/AC_SCK]
  connect_bd_net -net zed_audio_0_line_in_l [get_bd_pins audio_to_axi_interface_0/line_in_l_in] [get_bd_pins zed_audio_0/line_in_l]
  connect_bd_net -net zed_audio_0_line_in_r [get_bd_pins audio_to_axi_interface_0/line_in_r_in] [get_bd_pins zed_audio_0/line_in_r]
  connect_bd_net -net zed_audio_0_new_sample [get_bd_pins audio_to_axi_interface_0/irq_in] [get_bd_pins zed_audio_0/new_sample]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs FILTER_IIR_0/S00_AXI/S00_AXI_reg] SEG_FILTER_IIR_0_S00_AXI_reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C30000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs FILTER_IIR_1/S00_AXI/S00_AXI_reg] SEG_FILTER_IIR_1_S00_AXI_reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C40000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs Volume_Pregain_0/S00_AXI/S00_AXI_reg] SEG_Volume_Pregain_0_S00_AXI_reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C50000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs Volume_Pregain_1/S00_AXI/S00_AXI_reg] SEG_Volume_Pregain_1_S00_AXI_reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs audio_to_axi_interface_0/S00_AXI/S00_AXI_reg] SEG_audio_to_axi_interface_0_S00_AXI_reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_to_audio_interface_0/S00_AXI/S00_AXI_reg] SEG_axi_to_audio_interface_0_S00_AXI_reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C60000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_to_audio_interface_1/S00_AXI/S00_AXI_reg] SEG_axi_to_audio_interface_1_S00_AXI_reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.8
#  -string -flagsOSRD
preplace port AC_GPIO2 -pg 1 -y 470 -defaultsOSRD
preplace port DDR -pg 1 -y 650 -defaultsOSRD
preplace port AC_MCLK -pg 1 -y 510 -defaultsOSRD
preplace port AC_GPIO3 -pg 1 -y 490 -defaultsOSRD
preplace port AC_ADR0 -pg 1 -y 450 -defaultsOSRD
preplace port AC_ADR1 -pg 1 -y 470 -defaultsOSRD
preplace port AC_SCK -pg 1 -y 540 -defaultsOSRD
preplace port AC_SDA -pg 1 -y 560 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 670 -defaultsOSRD
preplace port AC_GPIO0 -pg 1 -y 490 -defaultsOSRD
preplace port AC_GPIO1 -pg 1 -y 450 -defaultsOSRD
preplace inst axi_to_audio_interface_1 -pg 1 -lvl 1 -y 110 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 4 -y 430 -defaultsOSRD
preplace inst rst_processing_system7_0_100M -pg 1 -lvl 7 -y 330 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 7 -y 600 -defaultsOSRD
preplace inst FILTER_IIR_0 -pg 1 -lvl 3 -y 470 -defaultsOSRD
preplace inst Volume_Pregain_0 -pg 1 -lvl 2 -y 390 -defaultsOSRD
preplace inst FILTER_IIR_1 -pg 1 -lvl 3 -y 130 -defaultsOSRD
preplace inst Volume_Pregain_1 -pg 1 -lvl 2 -y 110 -defaultsOSRD
preplace inst top_level_0 -pg 1 -lvl 4 -y 250 -defaultsOSRD
preplace inst audio_to_axi_interface_0 -pg 1 -lvl 1 -y 600 -defaultsOSRD
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 8 -y 460 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 6 -y 370 -defaultsOSRD
preplace inst axi_to_audio_interface_0 -pg 1 -lvl 1 -y 380 -defaultsOSRD
preplace inst zed_audio_0 -pg 1 -lvl 5 -y 330 -defaultsOSRD
preplace netloc processing_system7_0_DDR 1 6 3 2970 150 NJ 150 NJ
preplace netloc axi_to_audio_interface_1_hphone_r_out 1 1 1 N
preplace netloc top_level_0_audio_mixed_a_b_left_out 1 4 1 2140
preplace netloc zed_audio_0_AC_ADR0 1 5 4 2570 220 NJ 220 NJ 220 NJ
preplace netloc Volume_Pregain_0_OUT_VOLCTRL_R 1 2 1 1050
preplace netloc Volume_Pregain_1_OUT_VOLCTRL_L 1 2 1 1090
preplace netloc FILTER_IIR_1_AUDIO_OUT_L 1 3 1 1580
preplace netloc FILTER_IIR_0_AUDIO_OUT_L 1 3 1 1630
preplace netloc zed_audio_0_line_in_r 1 0 6 170 700 NJ 700 NJ 700 NJ 700 NJ 700 2490
preplace netloc audio_to_axi_interface_0_irq_out 1 1 6 500 570 NJ 570 NJ 560 NJ 560 NJ 560 NJ
preplace netloc AC_GPIO2_1 1 0 5 NJ 20 NJ 20 NJ 20 NJ 20 2150
preplace netloc zed_audio_0_AC_ADR1 1 5 4 2560 210 NJ 210 NJ 210 NJ
preplace netloc processing_system7_0_axi_periph_M03_AXI 1 2 7 1090 30 NJ 30 NJ 30 NJ 30 NJ 30 NJ 30 3850
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 0 9 160 240 NJ 240 NJ 240 NJ 80 NJ 80 NJ 80 NJ 80 NJ 80 3810
preplace netloc axi_to_audio_interface_0_irq_out 1 1 6 480 480 NJ 580 NJ 580 NJ 580 NJ 580 NJ
preplace netloc processing_system7_0_M_AXI_GP0 1 6 2 NJ 240 3370
preplace netloc axi_to_audio_interface_0_hphone_r_out 1 1 1 480
preplace netloc processing_system7_0_axi_periph_M05_AXI 1 1 8 510 290 NJ 290 NJ 110 NJ 110 NJ 110 NJ 110 NJ 110 3830
preplace netloc processing_system7_0_FCLK_RESET0_N 1 6 1 3030
preplace netloc zed_audio_0_AC_MCLK 1 5 4 2520 710 NJ 710 NJ 710 NJ
preplace netloc AC_GPIO1_1 1 0 5 NJ 10 NJ 10 NJ 10 NJ 10 2170
preplace netloc axi_to_audio_interface_0_hphone_l_out 1 1 1 480
preplace netloc zed_audio_0_AC_GPIO0 1 5 4 2550 190 NJ 190 NJ 190 NJ
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 2 7 1100 350 NJ 350 NJ 190 NJ 200 NJ 200 NJ 200 3790
preplace netloc top_level_0_audio_mixed_a_b_right_out 1 4 1 2110
preplace netloc rst_processing_system7_0_100M_peripheral_aresetn 1 0 8 130 220 500 220 1090 370 NJ 370 NJ 520 NJ 520 NJ 510 3390
preplace netloc AC_GPIO3_1 1 0 5 NJ 200 NJ 200 NJ 340 NJ 340 2130
preplace netloc processing_system7_0_axi_periph_M06_AXI 1 0 9 140 300 NJ 300 NJ 300 NJ 140 NJ 140 NJ 140 NJ 130 NJ 130 3820
preplace netloc Volume_Pregain_0_OUT_RDY 1 2 1 1060
preplace netloc Volume_Pregain_1_OUT_VOLCTRL_R 1 2 1 1080
preplace netloc FILTER_IIR_1_AUDIO_OUT_R 1 3 1 1530
preplace netloc FILTER_IIR_0_AUDIO_OUT_R 1 3 1 1640
preplace netloc xlconcat_0_dout 1 5 3 2570 700 NJ 700 3370
preplace netloc xlconstant_0_dout 1 4 1 2170
preplace netloc processing_system7_0_FIXED_IO 1 6 3 2990 180 NJ 180 NJ
preplace netloc Volume_Pregain_0_OUT_VOLCTRL_L 1 2 1 1070
preplace netloc Volume_Pregain_1_OUT_RDY 1 2 1 1050
preplace netloc zed_audio_0_line_in_l 1 0 6 170 250 NJ 250 NJ 250 NJ 160 NJ 160 2490
preplace netloc zed_audio_0_new_sample 1 0 6 180 260 NJ 260 NJ 260 NJ 150 NJ 150 2520
preplace netloc axi_to_audio_interface_1_hphone_l_out 1 1 1 N
preplace netloc FILTER_IIR_1_FILTER_DONE 1 3 4 NJ 130 NJ 130 NJ 130 3000
preplace netloc rst_processing_system7_0_100M_interconnect_aresetn 1 7 1 3370
preplace netloc Net 1 5 4 2510 690 NJ 690 NJ 700 NJ
preplace netloc zed_audio_0_AC_SCK 1 5 4 2530 160 NJ 160 NJ 160 NJ
preplace netloc processing_system7_0_FCLK_CLK0 1 0 8 120 180 490 210 1080 360 NJ 360 2160 470 2550 510 3020 230 3380
preplace netloc FILTER_IIR_0_FILTER_DONE 1 3 4 N 490 NJ 490 NJ 530 NJ
preplace netloc processing_system7_0_axi_periph_M04_AXI 1 1 8 520 280 NJ 280 NJ 100 NJ 100 NJ 100 NJ 100 NJ 100 3840
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 0 9 150 230 NJ 230 NJ 230 NJ 90 NJ 90 NJ 90 NJ 90 NJ 90 3800
preplace netloc axi_to_audio_interface_1_irq_out 1 1 6 480 270 NJ 270 NJ 330 NJ 180 NJ 180 NJ
levelinfo -pg 1 70 330 880 1370 1870 2330 2770 3200 3650 3960 -top 0 -bot 720
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


