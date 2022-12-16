###################################################################################
# Mentor Graphics Corporation
#
###################################################################################


################
# create clock #
################

# Precision Generated
create_clock [get_ports {Clk}] -name {Clk} -period 10 -waveform {0 5} -constraint_source derived
create_clock [get_pins {U_2/ix5/out}] -name {U_2/ix5/out} -period 10 -waveform {0 5} -constraint_source derived

##########################
# create generated clock #
##########################

# Precision Generated
create_generated_clock -name {U_2/reg_tmp/out} -source [get_ports {Clk}] -multiply_by 1 -divide_by 2 -duty_cycle 50 [get_pins {U_2/reg_tmp/out}] -constraint_source derived
