-- VHDL Entity Projet_I2CIP_lib.Z_Environement.generatedInstance
--
-- Created:
--          by - CHAIMA.UNKNOWN (LAPTOP-I71U7FVH)
--          at - 22:11:47 18/11/2022
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2018.2 (Build 19)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Projet_I2CIP_lib;
USE Projet_I2CIP_lib.I2C_Package.ALL;

ENTITY Z_Environement IS
   PORT( 
      Addr  : OUT    DefAddr;
      Clk   : OUT    DefBit;
      Dbus  : INOUT  DefDbus;
      nAS   : OUT    DefBit;
      nBE0  : OUT    DefBit;
      nBE1  : OUT    DefBit;
      nRst  : OUT    DefBit;
      nWait : OUT    DefBit;
      RnW   : OUT    DefBit
   );

END Z_Environement ;

-- 
-- Auto generated dummy architecture for leaf level instance.
-- 
ARCHITECTURE generatedInstance OF Z_Environement IS 
BEGIN


END generatedInstance;
