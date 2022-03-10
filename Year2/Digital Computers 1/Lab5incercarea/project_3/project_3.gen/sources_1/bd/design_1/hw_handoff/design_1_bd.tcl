
################################################################
# This is a generated script based on design: design_1
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
# source design_1_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# M1, M2, M3, M4, M5, M6, M7, concatExp, concatMantise, reg16, reg16, reg23, reg25, reg47, reg47, reg56, reg7, reg7, reg7

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
set design_name design_1

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
  set clear_0 [ create_bd_port -dir I clear_0 ]
  set clock_0 [ create_bd_port -dir I -type clk clock_0 ]
  set exp1_0 [ create_bd_port -dir I -from 7 -to 0 exp1_0 ]
  set exp2_0 [ create_bd_port -dir I -from 7 -to 0 exp2_0 ]
  set load_0 [ create_bd_port -dir I load_0 ]
  set mant1_0 [ create_bd_port -dir I -from 23 -to 0 mant1_0 ]
  set mant2_0 [ create_bd_port -dir I -from 23 -to 0 mant2_0 ]
  set op_0 [ create_bd_port -dir I op_0 ]
  set rout_0 [ create_bd_port -dir O -from 23 -to 0 rout_0 ]
  set rout_1 [ create_bd_port -dir O -from 7 -to 0 rout_1 ]

  # Create instance: M1_0, and set properties
  set block_name M1
  set block_cell_name M1_0
  if { [catch {set M1_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $M1_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: M2_0, and set properties
  set block_name M2
  set block_cell_name M2_0
  if { [catch {set M2_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $M2_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: M3_0, and set properties
  set block_name M3
  set block_cell_name M3_0
  if { [catch {set M3_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $M3_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: M4_0, and set properties
  set block_name M4
  set block_cell_name M4_0
  if { [catch {set M4_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $M4_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: M5_0, and set properties
  set block_name M5
  set block_cell_name M5_0
  if { [catch {set M5_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $M5_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: M6_0, and set properties
  set block_name M6
  set block_cell_name M6_0
  if { [catch {set M6_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $M6_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: M7_0, and set properties
  set block_name M7
  set block_cell_name M7_0
  if { [catch {set M7_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $M7_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: concatExp_0, and set properties
  set block_name concatExp
  set block_cell_name concatExp_0
  if { [catch {set concatExp_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $concatExp_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: concatMantise_0, and set properties
  set block_name concatMantise
  set block_cell_name concatMantise_0
  if { [catch {set concatMantise_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $concatMantise_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: reg16_0, and set properties
  set block_name reg16
  set block_cell_name reg16_0
  if { [catch {set reg16_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $reg16_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: reg16_1, and set properties
  set block_name reg16
  set block_cell_name reg16_1
  if { [catch {set reg16_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $reg16_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: reg23_0, and set properties
  set block_name reg23
  set block_cell_name reg23_0
  if { [catch {set reg23_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $reg23_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: reg25_0, and set properties
  set block_name reg25
  set block_cell_name reg25_0
  if { [catch {set reg25_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $reg25_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: reg47_0, and set properties
  set block_name reg47
  set block_cell_name reg47_0
  if { [catch {set reg47_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $reg47_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: reg47_1, and set properties
  set block_name reg47
  set block_cell_name reg47_1
  if { [catch {set reg47_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $reg47_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: reg56_0, and set properties
  set block_name reg56
  set block_cell_name reg56_0
  if { [catch {set reg56_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $reg56_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: reg7_0, and set properties
  set block_name reg7
  set block_cell_name reg7_0
  if { [catch {set reg7_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $reg7_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: reg7_1, and set properties
  set block_name reg7
  set block_cell_name reg7_1
  if { [catch {set reg7_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $reg7_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: reg7_2, and set properties
  set block_name reg7
  set block_cell_name reg7_2
  if { [catch {set reg7_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $reg7_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net M1_0_rez [get_bd_pins M1_0/rez] [get_bd_pins reg16_1/rin]
  connect_bd_net -net M1_0_rez2 [get_bd_pins M1_0/rez2] [get_bd_pins M7_0/val]
  connect_bd_net -net M2_0_rez [get_bd_pins M2_0/rez] [get_bd_pins reg7_0/rin]
  connect_bd_net -net M3_0_rez [get_bd_pins M3_0/rez] [get_bd_pins reg7_2/rin]
  connect_bd_net -net M4_0_mantRez [get_bd_pins M4_0/mantRez] [get_bd_pins reg47_1/rin]
  connect_bd_net -net M5_0_mantRez [get_bd_pins M5_0/mantRez] [get_bd_pins reg25_0/rin]
  connect_bd_net -net M6_0_mfinal [get_bd_pins M6_0/mfinal] [get_bd_pins reg23_0/rin]
  connect_bd_net -net M6_0_val2 [get_bd_pins M3_0/val] [get_bd_pins M6_0/val2]
  connect_bd_net -net M7_0_mantsRez [get_bd_pins M7_0/mantsRez] [get_bd_pins reg56_0/rin]
  connect_bd_net -net clear_0_1 [get_bd_ports clear_0] [get_bd_pins reg16_0/clear] [get_bd_pins reg16_1/clear] [get_bd_pins reg23_0/clear] [get_bd_pins reg25_0/clear] [get_bd_pins reg47_0/clear] [get_bd_pins reg47_1/clear] [get_bd_pins reg56_0/clear] [get_bd_pins reg7_0/clear] [get_bd_pins reg7_1/clear] [get_bd_pins reg7_2/clear]
  connect_bd_net -net clock_0_1 [get_bd_ports clock_0] [get_bd_pins reg16_0/clock] [get_bd_pins reg16_1/clock] [get_bd_pins reg23_0/clock] [get_bd_pins reg25_0/clock] [get_bd_pins reg47_0/clock] [get_bd_pins reg47_1/clock] [get_bd_pins reg56_0/clock] [get_bd_pins reg7_0/clock] [get_bd_pins reg7_1/clock] [get_bd_pins reg7_2/clock]
  connect_bd_net -net concatExp_0_rez [get_bd_pins concatExp_0/rez] [get_bd_pins reg16_0/rin]
  connect_bd_net -net concatMantise_0_rez [get_bd_pins concatMantise_0/rez] [get_bd_pins reg47_0/rin]
  connect_bd_net -net exp1_0_1 [get_bd_ports exp1_0] [get_bd_pins concatExp_0/exp1]
  connect_bd_net -net exp2_0_1 [get_bd_ports exp2_0] [get_bd_pins concatExp_0/exp2]
  connect_bd_net -net load_0_1 [get_bd_ports load_0] [get_bd_pins reg16_0/load] [get_bd_pins reg16_1/load] [get_bd_pins reg23_0/load] [get_bd_pins reg25_0/load] [get_bd_pins reg47_0/load] [get_bd_pins reg47_1/load] [get_bd_pins reg56_0/load] [get_bd_pins reg7_0/load] [get_bd_pins reg7_1/load] [get_bd_pins reg7_2/load]
  connect_bd_net -net mant1_0_1 [get_bd_ports mant1_0] [get_bd_pins concatMantise_0/mant1]
  connect_bd_net -net mant2_0_1 [get_bd_ports mant2_0] [get_bd_pins concatMantise_0/mant2]
  connect_bd_net -net op_0_1 [get_bd_ports op_0] [get_bd_pins M5_0/op]
  connect_bd_net -net reg16_0_rout [get_bd_pins M1_0/exp] [get_bd_pins reg16_0/rout]
  connect_bd_net -net reg16_1_rout [get_bd_pins M2_0/exp] [get_bd_pins reg16_1/rout]
  connect_bd_net -net reg23_0_rout [get_bd_ports rout_0] [get_bd_pins reg23_0/rout]
  connect_bd_net -net reg25_0_rout [get_bd_pins M6_0/mant] [get_bd_pins reg25_0/rout]
  connect_bd_net -net reg47_0_rout [get_bd_pins M7_0/mants] [get_bd_pins reg47_0/rout]
  connect_bd_net -net reg47_1_rout [get_bd_pins M5_0/mant] [get_bd_pins reg47_1/rout]
  connect_bd_net -net reg56_0_rout [get_bd_pins M4_0/mant] [get_bd_pins reg56_0/rout]
  connect_bd_net -net reg7_0_rout [get_bd_pins reg7_0/rout] [get_bd_pins reg7_1/rin]
  connect_bd_net -net reg7_1_rout [get_bd_pins M3_0/exp] [get_bd_pins reg7_1/rout]
  connect_bd_net -net reg7_2_rout [get_bd_ports rout_1] [get_bd_pins reg7_2/rout]

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


