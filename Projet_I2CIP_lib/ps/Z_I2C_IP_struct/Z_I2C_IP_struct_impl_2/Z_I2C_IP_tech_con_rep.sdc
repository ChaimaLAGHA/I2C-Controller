###################################################################################
# Mentor Graphics Corporation
#
###################################################################################


################
# create clock #
################

# Precision Generated
create_clock [get_ports {Clk}] -name {Clk} -domain {Clk_PS} -period 10 -waveform {0 5} -constraint_source derived
create_clock [get_pins {U_2/ix792z1361/O}] -name {U_2/ix792z1361/O} -domain {Clk_PS} -period 10 -waveform {0 5} -constraint_source derived

##########################
# create generated clock #
##########################

# Precision Generated
create_generated_clock -name {U_2/reg_tmp/Q} -domain {Clk_PS} -source [get_ports {Clk}] -multiply_by 1 -divide_by 2 -duty_cycle 50 [get_pins {U_2/reg_tmp/Q}] -constraint_source derived

#######################
# set multicycle path #
#######################

# Precision Generated
set_multicycle_path 2 -from [get_cells {U_1/reg_SCK}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_SDA_TD_rtlcGen1}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_SDA_TE_rtlcGen0}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_State(1)}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_State(2)}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_State(3)}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_State(4)}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_State(5)}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_State(6)}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_State(7)}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_State(8)}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_Status_Busy}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_Status_Read_Done}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_Status_Waiting_ACK}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_Status_Write_Done}] -constraint_source derived
set_multicycle_path 2 -from [get_cells {U_1/reg_Status_Write_Error}] -constraint_source derived
