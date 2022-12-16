-- VHDL Entity Projet_I2CIP_lib.Z_Interface.interface
--
-- Created:
--          by - CHAIMA.UNKNOWN (LAPTOP-I71U7FVH)
--          at - 22:46:39 18/11/2022
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2018.2 (Build 19)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Projet_I2CIP_lib;
USE Projet_I2CIP_lib.I2C_Package.ALL;

ENTITY Z_Interface IS
   PORT( 
      Addr              : IN     DefAddr;
      Clk               : IN     DefBit;
      DataReceived      : IN     DefData;
      RnW               : IN     DefBit;
      Status            : IN     DefStatus;
      nAS               : IN     DefBit;
      nBE0              : IN     DefBit;
      nBE1              : IN     DefBit;
      nRst              : IN     DefBit;
      nWait             : IN     DefBit;
      Config            : OUT    DefConfig;
      DataToSend        : OUT    DefData;
      Transfert_Request : OUT    DefBit;
      Dbus              : INOUT  DefDbus
   );

-- Declarations

END Z_Interface ;

--
-- VHDL Architecture Projet_I2CIP_lib.Z_Interface.struct
--
-- Created:
--          by - CHAIMA.UNKNOWN (LAPTOP-I71U7FVH)
--          at - 22:46:53 28/11/2022
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2018.2 (Build 19)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Projet_I2CIP_lib;
USE Projet_I2CIP_lib.I2C_Package.ALL;


ARCHITECTURE struct OF Z_Interface IS

   -- Architecture declarations

   -- Internal signal declarations


   -- Component Declarations
   COMPONENT Z_Read
   PORT (
      Addr         : IN     DefAddr ;
      DataReceived : IN     DefData ;
      RnW          : IN     DefBit ;
      Status       : IN     DefStatus ;
      nAS          : IN     DefBit ;
      nBE0         : IN     DefBit ;
      nBE1         : IN     DefBit ;
      nRst         : IN     DefBit ;
      nWait        : IN     DefBit ;
      Dbus         : INOUT  DefDbus 
   );
   END COMPONENT;
   COMPONENT Z_Write
   PORT (
      Addr              : IN     DefAddr ;
      Clk               : IN     DefBit ;
      Dbus              : IN     DefDbus ;
      RnW               : IN     DefBit ;
      nAS               : IN     DefBit ;
      nBE0              : IN     DefBit ;
      nBE1              : IN     DefBit ;
      nRst              : IN     DefBit ;
      Config            : OUT    DefConfig ;
      DataToSend        : OUT    DefData ;
      Transfert_Request : OUT    DefBit 
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : Z_Read USE ENTITY Projet_I2CIP_lib.Z_Read;
   FOR ALL : Z_Write USE ENTITY Projet_I2CIP_lib.Z_Write;
   -- pragma synthesis_on


BEGIN

   -- Instance port mappings.
   U_0 : Z_Read
      PORT MAP (
         Addr         => Addr,
         DataReceived => DataReceived,
         RnW          => RnW,
         Status       => Status,
         nAS          => nAS,
         nBE0         => nBE0,
         nBE1         => nBE1,
         nRst         => nRst,
         nWait        => nWait,
         Dbus         => Dbus
      );
   U_1 : Z_Write
      PORT MAP (
         Addr              => Addr,
         Clk               => Clk,
         Dbus              => Dbus,
         RnW               => RnW,
         nAS               => nAS,
         nBE0              => nBE0,
         nBE1              => nBE1,
         nRst              => nRst,
         Config            => Config,
         DataToSend        => DataToSend,
         Transfert_Request => Transfert_Request
      );

END struct;
