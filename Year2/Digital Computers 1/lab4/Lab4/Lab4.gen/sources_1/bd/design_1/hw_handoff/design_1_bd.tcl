
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
# GUAT, UAT, UAT, UAT, UAT, defalcare_UAT, defalcare_UAT, defalcare_UAT, defalcare_UAT, modul_concat_sum, modul_concat_sum, modul_concat_sum, modul_concat_sum, modul_concat_uat, modul_defalcare, modul_defalcare, modul_input, modul_refacere_suma, splitter_GUAT, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit, sumator_complet_1bit

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
  set GUAT_G_0 [ create_bd_port -dir O GUAT_G_0 ]
  set GUAT_P_0 [ create_bd_port -dir O GUAT_P_0 ]
  set a_0 [ create_bd_port -dir I -from 15 -to 0 a_0 ]
  set b_0 [ create_bd_port -dir I -from 15 -to 0 b_0 ]
  set c_in_0 [ create_bd_port -dir I c_in_0 ]
  set carry4_0 [ create_bd_port -dir O carry4_0 ]
  set sum_0 [ create_bd_port -dir O -from 15 -to 0 sum_0 ]

  # Create instance: GUAT_0, and set properties
  set block_name GUAT
  set block_cell_name GUAT_0
  if { [catch {set GUAT_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $GUAT_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: UAT_0, and set properties
  set block_name UAT
  set block_cell_name UAT_0
  if { [catch {set UAT_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $UAT_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: UAT_1, and set properties
  set block_name UAT
  set block_cell_name UAT_1
  if { [catch {set UAT_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $UAT_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: UAT_2, and set properties
  set block_name UAT
  set block_cell_name UAT_2
  if { [catch {set UAT_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $UAT_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: UAT_3, and set properties
  set block_name UAT
  set block_cell_name UAT_3
  if { [catch {set UAT_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $UAT_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: defalcare_UAT_0, and set properties
  set block_name defalcare_UAT
  set block_cell_name defalcare_UAT_0
  if { [catch {set defalcare_UAT_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $defalcare_UAT_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: defalcare_UAT_1, and set properties
  set block_name defalcare_UAT
  set block_cell_name defalcare_UAT_1
  if { [catch {set defalcare_UAT_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $defalcare_UAT_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: defalcare_UAT_2, and set properties
  set block_name defalcare_UAT
  set block_cell_name defalcare_UAT_2
  if { [catch {set defalcare_UAT_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $defalcare_UAT_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: defalcare_UAT_3, and set properties
  set block_name defalcare_UAT
  set block_cell_name defalcare_UAT_3
  if { [catch {set defalcare_UAT_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $defalcare_UAT_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: modul_concat_sum_0, and set properties
  set block_name modul_concat_sum
  set block_cell_name modul_concat_sum_0
  if { [catch {set modul_concat_sum_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $modul_concat_sum_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: modul_concat_sum_1, and set properties
  set block_name modul_concat_sum
  set block_cell_name modul_concat_sum_1
  if { [catch {set modul_concat_sum_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $modul_concat_sum_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: modul_concat_sum_2, and set properties
  set block_name modul_concat_sum
  set block_cell_name modul_concat_sum_2
  if { [catch {set modul_concat_sum_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $modul_concat_sum_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: modul_concat_sum_3, and set properties
  set block_name modul_concat_sum
  set block_cell_name modul_concat_sum_3
  if { [catch {set modul_concat_sum_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $modul_concat_sum_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: modul_concat_uat_0, and set properties
  set block_name modul_concat_uat
  set block_cell_name modul_concat_uat_0
  if { [catch {set modul_concat_uat_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $modul_concat_uat_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: modul_defalcare_0, and set properties
  set block_name modul_defalcare
  set block_cell_name modul_defalcare_0
  if { [catch {set modul_defalcare_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $modul_defalcare_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: modul_defalcare_1, and set properties
  set block_name modul_defalcare
  set block_cell_name modul_defalcare_1
  if { [catch {set modul_defalcare_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $modul_defalcare_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: modul_input_0, and set properties
  set block_name modul_input
  set block_cell_name modul_input_0
  if { [catch {set modul_input_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $modul_input_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: modul_refacere_suma_0, and set properties
  set block_name modul_refacere_suma
  set block_cell_name modul_refacere_suma_0
  if { [catch {set modul_refacere_suma_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $modul_refacere_suma_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: splitter_GUAT_0, and set properties
  set block_name splitter_GUAT
  set block_cell_name splitter_GUAT_0
  if { [catch {set splitter_GUAT_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $splitter_GUAT_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_0, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_0
  if { [catch {set sumator_complet_1bit_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_1, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_1
  if { [catch {set sumator_complet_1bit_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_2, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_2
  if { [catch {set sumator_complet_1bit_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_3, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_3
  if { [catch {set sumator_complet_1bit_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_4, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_4
  if { [catch {set sumator_complet_1bit_4 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_4 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_5, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_5
  if { [catch {set sumator_complet_1bit_5 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_5 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_6, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_6
  if { [catch {set sumator_complet_1bit_6 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_6 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_7, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_7
  if { [catch {set sumator_complet_1bit_7 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_7 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_8, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_8
  if { [catch {set sumator_complet_1bit_8 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_8 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_9, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_9
  if { [catch {set sumator_complet_1bit_9 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_9 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_10, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_10
  if { [catch {set sumator_complet_1bit_10 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_10 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_11, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_11
  if { [catch {set sumator_complet_1bit_11 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_11 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_12, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_12
  if { [catch {set sumator_complet_1bit_12 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_12 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_13, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_13
  if { [catch {set sumator_complet_1bit_13 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_13 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_14, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_14
  if { [catch {set sumator_complet_1bit_14 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_14 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sumator_complet_1bit_15, and set properties
  set block_name sumator_complet_1bit
  set block_cell_name sumator_complet_1bit_15
  if { [catch {set sumator_complet_1bit_15 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sumator_complet_1bit_15 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net GUAT_0_GUAT_G [get_bd_ports GUAT_G_0] [get_bd_pins GUAT_0/GUAT_G]
  connect_bd_net -net GUAT_0_GUAT_P [get_bd_ports GUAT_P_0] [get_bd_pins GUAT_0/GUAT_P]
  connect_bd_net -net GUAT_0_carry_GUAT [get_bd_pins GUAT_0/carry_GUAT] [get_bd_pins splitter_GUAT_0/carry_GUAT]
  connect_bd_net -net UAT_0_UAT_G [get_bd_pins UAT_0/UAT_G] [get_bd_pins modul_concat_uat_0/g0]
  connect_bd_net -net UAT_0_UAT_P [get_bd_pins UAT_0/UAT_P] [get_bd_pins modul_concat_uat_0/p0]
  connect_bd_net -net UAT_0_carry_UAT [get_bd_pins UAT_0/carry_UAT] [get_bd_pins defalcare_UAT_0/c_UAT]
  connect_bd_net -net UAT_1_UAT_G [get_bd_pins UAT_1/UAT_G] [get_bd_pins modul_concat_uat_0/g1]
  connect_bd_net -net UAT_1_UAT_P [get_bd_pins UAT_1/UAT_P] [get_bd_pins modul_concat_uat_0/p1]
  connect_bd_net -net UAT_1_carry_UAT [get_bd_pins UAT_1/carry_UAT] [get_bd_pins defalcare_UAT_1/c_UAT]
  connect_bd_net -net UAT_2_UAT_G [get_bd_pins UAT_2/UAT_G] [get_bd_pins modul_concat_uat_0/g2]
  connect_bd_net -net UAT_2_UAT_P [get_bd_pins UAT_2/UAT_P] [get_bd_pins modul_concat_uat_0/p2]
  connect_bd_net -net UAT_2_carry_UAT [get_bd_pins UAT_2/carry_UAT] [get_bd_pins defalcare_UAT_2/c_UAT]
  connect_bd_net -net UAT_3_UAT_G [get_bd_pins UAT_3/UAT_G] [get_bd_pins modul_concat_uat_0/g3]
  connect_bd_net -net UAT_3_UAT_P [get_bd_pins UAT_3/UAT_P] [get_bd_pins modul_concat_uat_0/p3]
  connect_bd_net -net UAT_3_carry_UAT [get_bd_pins UAT_3/carry_UAT] [get_bd_pins defalcare_UAT_3/c_UAT]
  connect_bd_net -net a_0_1 [get_bd_ports a_0] [get_bd_pins modul_input_0/a]
  connect_bd_net -net b_0_1 [get_bd_ports b_0] [get_bd_pins modul_input_0/b]
  connect_bd_net -net c_in_0_1 [get_bd_ports c_in_0] [get_bd_pins modul_input_0/c_in]
  connect_bd_net -net defalcare_UAT_0_c_in_0 [get_bd_pins defalcare_UAT_0/c_in_0] [get_bd_pins sumator_complet_1bit_1/c_in]
  connect_bd_net -net defalcare_UAT_0_c_in_1 [get_bd_pins defalcare_UAT_0/c_in_1] [get_bd_pins sumator_complet_1bit_2/c_in]
  connect_bd_net -net defalcare_UAT_0_c_in_2 [get_bd_pins defalcare_UAT_0/c_in_2] [get_bd_pins sumator_complet_1bit_3/c_in]
  connect_bd_net -net defalcare_UAT_1_c_in_0 [get_bd_pins defalcare_UAT_1/c_in_0] [get_bd_pins sumator_complet_1bit_5/c_in]
  connect_bd_net -net defalcare_UAT_1_c_in_1 [get_bd_pins defalcare_UAT_1/c_in_1] [get_bd_pins sumator_complet_1bit_6/c_in]
  connect_bd_net -net defalcare_UAT_1_c_in_2 [get_bd_pins defalcare_UAT_1/c_in_2] [get_bd_pins sumator_complet_1bit_7/c_in]
  connect_bd_net -net defalcare_UAT_2_c_in_0 [get_bd_pins defalcare_UAT_2/c_in_0] [get_bd_pins sumator_complet_1bit_9/c_in]
  connect_bd_net -net defalcare_UAT_2_c_in_1 [get_bd_pins defalcare_UAT_2/c_in_1] [get_bd_pins sumator_complet_1bit_10/c_in]
  connect_bd_net -net defalcare_UAT_2_c_in_2 [get_bd_pins defalcare_UAT_2/c_in_2] [get_bd_pins sumator_complet_1bit_11/c_in]
  connect_bd_net -net defalcare_UAT_3_c_in_0 [get_bd_pins defalcare_UAT_3/c_in_0] [get_bd_pins sumator_complet_1bit_13/c_in]
  connect_bd_net -net defalcare_UAT_3_c_in_1 [get_bd_pins defalcare_UAT_3/c_in_1] [get_bd_pins sumator_complet_1bit_14/c_in]
  connect_bd_net -net defalcare_UAT_3_c_in_2 [get_bd_pins defalcare_UAT_3/c_in_2] [get_bd_pins sumator_complet_1bit_15/c_in]
  connect_bd_net -net modul_concat_sum_0_g_out [get_bd_pins UAT_0/g_in] [get_bd_pins modul_concat_sum_0/g_out]
  connect_bd_net -net modul_concat_sum_0_p_out [get_bd_pins UAT_0/p_in] [get_bd_pins modul_concat_sum_0/p_out]
  connect_bd_net -net modul_concat_sum_1_g_out [get_bd_pins UAT_1/g_in] [get_bd_pins modul_concat_sum_1/g_out]
  connect_bd_net -net modul_concat_sum_1_p_out [get_bd_pins UAT_1/p_in] [get_bd_pins modul_concat_sum_1/p_out]
  connect_bd_net -net modul_concat_sum_2_g_out [get_bd_pins UAT_2/g_in] [get_bd_pins modul_concat_sum_2/g_out]
  connect_bd_net -net modul_concat_sum_2_p_out [get_bd_pins UAT_2/p_in] [get_bd_pins modul_concat_sum_2/p_out]
  connect_bd_net -net modul_concat_sum_3_g_out [get_bd_pins UAT_3/g_in] [get_bd_pins modul_concat_sum_3/g_out]
  connect_bd_net -net modul_concat_sum_3_p_out [get_bd_pins UAT_3/p_in] [get_bd_pins modul_concat_sum_3/p_out]
  connect_bd_net -net modul_concat_uat_0_uat_g [get_bd_pins GUAT_0/UAT_G] [get_bd_pins modul_concat_uat_0/uat_g]
  connect_bd_net -net modul_concat_uat_0_uat_p [get_bd_pins GUAT_0/UAT_P] [get_bd_pins modul_concat_uat_0/uat_p]
  connect_bd_net -net modul_defalcare_0_a1 [get_bd_pins modul_defalcare_0/a1] [get_bd_pins sumator_complet_1bit_0/a]
  connect_bd_net -net modul_defalcare_0_a2 [get_bd_pins modul_defalcare_0/a2] [get_bd_pins sumator_complet_1bit_1/a]
  connect_bd_net -net modul_defalcare_0_a3 [get_bd_pins modul_defalcare_0/a3] [get_bd_pins sumator_complet_1bit_2/a]
  connect_bd_net -net modul_defalcare_0_a4 [get_bd_pins modul_defalcare_0/a4] [get_bd_pins sumator_complet_1bit_3/a]
  connect_bd_net -net modul_defalcare_0_a5 [get_bd_pins modul_defalcare_0/a5] [get_bd_pins sumator_complet_1bit_4/a]
  connect_bd_net -net modul_defalcare_0_a6 [get_bd_pins modul_defalcare_0/a6] [get_bd_pins sumator_complet_1bit_5/a]
  connect_bd_net -net modul_defalcare_0_a7 [get_bd_pins modul_defalcare_0/a7] [get_bd_pins sumator_complet_1bit_6/a]
  connect_bd_net -net modul_defalcare_0_a8 [get_bd_pins modul_defalcare_0/a8] [get_bd_pins sumator_complet_1bit_7/a]
  connect_bd_net -net modul_defalcare_0_a9 [get_bd_pins modul_defalcare_0/a9] [get_bd_pins sumator_complet_1bit_8/a]
  connect_bd_net -net modul_defalcare_0_a10 [get_bd_pins modul_defalcare_0/a10] [get_bd_pins sumator_complet_1bit_9/a]
  connect_bd_net -net modul_defalcare_0_a11 [get_bd_pins modul_defalcare_0/a11] [get_bd_pins sumator_complet_1bit_10/a]
  connect_bd_net -net modul_defalcare_0_a12 [get_bd_pins modul_defalcare_0/a12] [get_bd_pins sumator_complet_1bit_11/a]
  connect_bd_net -net modul_defalcare_0_a13 [get_bd_pins modul_defalcare_0/a13] [get_bd_pins sumator_complet_1bit_12/a]
  connect_bd_net -net modul_defalcare_0_a14 [get_bd_pins modul_defalcare_0/a14] [get_bd_pins sumator_complet_1bit_13/a]
  connect_bd_net -net modul_defalcare_0_a15 [get_bd_pins modul_defalcare_0/a15] [get_bd_pins sumator_complet_1bit_14/a]
  connect_bd_net -net modul_defalcare_0_a16 [get_bd_pins modul_defalcare_0/a16] [get_bd_pins sumator_complet_1bit_15/a]
  connect_bd_net -net modul_defalcare_1_a1 [get_bd_pins modul_defalcare_1/a1] [get_bd_pins sumator_complet_1bit_0/b]
  connect_bd_net -net modul_defalcare_1_a2 [get_bd_pins modul_defalcare_1/a2] [get_bd_pins sumator_complet_1bit_1/b]
  connect_bd_net -net modul_defalcare_1_a3 [get_bd_pins modul_defalcare_1/a3] [get_bd_pins sumator_complet_1bit_2/b]
  connect_bd_net -net modul_defalcare_1_a4 [get_bd_pins modul_defalcare_1/a4] [get_bd_pins sumator_complet_1bit_3/b]
  connect_bd_net -net modul_defalcare_1_a5 [get_bd_pins modul_defalcare_1/a5] [get_bd_pins sumator_complet_1bit_4/b]
  connect_bd_net -net modul_defalcare_1_a6 [get_bd_pins modul_defalcare_1/a6] [get_bd_pins sumator_complet_1bit_5/b]
  connect_bd_net -net modul_defalcare_1_a7 [get_bd_pins modul_defalcare_1/a7] [get_bd_pins sumator_complet_1bit_6/b]
  connect_bd_net -net modul_defalcare_1_a8 [get_bd_pins modul_defalcare_1/a8] [get_bd_pins sumator_complet_1bit_7/b]
  connect_bd_net -net modul_defalcare_1_a9 [get_bd_pins modul_defalcare_1/a9] [get_bd_pins sumator_complet_1bit_8/b]
  connect_bd_net -net modul_defalcare_1_a10 [get_bd_pins modul_defalcare_1/a10] [get_bd_pins sumator_complet_1bit_9/b]
  connect_bd_net -net modul_defalcare_1_a11 [get_bd_pins modul_defalcare_1/a11] [get_bd_pins sumator_complet_1bit_10/b]
  connect_bd_net -net modul_defalcare_1_a12 [get_bd_pins modul_defalcare_1/a12] [get_bd_pins sumator_complet_1bit_11/b]
  connect_bd_net -net modul_defalcare_1_a13 [get_bd_pins modul_defalcare_1/a13] [get_bd_pins sumator_complet_1bit_12/b]
  connect_bd_net -net modul_defalcare_1_a14 [get_bd_pins modul_defalcare_1/a14] [get_bd_pins sumator_complet_1bit_13/b]
  connect_bd_net -net modul_defalcare_1_a15 [get_bd_pins modul_defalcare_1/a15] [get_bd_pins sumator_complet_1bit_14/b]
  connect_bd_net -net modul_defalcare_1_a16 [get_bd_pins modul_defalcare_1/a16] [get_bd_pins sumator_complet_1bit_15/b]
  connect_bd_net -net modul_input_0_a_out [get_bd_pins modul_defalcare_0/a] [get_bd_pins modul_input_0/a_out]
  connect_bd_net -net modul_input_0_b_out [get_bd_pins modul_defalcare_1/a] [get_bd_pins modul_input_0/b_out]
  connect_bd_net -net modul_input_0_c_in_out [get_bd_pins GUAT_0/c_in] [get_bd_pins UAT_0/c_in] [get_bd_pins modul_input_0/c_in_out] [get_bd_pins sumator_complet_1bit_0/c_in]
  connect_bd_net -net modul_refacere_suma_0_sum [get_bd_ports sum_0] [get_bd_pins modul_refacere_suma_0/sum]
  connect_bd_net -net splitter_GUAT_0_carry1 [get_bd_pins UAT_1/c_in] [get_bd_pins splitter_GUAT_0/carry1] [get_bd_pins sumator_complet_1bit_4/c_in]
  connect_bd_net -net splitter_GUAT_0_carry2 [get_bd_pins UAT_2/c_in] [get_bd_pins splitter_GUAT_0/carry2] [get_bd_pins sumator_complet_1bit_8/c_in]
  connect_bd_net -net splitter_GUAT_0_carry3 [get_bd_pins UAT_3/c_in] [get_bd_pins splitter_GUAT_0/carry3] [get_bd_pins sumator_complet_1bit_12/c_in]
  connect_bd_net -net splitter_GUAT_0_carry4 [get_bd_ports carry4_0] [get_bd_pins splitter_GUAT_0/carry4]
  connect_bd_net -net sumator_complet_1bit_0_g [get_bd_pins modul_concat_sum_0/g1] [get_bd_pins sumator_complet_1bit_0/g]
  connect_bd_net -net sumator_complet_1bit_0_p [get_bd_pins modul_concat_sum_0/p1] [get_bd_pins sumator_complet_1bit_0/p]
  connect_bd_net -net sumator_complet_1bit_0_sum [get_bd_pins modul_refacere_suma_0/s0] [get_bd_pins sumator_complet_1bit_0/sum]
  connect_bd_net -net sumator_complet_1bit_10_g [get_bd_pins modul_concat_sum_2/g3] [get_bd_pins sumator_complet_1bit_10/g]
  connect_bd_net -net sumator_complet_1bit_10_p [get_bd_pins modul_concat_sum_2/p3] [get_bd_pins sumator_complet_1bit_10/p]
  connect_bd_net -net sumator_complet_1bit_10_sum [get_bd_pins modul_refacere_suma_0/s10] [get_bd_pins sumator_complet_1bit_10/sum]
  connect_bd_net -net sumator_complet_1bit_11_g [get_bd_pins modul_concat_sum_2/g4] [get_bd_pins sumator_complet_1bit_11/g]
  connect_bd_net -net sumator_complet_1bit_11_p [get_bd_pins modul_concat_sum_2/p4] [get_bd_pins sumator_complet_1bit_11/p]
  connect_bd_net -net sumator_complet_1bit_11_sum [get_bd_pins modul_refacere_suma_0/s11] [get_bd_pins sumator_complet_1bit_11/sum]
  connect_bd_net -net sumator_complet_1bit_12_g [get_bd_pins modul_concat_sum_3/g1] [get_bd_pins sumator_complet_1bit_12/g]
  connect_bd_net -net sumator_complet_1bit_12_p [get_bd_pins modul_concat_sum_3/p1] [get_bd_pins sumator_complet_1bit_12/p]
  connect_bd_net -net sumator_complet_1bit_12_sum [get_bd_pins modul_refacere_suma_0/s12] [get_bd_pins sumator_complet_1bit_12/sum]
  connect_bd_net -net sumator_complet_1bit_13_g [get_bd_pins modul_concat_sum_3/g2] [get_bd_pins sumator_complet_1bit_13/g]
  connect_bd_net -net sumator_complet_1bit_13_p [get_bd_pins modul_concat_sum_3/p2] [get_bd_pins sumator_complet_1bit_13/p]
  connect_bd_net -net sumator_complet_1bit_13_sum [get_bd_pins modul_refacere_suma_0/s13] [get_bd_pins sumator_complet_1bit_13/sum]
  connect_bd_net -net sumator_complet_1bit_14_g [get_bd_pins modul_concat_sum_3/g3] [get_bd_pins sumator_complet_1bit_14/g]
  connect_bd_net -net sumator_complet_1bit_14_p [get_bd_pins modul_concat_sum_3/p3] [get_bd_pins sumator_complet_1bit_14/p]
  connect_bd_net -net sumator_complet_1bit_14_sum [get_bd_pins modul_refacere_suma_0/s14] [get_bd_pins sumator_complet_1bit_14/sum]
  connect_bd_net -net sumator_complet_1bit_15_g [get_bd_pins modul_concat_sum_3/g4] [get_bd_pins sumator_complet_1bit_15/g]
  connect_bd_net -net sumator_complet_1bit_15_p [get_bd_pins modul_concat_sum_3/p4] [get_bd_pins sumator_complet_1bit_15/p]
  connect_bd_net -net sumator_complet_1bit_15_sum [get_bd_pins modul_refacere_suma_0/s15] [get_bd_pins sumator_complet_1bit_15/sum]
  connect_bd_net -net sumator_complet_1bit_1_g [get_bd_pins modul_concat_sum_0/g2] [get_bd_pins sumator_complet_1bit_1/g]
  connect_bd_net -net sumator_complet_1bit_1_p [get_bd_pins modul_concat_sum_0/p2] [get_bd_pins sumator_complet_1bit_1/p]
  connect_bd_net -net sumator_complet_1bit_1_sum [get_bd_pins modul_refacere_suma_0/s1] [get_bd_pins sumator_complet_1bit_1/sum]
  connect_bd_net -net sumator_complet_1bit_2_g [get_bd_pins modul_concat_sum_0/g3] [get_bd_pins sumator_complet_1bit_2/g]
  connect_bd_net -net sumator_complet_1bit_2_p [get_bd_pins modul_concat_sum_0/p3] [get_bd_pins sumator_complet_1bit_2/p]
  connect_bd_net -net sumator_complet_1bit_2_sum [get_bd_pins modul_refacere_suma_0/s2] [get_bd_pins sumator_complet_1bit_2/sum]
  connect_bd_net -net sumator_complet_1bit_3_g [get_bd_pins modul_concat_sum_0/g4] [get_bd_pins sumator_complet_1bit_3/g]
  connect_bd_net -net sumator_complet_1bit_3_p [get_bd_pins modul_concat_sum_0/p4] [get_bd_pins sumator_complet_1bit_3/p]
  connect_bd_net -net sumator_complet_1bit_3_sum [get_bd_pins modul_refacere_suma_0/s3] [get_bd_pins sumator_complet_1bit_3/sum]
  connect_bd_net -net sumator_complet_1bit_4_g [get_bd_pins modul_concat_sum_1/g1] [get_bd_pins sumator_complet_1bit_4/g]
  connect_bd_net -net sumator_complet_1bit_4_p [get_bd_pins modul_concat_sum_1/p1] [get_bd_pins sumator_complet_1bit_4/p]
  connect_bd_net -net sumator_complet_1bit_4_sum [get_bd_pins modul_refacere_suma_0/s4] [get_bd_pins sumator_complet_1bit_4/sum]
  connect_bd_net -net sumator_complet_1bit_5_g [get_bd_pins modul_concat_sum_1/g2] [get_bd_pins sumator_complet_1bit_5/g]
  connect_bd_net -net sumator_complet_1bit_5_p [get_bd_pins modul_concat_sum_1/p2] [get_bd_pins sumator_complet_1bit_5/p]
  connect_bd_net -net sumator_complet_1bit_5_sum [get_bd_pins modul_refacere_suma_0/s5] [get_bd_pins sumator_complet_1bit_5/sum]
  connect_bd_net -net sumator_complet_1bit_6_g [get_bd_pins modul_concat_sum_1/g3] [get_bd_pins sumator_complet_1bit_6/g]
  connect_bd_net -net sumator_complet_1bit_6_p [get_bd_pins modul_concat_sum_1/p3] [get_bd_pins sumator_complet_1bit_6/p]
  connect_bd_net -net sumator_complet_1bit_6_sum [get_bd_pins modul_refacere_suma_0/s6] [get_bd_pins sumator_complet_1bit_6/sum]
  connect_bd_net -net sumator_complet_1bit_7_g [get_bd_pins modul_concat_sum_1/g4] [get_bd_pins sumator_complet_1bit_7/g]
  connect_bd_net -net sumator_complet_1bit_7_p [get_bd_pins modul_concat_sum_1/p4] [get_bd_pins sumator_complet_1bit_7/p]
  connect_bd_net -net sumator_complet_1bit_7_sum [get_bd_pins modul_refacere_suma_0/s7] [get_bd_pins sumator_complet_1bit_7/sum]
  connect_bd_net -net sumator_complet_1bit_8_g [get_bd_pins modul_concat_sum_2/g1] [get_bd_pins sumator_complet_1bit_8/g]
  connect_bd_net -net sumator_complet_1bit_8_p [get_bd_pins modul_concat_sum_2/p1] [get_bd_pins sumator_complet_1bit_8/p]
  connect_bd_net -net sumator_complet_1bit_8_sum [get_bd_pins modul_refacere_suma_0/s8] [get_bd_pins sumator_complet_1bit_8/sum]
  connect_bd_net -net sumator_complet_1bit_9_g [get_bd_pins modul_concat_sum_2/g2] [get_bd_pins sumator_complet_1bit_9/g]
  connect_bd_net -net sumator_complet_1bit_9_p [get_bd_pins modul_concat_sum_2/p2] [get_bd_pins sumator_complet_1bit_9/p]
  connect_bd_net -net sumator_complet_1bit_9_sum [get_bd_pins modul_refacere_suma_0/s9] [get_bd_pins sumator_complet_1bit_9/sum]

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


