--
-- VHDL Architecture Projet_I2CIP_lib.PeripheriqueI2C.arch
--
-- Created:
--          by - CHAIMA.UNKNOWN (LAPTOP-I71U7FVH)
--          at - 13:33:07 26/11/2022
--
-- using Mentor Graphics HDL Designer(TM) 2018.2 (Build 19)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Projet_I2CIP_lib;
USE Projet_I2CIP_lib.I2C_Package.ALL;

ENTITY PeripheriqueI2C IS
   PORT( 
      SCK : IN     DefBit;
      nRst : IN    DefBit;
      SDA : INOUT  DefBit
   );

-- Declarations

END PeripheriqueI2C ;

--
ARCHITECTURE arch OF PeripheriqueI2C IS
  signal sda_ack : std_logic :='0';
BEGIN
    I2C_SlaveProc: process(SCK, nRst)
  variable i : integer :=0 ;
  
  begin 
    -- Rexeiving data from the I2C controller 
    -- SEnding first acknowledgement bit when receiving address
 
    if(nRst ='0') then 
      i:=0;
    elsif (Rising_Edge(SCK)) then 
    -- Rexeiving data from the I2C controller 
    -- SEnding first acknowledgement bit when receiving address
    
       if(i=9) then 
       SDA <= '1'; 
       else
       sda_ack <= SDA;  
       i:=i+1;
       end if;
    end if; 
  end process I2C_SlaveProc;

END ARCHITECTURE arch;

