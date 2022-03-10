
################################################################
# This is a generated script based on design: Schema
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
# source Schema_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# Automat

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
set design_name Schema

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
  set Aliment1_0 [ create_bd_port -dir O Aliment1_0 ]
  set Aliment2_0 [ create_bd_port -dir O Aliment2_0 ]
  set Lei10_0 [ create_bd_port -dir I Lei10_0 ]
  set Lei5_0 [ create_bd_port -dir I Lei5_0 ]
  set Leu1_0 [ create_bd_port -dir I Leu1_0 ]
  set REST1_0 [ create_bd_port -dir O REST1_0 ]
  set REST2_0 [ create_bd_port -dir O REST2_0 ]
  set REST3_0 [ create_bd_port -dir O REST3_0 ]
  set REST4_0 [ create_bd_port -dir O REST4_0 ]
  set REST5_0 [ create_bd_port -dir O REST5_0 ]
  set Suc1_0 [ create_bd_port -dir O Suc1_0 ]
  set Suc2_0 [ create_bd_port -dir O Suc2_0 ]
  set bautura1_0 [ create_bd_port -dir I bautura1_0 ]
  set bautura2_0 [ create_bd_port -dir I bautura2_0 ]
  set clk_0 [ create_bd_port -dir I -type clk clk_0 ]
  set mancare1_0 [ create_bd_port -dir I mancare1_0 ]
  set mancare2_0 [ create_bd_port -dir I mancare2_0 ]
  set reset_0 [ create_bd_port -dir I -type rst reset_0 ]
  set vreauRest_0 [ create_bd_port -dir I vreauRest_0 ]

  # Create instance: Automat_0, and set properties
  set block_name Automat
  set block_cell_name Automat_0
  if { [catch {set Automat_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Automat_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net Automat_0_Aliment1 [get_bd_ports Aliment1_0] [get_bd_pins Automat_0/Aliment1]
  connect_bd_net -net Automat_0_Aliment2 [get_bd_ports Aliment2_0] [get_bd_pins Automat_0/Aliment2]
  connect_bd_net -net Automat_0_REST1 [get_bd_ports REST1_0] [get_bd_pins Automat_0/REST1]
  connect_bd_net -net Automat_0_REST2 [get_bd_ports REST2_0] [get_bd_pins Automat_0/REST2]
  connect_bd_net -net Automat_0_REST3 [get_bd_ports REST3_0] [get_bd_pins Automat_0/REST3]
  connect_bd_net -net Automat_0_REST4 [get_bd_ports REST4_0] [get_bd_pins Automat_0/REST4]
  connect_bd_net -net Automat_0_REST5 [get_bd_ports REST5_0] [get_bd_pins Automat_0/REST5]
  connect_bd_net -net Automat_0_Suc1 [get_bd_ports Suc1_0] [get_bd_pins Automat_0/Suc1]
  connect_bd_net -net Automat_0_Suc2 [get_bd_ports Suc2_0] [get_bd_pins Automat_0/Suc2]
  connect_bd_net -net Lei10_0_1 [get_bd_ports Lei10_0] [get_bd_pins Automat_0/Lei10]
  connect_bd_net -net Lei5_0_1 [get_bd_ports Lei5_0] [get_bd_pins Automat_0/Lei5]
  connect_bd_net -net Leu1_0_1 [get_bd_ports Leu1_0] [get_bd_pins Automat_0/Leu1]
  connect_bd_net -net bautura1_0_1 [get_bd_ports bautura1_0] [get_bd_pins Automat_0/bautura1]
  connect_bd_net -net bautura2_0_1 [get_bd_ports bautura2_0] [get_bd_pins Automat_0/bautura2]
  connect_bd_net -net clk_0_1 [get_bd_ports clk_0] [get_bd_pins Automat_0/clk]
  connect_bd_net -net mancare1_0_1 [get_bd_ports mancare1_0] [get_bd_pins Automat_0/mancare1]
  connect_bd_net -net mancare2_0_1 [get_bd_ports mancare2_0] [get_bd_pins Automat_0/mancare2]
  connect_bd_net -net reset_0_1 [get_bd_ports reset_0] [get_bd_pins Automat_0/reset]
  connect_bd_net -net vreauRest_0_1 [get_bd_ports vreauRest_0] [get_bd_pins Automat_0/vreauRest]

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


