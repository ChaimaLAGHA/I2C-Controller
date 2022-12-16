--
-- VHDL Architecture Projet_I2CIP_lib.Z_ClockGenerator.arch
--
-- Created:
--          by - CHAIMA.LAGHA (LAPTOP-I71U7FVH)
--          at - 00:35:38 19/11/2022
--
-- using Mentor Graphics HDL Designer(TM) 2018.2 (Build 19)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Projet_I2CIP_lib;
USE Projet_I2CIP_lib.I2C_Package.ALL;

ENTITY Z_ClockGenerator IS
   PORT( 
      Clk               : IN     DefBit;
      Config            : IN     DefConfig;
      Transfert_Request : IN     DefBit;
      nRst              : IN     DefBit;
      SCK_intern        : OUT    DefBit
   );

-- Declarations

END Z_ClockGenerator ;

--
ARCHITECTURE arch OF Z_ClockGenerator IS
    --signal count: integer:=1;
    signal tmp : std_logic := '0';
    signal current_Mode:std_logic:='1'; --mode standard
BEGIN
  ClockGeneratorByDivider : process (nRst,Clk, Config)
   variable count_max : integer :=3;
   variable count: integer :=1;
    begin
    if(nRst='0') then
    count_max:=125;-- Mode standard
    tmp<='0';
    elsif (transfert_Request='1')then
      if (config.Mode_Vitess/=current_Mode)then 
       -- count:=1;
        current_Mode<= config.Mode_Vitess;
      end if; 
      if(Config.Mode_Vitess='0')then 
        count_max:=3; ---
      end if;
      if rising_edge (Clk) then
    count :=count+1;
    if (count = count_max) then
    tmp <= NOT tmp;
    count := 1;
    end if;
    end if;
    end if ;
    SCK_intern <= tmp;
  end process ClockGeneratorByDivider;
END ARCHITECTURE arch;

