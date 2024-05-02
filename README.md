# VHDL-DE1-semestral-project-PWM-sound-generator
## TO-DO (deprecated)
- Find sources, test function of PWM module -> DOMINIK
- configure constraints file -> MAREK
- Rotary encoder -> RADEK
- Configuration of 7seg.vhd, mainly position of each display -> JARA
- Rough sketch of hardware, algorithm flowchart, top_level -> RADEK, MAREK
- Documentation -> MAREK, RADEK
- TO-DO management -> MAREK
- schematics -> RADEK
- clock -> MAREK
- mode selector -> MAREK

## Team members

 - 246958 - Radoslav Tomčala -> responsible for frequency, duty calculation blocks, flowcharts, documentation
 - 246955 - Jaroslav Švec -> responsible for 8x7seg display, counters, simulations
 - 246960 - Marek Vacula -> responsible for top level, simulations, README documentation, GitHub implementation, contraints file
 - 253225 - Dominik Chalupka -> responsible for PWM, documentation of components

## File responsibility:
- top_level.vhd -> MAREK
- frequency.vhd -> RADEK
- duty.vhd -> RADEK
- mode_selector.vhd -> MAREK
- x7seg.vhd -> JARA
- pwm_controller.vhd -> DOMINIK, RADEK
- nexys-a7-50t.xdc -> MAREK
- clock.vhd -> MAREK

## Links & References
- [PWM controller](https://vhdlwhiz.com/pwm-controller/)
- [Constraints file](https://raw.githubusercontent.com/Digilent/digilent-xdc/master/Nexys-A7-50T-Master.xdc)
- [Project assignment](https://github.com/tomas-fryza/vhdl-course/tree/master/lab8-project)
- [Rotary encoder](https://github.com/Yourigh/Rotary-encoder-VHDL-design)
 
## Features
- Switch input determines if frequency or duty cycle is to be altered through a mode selector block
- Frequency and duty cycle displayed on 7 segment disp.
- Current display position selected using buttons, flicker as indicator 
- Frequency or duty cycle selected using rotary encoder (or buttons) 
- (optional QoL) LEDs indicate current frequency at all times

- signal generation formula: n_clk = freq_clock/(bit_sound_sig*freq_sound)
-- freq_sound ... frequency of the wanted sound
-- bit_sound_sig ... bit depth of the counter creating the sound signal
-- freq_clock ... frequency of the used clock
-- n_clk ... number of counted clock period 
## Hardware

- [Nexys A7-50T](https://digilent.com/reference/programmable-logic/nexys-a7/start)
- [Rotary encoder](https://en.wikipedia.org/wiki/Rotary_encoder#:~:text=A%20rotary%20encoder%2C%20also%20called,analog%20or%20digital%20output%20signals.)

## Software
- Algorithm flowchart WIP (RADEK)
- [Vivado](https://www.xilinx.com/support/download.html)
- [draw.io](https://app.diagrams.net/)

## x7seg (Jaroslav Švec)
 - Porty
 - clk	in	std_logic	Hlavní hodiny 
 - rst	in	std_logic	Hlavní reset
 - out_1	in	std_logic_vector(3 downto 0)	Data pro jednoty
 - out_10	in	std_logic_vector(3 downto 0)	Data pro desítky
 - out_100	in	std_logic_vector(3 downto 0)	Data pro stovky 
 - out_1000	in	std_logic_vector(3 downto 0)	Data pro tisíce
 -out_10000	in	std_logic_vector(3 downto 0)	Data pro desetitisíce
 - out_1_duty	in	std_logic_vector(3 downto 0)	Data pro jednotky duty cyclu
 - out_10_duty	in	std_logic_vector(3 downto 0)	Data pro desítky duty cyclu
 -sw	in	std_logic	nastavování frekvence nebo duty cyclu
 - position_in	in	std_logic_vector(4 downto 0)	Určování která pozice bude měnit hodnotu
 - pos_mulx_freq	out	std_logic_vector(7 downto 0	Vektor pro ovládání společné elektrody displaye
 - seg	out	std_logic_vector(6 downto 0)	Data jdoucí do displaye 7-segmentu

 - Schéma
   ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/84c0b52f-4fb4-496d-be87-8665ddf796b3)
 - Simulace
   ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/d9bfdbc6-fca3-42ff-8fd4-495630150823)
    Indikace měněné pozice na jednotkách, následně stovkách
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/b8d8a40f-9c82-4ce7-8b86-02955e60f2d2)
Změna módu (zobrazování dat pouze na 2 pozicích)
 ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/5a52632d-f5e8-4c35-8e87-071d73644559)
Porovnání hodinového signálu s obnovovací frekvencí jednotlivých 7-segmentů 
(jiná perioda než v realitě z důvodu náročných simulací)

## Top level (Marek Vacula
- Purpose: connect and wire blocks together. Hardware/software interface.
- Component declaration and instantiation
- Variables are tied to contraints file
- Signal map:![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/d08f93c6-56fa-41bb-8bf9-794f39538621)
- Port map
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/feddb630-654f-4436-b7ec-6f8210da3b6f)
- Schematic
 ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/fb9ce06e-5a06-4dd7-b6e9-123c62d282d2)
   



## How to use

  1. Power-up Nexys A7 50-T board
  2. Select variable to modify through SW1. High -> duty cycle, Low-> frequency
  3. Using left and right buttons, select position/order to modify
  4. Tilt rotary encoder to increment or decrement value of chosen variable
  5. Use clear button to reset values
  6. 
