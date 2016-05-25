proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7z020clg484-1
  set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.cache/wt [current_project]
  set_property parent.project_path /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.xpr [current_project]
  set_property ip_repo_paths {
  /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.cache/ip
  /home/harsha/work/Zynq/workspace/ip-repo/Volume_Pregain
  /home/harsha/work/Zynq/workspace/ip-repo/SoC_Design/IPs/Audio_Mixer
  /home/harsha/work/Zynq/workspace/ip_repo/axi_to_audio_interface_1.0
  /home/harsha/work/Zynq/workspace/ip-repo/ip_repo_vivado
  /home/harsha/work/Zynq/workspace/ip_repo/audio_to_axi_interface_1.0
  /home/harsha/work/Zynq/workspace/ip-repo/zedboard_audio
} [current_project]
  set_property ip_output_repo /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.cache/ip [current_project]
  add_files -quiet /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.runs/synth_1/Audio_Mixer_Design_wrapper.dcp
  read_xdc -ref Audio_Mixer_Design_processing_system7_0_0 -cells inst /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.srcs/sources_1/bd/Audio_Mixer_Design/ip/Audio_Mixer_Design_processing_system7_0_0/Audio_Mixer_Design_processing_system7_0_0.xdc
  set_property processing_order EARLY [get_files /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.srcs/sources_1/bd/Audio_Mixer_Design/ip/Audio_Mixer_Design_processing_system7_0_0/Audio_Mixer_Design_processing_system7_0_0.xdc]
  read_xdc -prop_thru_buffers -ref Audio_Mixer_Design_rst_processing_system7_0_100M_0 /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.srcs/sources_1/bd/Audio_Mixer_Design/ip/Audio_Mixer_Design_rst_processing_system7_0_100M_0/Audio_Mixer_Design_rst_processing_system7_0_100M_0_board.xdc
  set_property processing_order EARLY [get_files /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.srcs/sources_1/bd/Audio_Mixer_Design/ip/Audio_Mixer_Design_rst_processing_system7_0_100M_0/Audio_Mixer_Design_rst_processing_system7_0_100M_0_board.xdc]
  read_xdc -ref Audio_Mixer_Design_rst_processing_system7_0_100M_0 /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.srcs/sources_1/bd/Audio_Mixer_Design/ip/Audio_Mixer_Design_rst_processing_system7_0_100M_0/Audio_Mixer_Design_rst_processing_system7_0_100M_0.xdc
  set_property processing_order EARLY [get_files /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.srcs/sources_1/bd/Audio_Mixer_Design/ip/Audio_Mixer_Design_rst_processing_system7_0_100M_0/Audio_Mixer_Design_rst_processing_system7_0_100M_0.xdc]
  read_xdc /home/harsha/work/Zynq/workspace/Audio_Mixer_1.1/Audio_Mixer_1.1.srcs/constrs_1/imports/constraints/zed_audio.xdc
  link_design -top Audio_Mixer_Design_wrapper -part xc7z020clg484-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force Audio_Mixer_Design_wrapper_opt.dcp
  report_drc -file Audio_Mixer_Design_wrapper_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file Audio_Mixer_Design_wrapper.hwdef}
  place_design 
  write_checkpoint -force Audio_Mixer_Design_wrapper_placed.dcp
  report_io -file Audio_Mixer_Design_wrapper_io_placed.rpt
  report_utilization -file Audio_Mixer_Design_wrapper_utilization_placed.rpt -pb Audio_Mixer_Design_wrapper_utilization_placed.pb
  report_control_sets -verbose -file Audio_Mixer_Design_wrapper_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force Audio_Mixer_Design_wrapper_routed.dcp
  report_drc -file Audio_Mixer_Design_wrapper_drc_routed.rpt -pb Audio_Mixer_Design_wrapper_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file Audio_Mixer_Design_wrapper_timing_summary_routed.rpt -rpx Audio_Mixer_Design_wrapper_timing_summary_routed.rpx
  report_power -file Audio_Mixer_Design_wrapper_power_routed.rpt -pb Audio_Mixer_Design_wrapper_power_summary_routed.pb
  report_route_status -file Audio_Mixer_Design_wrapper_route_status.rpt -pb Audio_Mixer_Design_wrapper_route_status.pb
  report_clock_utilization -file Audio_Mixer_Design_wrapper_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force Audio_Mixer_Design_wrapper.mmi }
  write_bitstream -force Audio_Mixer_Design_wrapper.bit 
  catch { write_sysdef -hwdef Audio_Mixer_Design_wrapper.hwdef -bitfile Audio_Mixer_Design_wrapper.bit -meminfo Audio_Mixer_Design_wrapper.mmi -file Audio_Mixer_Design_wrapper.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

