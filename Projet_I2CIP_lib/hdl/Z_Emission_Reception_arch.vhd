--
-- VHDL Architecture Projet_I2CIP_lib.Z_Emission_Reception.arch
--
-- Created:
--          by - CHAIMA.LAGHA (LAPTOP-I71U7FVH)
--          at - 20:17:30 19/11/2022
--
-- using Mentor Graphics HDL Designer(TM) 2018.2 (Build 19)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;



LIBRARY Projet_I2CIP_lib;
USE Projet_I2CIP_lib.I2C_Package.ALL;

ENTITY Z_Emission_Reception IS
   PORT( 
      Clk          : IN     DefBit;
      Config       : IN     DefConfig;
      DataToSend   : IN     DefData;
      SCK_intern   : IN     DefBit;
      nRst         : IN     DefBit;
      DataReceived : OUT    DefData;
      SCK          : OUT    DefBit;
      Status       : OUT    DefStatus;
      SDA          : INOUT  DefBit
   );
END Z_Emission_Reception ;

ARCHITECTURE arch OF Z_Emission_Reception IS
  
 signal SCK_flip : std_logic := '0'; 
 signal Stuck_Data: std_logic_vector (7 downto 0);
 signal cpt : integer ;
-- --------------------------------------------------------------------------------------------
-- | FONCTION NB_Donnees_to_integer (s: DefNb_Donnees)
-- | -> Convertion le type DefNb_Donnees en integer 
-- --------------------------------------------------------------------------------------------
  FUNCTION NB_Donnees_to_integer (s : DefNb_Donnees ) RETURN integer IS
  VARIABLE NB_Data : integer:=0 ;
  variable n:integer :=0;
  BEGIN
    loop 
      if(s(n)= '1')then 
       NB_Data:= NB_Data + 2**n;
      end if;
      n:=n+1;
     exit when (n=8);
    end loop;
  RETURN NB_Data ;
  END FUNCTION NB_Donnees_to_integer ;
  
 --
BEGIN
  Emission_ReceptionProc : process(nRst,SCK_intern)
  --
   variable State : DefState;
   variable CptData : integer ;
   variable i : integer range 0 to 4;
   variable j : integer range 0 to 7;
    
  begin
    if (nRst ='0')then 
    SCK <= '0';
    SDA<='0';
    DataReceived<= (others=>'Z');
    Status<= (others=>'0');
    State := idle;
    elsif rising_edge(SCK_intern)then 
     case State is
      when idle =>
        i:= 0; 
        Status.Busy<='0';
        Status.Write_Error<='0';
        Status.Read_Error<='0';
        Status.Waiting_ACK<='0';
        Status.Write_Done <='0';
        Status.Read_Done<='0';
        SDA <= '0';
        SCK <= '0';
        CptData:= NB_Donnees_to_integer(Config.NB_Donnees);
        State :=sending_StartBit;
        
      when sending_StartBit =>    
        --SDA passe à zéro pour t=Tbit/4 
         Status.Busy <='1'; 
           if (i=0) then
           SDA <= '1';
           SCK <= '1';
           end if;
           if (i=3) then --4
               i:=0;
               SCK_flip <= '0';
               j:=7;
               State:=sending_Address;
           else              
               if (i=1) then
               SDA <= '0'; 
               end if ;
               if (i=2) then
               SCK<= '0';
               end if;
            i:=i+1;
            end if;
            
      when sending_Address =>
        if (i=2 or i=0)then
          SCK_flip <= not SCK_flip;
          SCK <= not SCK_flip;
          SDA <= DataToSend(j);
        end if ;
        if(i=3 and j=0) then
          i:=0;
          j:=7;
          State:= sending_RnWBit;
        elsif (i=3 and j/=0)then
          i:=0;
        else
          i:=i+1;
        end if ;
        if (i=0 and j/=0) then 
         j:=j-1;
       end if ;

     when sending_RnWBit =>
       --Status.Write_done <= '0';
       if(i=2 or i=0) then
       SCK_flip <= not SCK_flip;
		   SCK <= not SCK_flip;
       end if ;
       if (i=3) then
         i:=0; 
         State:= waiting_AckBit;
         Status.Waiting_ACK <='1';
       else  
         i:=i+1;
       end if ;
		   SDA<=Config.Sens_Echange;
		   
     when waiting_AckBit =>
       SDA<= 'Z';
      if (i=2 or i=0)then 
       SCk_flip <=not SCk_flip;
		   SCK <= not SCK_flip;
      end if ;
      if (i=3 and SDA='1' and CptData=0) then
       i:=0; 
       Status.Waiting_ACK <='0';
       State:= sending_StopBit;
      elsif (i=3 and SDA='1' and CptData/=0) then
		   i :=0;
        if (Config.Sens_Echange= '1') then
         State:= Receive_Data;
        else 
         State:=Send_Data;
        end if;
        j:=7;
        Status.Waiting_ACK <='0';
      elsif (i=4 and SDA/= '1')then 
       Status.Write_Error <='1';
       i:=0;
       State:=idle;
      else 
       i:=i+1;
      end if ;
      
     when Send_Data => 		   
       if (i=0 or  i=2)then  
        SCk_flip <=not SCk_flip;
		    SCK <= not SCK_flip;
       end if ;
       SDA <= DataToSend(j);
       if(i=3 and j=0) then
        i:=0;
        j:=7;
			  
			  CptData:=CptData-1;	
        State:= waiting_AckBit;
        Status.Waiting_ACK <='1';
       elsif (i=3 and j/=0)then
        --j:=j-1;
        i:=0;
       else 
        i:=i+1;
       end if;
       if (i=0 and j/=0) then 
         j:=j-1;
       end if ; 
        
     when Receive_Data =>
       SDA<= 'Z';
       if (i=2 or i=0)then 
        SCk_flip <=not SCk_flip;
		    SCK <=  not SCK_flip;
       end if ;
       if(i=3 and j=0) then
        i:=0;
        j:=7;
        CptData:=CptData-1;
        DataReceived<= Stuck_Data;
        State:= sending_AckBit;
       elsif (i=3 and j/=0)then
        j:= j-1 ;
        i:=0;
       else 
        i:=i+1;
       end if;
       Stuck_Data(j)<=SDA ;       
     when sending_AckBit =>
       if (i=2 or i=0)then
         SCK_flip <= not SCk_flip;
         SCK <= not SCK_flip;
       end if ;
       if (i=3 and CptData=0) then 
         i:=0;
         State:= sending_StopBit;
         SDA <= '0'; 
       elsif (i=3 and CptData/=0)then
         State:= Receive_Data;
         i:=0;
       else  
         i:=i+1;
         SDA <='1';
       end if ;
		   
     when sending_StopBit =>
       SDA <= '0';
       if (i=3) then
         i:=0;
         SDA<= '1';
         Status.Busy<='0';
         State:=idle;
       elsif (i=2)then
         SCK <='1'; 
       end if;
         i:=i+1;
       if (Config.Sens_Echange= '0') then
         Status.Write_Done <='1';
        else 
         Status.Read_Done <='1';
        end if;
     end case ;
    end if ;
  end process Emission_ReceptionProc;  
  
END ARCHITECTURE arch;

