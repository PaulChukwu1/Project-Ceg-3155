LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux2to1_2bit IS
    PORT(
        sel     : IN  STD_LOGIC;                             -- Select input
        d_in1   : IN  STD_LOGIC_VECTOR(1 downto 0);        -- 8-bit Data input 1
        d_in2   : IN  STD_LOGIC_VECTOR(1 downto 0);        -- 8-bit Data input 2                         -- Reset input
        d_out   : OUT STD_LOGIC_VECTOR(1 downto 0)          -- 8-bit Data output
    );
END mux2to1_2bit;

ARCHITECTURE structural OF mux2to1_2bit IS

    SIGNAL not_sel : STD_LOGIC;                           -- Signal for inverted select line
    SIGNAL and1    : STD_LOGIC_VECTOR(1 downto 0);        -- Intermediate AND output for input 1
    SIGNAL and2    : STD_LOGIC_VECTOR(1 downto 0);        -- Intermediate AND output for input 2
    SIGNAL temp_out: STD_LOGIC_VECTOR(1 downto 0);        -- Temporary output

BEGIN
    not_sel <= NOT(sel);                                  -- Invert the select signal

    -- AND gates for each bit of d_in1
    and1(0) <= d_in1(0) AND not_sel;
    and1(1) <= d_in1(1) AND not_sel;

    -- AND gates for each bit of d_in2
    and2(0) <= d_in2(0) AND sel;
    and2(1) <= d_in2(1) AND sel;

    -- Final output OR gates
    temp_out(0) <= and1(0) OR and2(0);
    temp_out(1) <= and1(1) OR and2(1);

    d_out <= temp_out;

END structural;