
################################################################
# This is a generated script based on design: ceas_figure
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source ceas_figure_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# bin2bcd, bin2bcd, numarator_59, numarator_59, pAND, pOR

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a100tcsg324-1
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name ceas_figure

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

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set BCD0_0 [ create_bd_port -dir O -from 3 -to 0 BCD0_0 ]
  set BCD0_1 [ create_bd_port -dir O -from 3 -to 0 BCD0_1 ]
  set BCD1_0 [ create_bd_port -dir O -from 3 -to 0 BCD1_0 ]
  set BCD1_1 [ create_bd_port -dir O -from 3 -to 0 BCD1_1 ]
  set clk_out_led_0 [ create_bd_port -dir I clk_out_led_0 ]
  set data_0 [ create_bd_port -dir I -from 5 -to 0 data_0 ]
  set direction_0 [ create_bd_port -dir I direction_0 ]
  set load_0 [ create_bd_port -dir I load_0 ]
  set pauza_0 [ create_bd_port -dir I pauza_0 ]
  set reset_0 [ create_bd_port -dir I -type rst reset_0 ]

  # Create instance: bin2bcd_0, and set properties
  set block_name bin2bcd
  set block_cell_name bin2bcd_0
  if { [catch {set bin2bcd_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $bin2bcd_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: bin2bcd_1, and set properties
  set block_name bin2bcd
  set block_cell_name bin2bcd_1
  if { [catch {set bin2bcd_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $bin2bcd_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: numarator_59_0, and set properties
  set block_name numarator_59
  set block_cell_name numarator_59_0
  if { [catch {set numarator_59_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $numarator_59_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: numarator_59_1, and set properties
  set block_name numarator_59
  set block_cell_name numarator_59_1
  if { [catch {set numarator_59_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $numarator_59_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pAND_0, and set properties
  set block_name pAND
  set block_cell_name pAND_0
  if { [catch {set pAND_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pAND_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pOR_0, and set properties
  set block_name pOR
  set block_cell_name pOR_0
  if { [catch {set pOR_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pOR_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net bin2bcd_0_BCD0 [get_bd_ports BCD0_0] [get_bd_pins bin2bcd_0/BCD0]
  connect_bd_net -net bin2bcd_0_BCD1 [get_bd_ports BCD1_0] [get_bd_pins bin2bcd_0/BCD1]
  connect_bd_net -net bin2bcd_1_BCD0 [get_bd_ports BCD0_1] [get_bd_pins bin2bcd_1/BCD0]
  connect_bd_net -net bin2bcd_1_BCD1 [get_bd_ports BCD1_1] [get_bd_pins bin2bcd_1/BCD1]
  connect_bd_net -net clk_out_led_0_1 [get_bd_ports clk_out_led_0] [get_bd_pins numarator_59_0/clk_out_led] [get_bd_pins pAND_0/B]
  connect_bd_net -net data_0_1 [get_bd_ports data_0] [get_bd_pins numarator_59_0/data] [get_bd_pins numarator_59_1/data]
  connect_bd_net -net direction_0_1 [get_bd_ports direction_0] [get_bd_pins numarator_59_0/direction] [get_bd_pins numarator_59_1/direction]
  connect_bd_net -net load_0_1 [get_bd_ports load_0] [get_bd_pins numarator_59_0/load] [get_bd_pins numarator_59_1/load] [get_bd_pins pOR_0/B]
  connect_bd_net -net numarator_59_0_carry_out [get_bd_pins numarator_59_0/carry_out] [get_bd_pins pOR_0/A]
  connect_bd_net -net numarator_59_0_valoare_bin [get_bd_pins bin2bcd_0/valoare_bin] [get_bd_pins numarator_59_0/valoare_bin]
  connect_bd_net -net numarator_59_1_valoare_bin [get_bd_pins bin2bcd_1/valoare_bin] [get_bd_pins numarator_59_1/valoare_bin]
  connect_bd_net -net pAND_0_C [get_bd_pins numarator_59_1/clk_out_led] [get_bd_pins pAND_0/C]
  connect_bd_net -net pOR_0_C [get_bd_pins pAND_0/A] [get_bd_pins pOR_0/C]
  connect_bd_net -net pauza_0_1 [get_bd_ports pauza_0] [get_bd_pins numarator_59_0/pauza] [get_bd_pins numarator_59_1/pauza]
  connect_bd_net -net reset_0_1 [get_bd_ports reset_0] [get_bd_pins numarator_59_0/reset] [get_bd_pins numarator_59_1/reset]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


