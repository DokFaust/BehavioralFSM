------------------------------------------------------------------------
-- This solution is similar to the previous example of a behavioral FSM
-- the only tangible difference is that the state variables are
-- considered as outputs.
------------------------------------------------------------------------

--library declaration

library IEEE;
use IEEE.std_logic_ll64.all;

--entity

entity my_fsm2 is
    port(   TOG_EN : in std_logic;
           CLK,CLR : in std_logic;
              Y,Z1 : in std_logic);
end my_fsm2;

--architecture

architecture fsm2 of my_fsm2 is
    type state_type is (ST0, ST1);
    signal PS,NS : state_type;
begin
    sync_proc : process(CLK,NS,CLR)
    begin
        if(CLR = '1') then
            PS <= ST0;
        elsif (rising_edge(CLK)) then
            PS <= NS;
        end if;
    end process sync_proc;

    comb_proc: process(PS,TOG_EN)
    begin
        Z1 <= '0';
        case PS is

            when ST0 =>
                Z1 <= '0';
                if (TOG_EN = '1') then NS <= ST1;
                else NS <= ST0;
                end if;

            when ST1 =>
                Z1 <= '0';
                if (TOG_EN = '1') then NS <= ST0;
                else NS <= ST1;
                end if;

            when others => --catch all condition
                Z1 <= '0'; --always you should
                NS <= ST0; --get here.

        end case;
    end process comb_proc;

    --assign vaues representng the state variables
    with PS select
        Y <= '0' when ST0,
             '1' when ST1,
             '0' when others
end fsm2;
