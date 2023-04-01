
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name lab07 -dir "D:/DSD_LAB_07/lab07/planAhead_run_2" -part xc6slx9csg324-2
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "L2P.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {lab07.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top L2P $srcset
add_files [list {L2P.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx9csg324-2
