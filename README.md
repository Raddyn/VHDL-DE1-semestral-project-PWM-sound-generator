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

 - 246958 - Radoslav Tomčala -> responsible for main design, frequency, duty calculation blocks, flowcharts, documentation,PWM proof of concept, rotary encoder and auxiliary hardware
 - 246955 - Jaroslav Švec -> responsible for 8x7seg display, counters, simulations
 - 246960 - Marek Vacula -> responsible for main design, top level, mode select, simulations, README+component documentation, GitHub implementation, contraints file
 - 253225 - Dominik Chalupka -> responsible for PWM, documentation 

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
 
## Features
- Switch input determines if frequency or duty cycle is to be altered through a mode selector block
- Frequency and duty cycle displayed on 7 segment disp.
- Current display position selected using buttons, flicker as indicator 
- Frequency or duty cycle selected using rotary encoder (or buttons) 

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

## Top level (Marek Vacula
- Purpose: connect and wire blocks together. Hardware/software interface.
- Component declaration and instantiation
- Variables are tied to contraints file

- Port map  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/feddb630-654f-4436-b7ec-6f8210da3b6f)
- Signal map:![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/d08f93c6-56fa-41bb-8bf9-794f39538621)
- Schematic
 ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/fb9ce06e-5a06-4dd7-b6e9-123c62d282d2)

## Frequency (Radoslav Tomčala)
- Controlling unit responsible for changing frequency and sending it for a further proccessing
- Frequency is changed by reciving a input signal from rotary encoder. Value change is dependent on which type of input is recived and the momentary cursor position. Frequency is outputed as a five 4-bit logic vectors, each representing a separate decade. Frequency value can be set in range from 20 to 20k Hz.
- Unit tracks the position of internal cursor which can change its value by pressing either left or right input.
This allows for either more coarse or finer frequency tuning. When the end is reached the cursor loops over.
- Port map:
- Schematic:
## Duty (Radoslav Tomčala)
  - Controlling unit responsible for changing duty value and sending it for a further proccessing
  - Works in a same way as frequency
  - Value can be set from 1 to 99
  - Port map:
  - Schematic:

## Mode selector (Marek Vacula)
- simple MUX to send a signal to current variable data to display
- Port map
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/094598d2-8d4e-4574-a0ab-4b12f7e95aa8)
- Schematic
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/bf4fb4ef-bbd3-49d9-b5f7-a5b14537c681)


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
### Clock Enable 
 - Porty
- clk	in	std_logic	Hlavní hodiny
- rst	in	std_logic	Hlavní reset
- pulse	out	std_logic	Impuls, s nastavitelnou periodou
- Schéma
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/8e2e25e3-0e80-45b9-b6eb-149f152b2ce3)
- Simulace
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/1bed116b-f8cd-4867-a06f-a2115e600b51)
### bin2seg
- Porty
- clear	in	std_logic	Vypne display
- bin	in	std_logic_vector(3 downto 0)	Zobrazovaný znak v bineární soustavě
- seg	out	std_logic_vector(6 downto 0)	Data jdoucí do displaye 7-segmentu
- Schema
- ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/1b6e2dd1-b156-4671-a6d0-5df6a1076842)
### counter
- Porty
- clk	in	std_logic	Hlavní hodiny
- rst	in	std_logic	Hlavní reset
- en	in 	std_logic	Cílené vypínání a zapínání counteru
- count 	in 	std_logic_vector(2 downto 0)	Bineární výstup, který počítá do zadané hodnoty
- schema
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/6ecef32f-84cc-4454-8c91-9cf7ec4f4010)
- simulace
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/7ff6c433-c3be-4788-9d1c-af132b7f249d)

## Top level (Marek Vacula
- Purpose: connect and wire blocks together. Hardware/software interface.
- Component declaration and instantiation
- Variables are tied to contraints file

- Port map  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/feddb630-654f-4436-b7ec-6f8210da3b6f)
- Signal map:![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/d08f93c6-56fa-41bb-8bf9-794f39538621)
- Schematic
 ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/fb9ce06e-5a06-4dd7-b6e9-123c62d282d2)

## Encoder (Radoslav Tomčala)
- Purpose: Add more tactile way to change frequency

   ![enc_hardw](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/124372068/1ce6ade4-f3d2-49b5-8559-934f3b667100)

## PWM Module (Dominik Chalupka)
### Simple PWM
- Ports
clk             in  std_logic                    Clock input
freq_in1        in  std_logic_vector(3 downto 0) Frequency - units
freq_in10       in  std_logic_vector(3 downto 0) Frequency - tens
freq_in100      in  std_logic_vector(3 downto 0) Frequency - hundreds
freq_in1000     in  std_logic_vector(3 downto 0) Frequency - thousands
freq_in10000    in  std_logic_vector(3 downto 0) Frequency - tens of thousands
duty_cycle1     in  std_logic_vector(3 downto 0) Duty - units
duty_cycle10    in  std_logic_vector(3 downto 0) Duty - tens
pwm_out         out std_logic                    Modulated signal output

- Scheme
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/154025342/8d1407c2-77c5-402c-8565-3d6e2a73f812)



- Simulation for 1kHz and 50% Duty cycle
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/154025342/b990bea6-499c-468c-9569-452268adc9d3)



- Simulation for 1kHz and 25% Duty cycle
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/154025342/b603ead6-7c73-410d-93dc-b2bee3e0db6e)



### Advanced
- Advanced PWM, that samples and respects the signal shape (triangle, sin)
- Issues with higher frequencies and synthesis prevented implementation

- Ports:
clk             in std_logic                Clock input
rst             in std_logic                Reset input   
freq_in1        in unsigned(3 downto 0)     Frequency - units
freq_in10       in unsigned(3 downto 0)     Frequency - tens
freq_in100      in unsigned(3 downto 0)     Frequency - hundreds
freq_in1000     in unsigned(3 downto 0)     Frequency - thousands
freq_in10000    in unsigned(3 downto 0)     Frequency - tens of thousands
pwm_out         out STD_LOGIC               Modulated signal output

-Scheme
(![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/154025342/f2c91e4f-8bb3-4244-a1c4-783126a33414)


-Simulation for 20kHz
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/154025342/3f5ba261-aaba-4225-aeb7-93ced3d2f7f6)


Simulation for 500 Hz
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/154025342/98d4c9ae-4aca-4acc-a87c-c918d102dfdb)



## Evaluation
- Each component works well on its own
- Top level seems to be wired well, yet...
- ...Implementation failed
- Display works, but does not switch position

## How to use

  1. Power-up Nexys A7 50-T board
  2. Select variable to modify through SW1. High -> duty cycle, Low-> frequency
  3. Using left and right buttons, select position/order to modify
  4. Tilt rotary encoder to increment or decrement value of chosen variable
  5. Use clear button to reset values
  6. Current variable and its value is displayed on 7segment displays
  7. Audio signal will be played through 3.5mm jack connector
