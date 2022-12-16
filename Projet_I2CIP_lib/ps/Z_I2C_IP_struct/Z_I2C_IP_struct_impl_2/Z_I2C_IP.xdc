###################################################################################
# Mentor Graphics Corporation
#
###################################################################################


################
# create clock #
################

# Precision Generated
create_clock [get_ports {Clk}] -name {Clk} -period 10 -waveform {0 5}
create_clock [get_pins {U_2/ix792z1361/O}] -name {U_2/ix792z1361/O} -period 10 -waveform {0 5}

##########################
# create generated clock #
##########################

# Precision Generated
create_generated_clock -name {U_2/reg_tmp/Q} -source [get_ports {Clk}] -multiply_by 1 -divide_by 2 -duty_cycle 50 [get_pins {U_2/reg_tmp/Q}]

#######################
# set multicycle path #
#######################

# Precision Generated
set_multicycle_path 2 -from [get_cells {U_1/reg_SCK}]
set_multicycle_path 2 -from [get_cells {U_1/reg_SDA_TD_rtlcGen1}]
set_multicycle_path 2 -from [get_cells {U_1/reg_SDA_TE_rtlcGen0}]
set_multicycle_path 2 -from [get_cells {U_1/reg_State(1)}]
set_multicycle_path 2 -from [get_cells {U_1/reg_State(2)}]
set_multicycle_path 2 -from [get_cells {U_1/reg_State(3)}]
set_multicycle_path 2 -from [get_cells {U_1/reg_State(4)}]
set_multicycle_path 2 -from [get_cells {U_1/reg_State(5)}]
set_multicycle_path 2 -from [get_cells {U_1/reg_State(6)}]
set_multicycle_path 2 -from [get_cells {U_1/reg_State(7)}]
set_multicycle_path 2 -from [get_cells {U_1/reg_State(8)}]
set_multicycle_path 2 -from [get_cells {U_1/reg_Status_Busy}]
set_multicycle_path 2 -from [get_cells {U_1/reg_Status_Read_Done}]
set_multicycle_path 2 -from [get_cells {U_1/reg_Status_Waiting_ACK}]
set_multicycle_path 2 -from [get_cells {U_1/reg_Status_Write_Done}]
set_multicycle_path 2 -from [get_cells {U_1/reg_Status_Write_Error}]
