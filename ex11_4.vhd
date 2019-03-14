----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2019 12:02:18 PM
-- Design Name: 
-- Module Name: ex11_4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ex11_4 is
  Port ( INIT, CLK, X1, X2 : in std_logic;
         Z2 : out std_logic;
         Z1 : out std_logic);
end ex11_4;

architecture Behavioral of ex11_4 is

type state_type is (ST0,ST1,ST2); --ST0,ST1,ST2 is a,b,c respectively
signal PS,NS : state_type;

begin

process(clk, NS)
begin
if(INIT = '1') then
    PS <= ST0;
elsif (rising_edge(CLK)) then
    PS <= NS;
end if;
end process;

process(PS, X1, X2)
begin

case PS is
    when  ST0 =>
        if( X1 = '1') then 
            NS <= ST1;
            Z2 <= '1';
        else    
            NS <= ST2;
            Z2 <= '0';
        end if;
            
    when ST1 =>
        if( X2 = '1') then 
            NS <= ST0; 
            Z2 <= '0';
        else    
            NS <= ST2; 
            Z2 <= '1';
        end if;
    
    when ST2 =>
        if( X1 = '1') then 
            NS <= ST1; 
            Z2 <= '1';
        else    
            NS <= ST0; 
            Z2 <= '1';
        end if;

    when others => 
        Z2 <= '0'; 
        NS <= ST0;
    end case;
end process;

with PS select Z1 <= 
      '0' when ST0,
      '1' when ST1,
      '1' when ST2,
      '0' when others;
 

end Behavioral;
