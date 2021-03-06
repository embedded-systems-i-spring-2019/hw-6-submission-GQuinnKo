----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2019 10:55:47 AM
-- Design Name: 
-- Module Name: ex11_2 - Behavioral
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

entity ex11_2 is
  Port ( CLK, X1, X2 : in std_logic;
         Z : out std_logic;
         Y : out std_logic_vector(1 downto 0));
end ex11_2;

architecture Behavioral of ex11_2 is

type state_type is (ST0,ST1,ST2); --ST0,ST1,ST2 is a,b,c respectively
signal PS,NS : state_type;

begin

process(clk, NS)
begin
if (rising_edge(CLK)) then
    PS <= NS;
end if;
end process;

process(PS, X1, X2)
begin

case PS is
    when  ST0 =>
        Z <= '0';
        if( X1 = '1') then NS <= ST2;
        else    NS <= ST0;
        end if;
            
    when ST1 =>
        if( X2 = '1') then NS <= ST1; 
                           Z <= '0';
        else    NS <= ST0; 
                Z <= '1';
        end if;
    
    when ST2 =>
        if( X2 = '1') then NS <= ST1; 
                           Z <= '0';
        else    NS <= ST0; 
                Z <= '1';
        end if;

    when others => 
        Z <= '0'; 
        NS <= ST0;
    end case;
end process;

with PS select Y <= 
      "10" when ST0,
      "11" when ST1,
      "01" when ST2,
      "10" when others;
      
end Behavioral;
