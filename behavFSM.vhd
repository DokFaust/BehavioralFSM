-------------------------------------------------------------------------------
-- In this first example state_type represents the states in the FSM.
-- PS and NS are expressed as state_type, which is not a native VHDL type.
--
-- The synchronous process is equal in theory to the simple D flip-flops.
-- The storage element is assigned to PS only, and is not specified for
-- every possible combination of inputs
--
-- The two processes operate concurrently, they can be considered as working
-- in a lock-step manner. Changes to the NS signal that are generated in
-- combinatorial process force an evaluation of the synchronous process.
-- A change in the synchronous process on the next clock edge, the changes in
-- the PS signal causes the combinatorial process to be evaluated.
--
-- Each process in the FSM is enforced by a when clauses.
-- when-others is considered, but the signal should never get there.
--
-- The logic statement is only a function of the present state.
-- Also the Z1 output is pre-assigned as the first step in the combinatorial
-- process
--
-------------------------------------------------------------------------------
--library declaration

library IEEE;
use IEEE.std_logic_ll64.all;

--entity

entity my_fsm1 is
    port ( TOG_EN  : in std_logic;
           CLK,CLR : in std_logic;
                Z1 : out std_logic);
end my_fsm1;

--architecture

architecture fsm1 of my_fsm1 is
    type state_type is (ST0, ST1);
    signal PS,NS : state_type;
begin
    sync_proc :process(CLK, NS, CLR)
    begin
        --observes the asynchronous input
        if (CLR = '1') then
            PS <= ST0;
        elsif (rising_edge(CLK)) then
            PS <= NS;
        end if;
    end process sync_proc;

    comb_proc: process(PS, TOG_EN)
    begin
        Z1 <= '0'          --pre-assigned output
        case PS is
            when ST0 =>    --items regarding state ST0
                Z1 <= '0'; --Moore output
                if(TOG_EN = '1') then NS <= ST1;
                else NS <= ST0;
                end if;
            when ST1 =>    --items regarding state ST1
                Z1 <= '1'; --Moore output
                if (TOG_EN = '1') then NS <= ST1;
                else NS <= ST1;
                end if;
            when others => --catch all condition BUT SHOULD NEVER GET HERE!
                Z1 <= '0'; --arbitrary
                NS <= ST0; --this too
        end case;
    end process comb_proc;
end fsm1;
--
