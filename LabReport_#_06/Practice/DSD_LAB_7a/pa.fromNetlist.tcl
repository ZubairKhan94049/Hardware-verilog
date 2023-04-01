
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name lab_07 -dir "D:/EngineeringData/6th_Semester/Digital_System_Design_LAB/LabReport_#_06/Practice/DSD_LAB_7a/planAhead_run_5" -part xc6slx9csg324-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/EngineeringData/6th_Semester/Digital_System_Design_LAB/LabReport_#_06/Practice/DSD_LAB_7a/counter.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/EngineeringData/6th_Semester/Digital_System_Design_LAB/LabReport_#_06/Practice/DSD_LAB_7a} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "counter.ucf" [current_fileset -constrset]
add_files [list {counter.ucf}] -fileset [get_property constrset [current_run]]
link_design
