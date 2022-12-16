-- VHDL Entity Projet_I2CIP_lib.Read.generatedInstance
--
-- Created:
--          by - E21C396C.UNKNOWN (irc107-04)
--          at - 14:30:37 17/11/2022
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2022.1 Built on 21 Jan 2022 at 13:00:30
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Projet_I2CIP_lib;
USE Projet_I2CIP_lib.I2C_Package.ALL;

ENTITY Read IS
   PORT( 
      Addr         : IN     DefAddr;
      DataReceived : IN     DefData;
      Dbus         : OUT    DefDbus;
      nAS          : IN     DefBit;
      Status       : IN     DefStatus
   );

END Read ;

-- 
-- Auto generated dummy architecture for leaf level instance.
-- 
ARCHITECTURE generatedInstance OF Read IS 
BEGIN


END generatedInstance;