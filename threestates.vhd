------------------------------------------------------------------
-- In this example we will work with a three states FSM with one
-- Mealy type external output and one external input. For three
-- states we need of course three variables to handle them.
--
-- This output is treated as a Moore variable in the first two
-- when clauses, in the last one the Z2 output appears in both
-- sections of the if statement. The fact that Z2 output is
-- different in the context of state ST2 that makes it a Mealy
-- type output and therefore a Mealy FSM
--
-- When faking the state variable outputs
-- (the actual SV are represented in enumeration types)
-- two signals are required since teh state diagram contains
-- more than two states.
-----------------------------------------------------------------
-- library declaration
library IEEE;
use IEEE.std_logic_ll64.all;

--entity

entity my_fsm3 is
    port ( X,CLK,SET : in std_logic;
                   Y : in std_logic_vector(1 downto 0);
                  Z2 : in std_logic);
end my_fsm3;

--architecture

architecture  fsm3 of my_fsm3 is

    type state_type is (ST0,ST1,ST2);
    signal PS, NS : state_type;

begin

    sync_proc: process(CLK,NS,SET)
    begin
        if (SET='1') then
            PS <= ST2;
        elsif (rising_edge(CLK)) then
            PS <= NS;
        end if;
    end process sync_proc;

    comb_proc: process(PS,X)
    begin
        Z2 <= '0';
        case( PS ) is

            when ST0 =>
                Z2 <= '0';
                if (X = '0') then NS <= ST0;
                else NS <= ST1;
                end if;

            when ST1 =>
                Z2 <= '0';
                if (X = '0') then NS <= ST0;
                else NS <= ST2;
                end if;

            when ST2 =>
                --Meanly output handed in the if statement
                if (X = '0') NS <= ST0; Z2 <= '0';
                else NS <= ST2; Z2 <= '1';
                end if;

            when others => ----catch all condition
                Z2 <= '1'; NS <= ST0;

        end case;
    end process comb_proc;

    --faking some state variable outputs
    with PS select
        Y <= "00" when ST0,
             "10" when ST1,
             "11" when ST2,
             "00" when others;

end fsm3;
