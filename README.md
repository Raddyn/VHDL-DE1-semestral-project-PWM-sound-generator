![frequency](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/124372068/b83fe463-1594-48d5-aae1-d3875e84cce6)# VHDL-DE1-semestral-project-PWM-sound-generator
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
![Uploading fr<svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs" viewBox="0 0 735 150"><svg id="SvgjsSvg1002" width="2" height="0" focusable="false" style="overflow:hidden;top:-100%;left:-100%;position:absolute;opacity:0"><polyline id="SvgjsPolyline1003" points="135,0 150,0"></polyline><path id="SvgjsPath1004" d="M0 0 "></path></svg><rect id="SvgjsRect1006" width="260" height="130" fill="black" x="150" y="15"></rect><rect id="SvgjsRect1007" width="256" height="125" fill="#fdfd96" x="152" y="17"></rect><text id="SvgjsText1008" font-family="Helvetica" x="130" y="9.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1009" dy="26" x="130" svgjs:data="{&quot;newLined&quot;:true}">   std_logic </tspan></text><text id="SvgjsText1010" font-family="Helvetica" x="165" y="9.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1011" dy="26" x="165" svgjs:data="{&quot;newLined&quot;:true}">   clear </tspan></text><line id="SvgjsLine1012" x1="135" y1="30" x2="150" y2="30" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1013" font-family="Helvetica" x="130" y="29.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1014" dy="26" x="130" svgjs:data="{&quot;newLined&quot;:true}">   std_logic </tspan></text><text id="SvgjsText1015" font-family="Helvetica" x="165" y="29.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1016" dy="26" x="165" svgjs:data="{&quot;newLined&quot;:true}">   en </tspan></text><line id="SvgjsLine1017" x1="135" y1="50" x2="150" y2="50" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1018" font-family="Helvetica" x="130" y="49.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1019" dy="26" x="130" svgjs:data="{&quot;newLined&quot;:true}">   std_logic </tspan></text><text id="SvgjsText1020" font-family="Helvetica" x="165" y="49.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1021" dy="26" x="165" svgjs:data="{&quot;newLined&quot;:true}">   left </tspan></text><line id="SvgjsLine1022" x1="135" y1="70" x2="150" y2="70" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1023" font-family="Helvetica" x="130" y="69.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1024" dy="26" x="130" svgjs:data="{&quot;newLined&quot;:true}">   std_logic </tspan></text><text id="SvgjsText1025" font-family="Helvetica" x="165" y="69.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1026" dy="26" x="165" svgjs:data="{&quot;newLined&quot;:true}">   right </tspan></text><line id="SvgjsLine1027" x1="135" y1="90" x2="150" y2="90" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1028" font-family="Helvetica" x="130" y="89.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1029" dy="26" x="130" svgjs:data="{&quot;newLined&quot;:true}">   std_logic </tspan></text><text id="SvgjsText1030" font-family="Helvetica" x="165" y="89.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1031" dy="26" x="165" svgjs:data="{&quot;newLined&quot;:true}">   increment </tspan></text><line id="SvgjsLine1032" x1="135" y1="110" x2="150" y2="110" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1033" font-family="Helvetica" x="130" y="109.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1034" dy="26" x="130" svgjs:data="{&quot;newLined&quot;:true}">   std_logic </tspan></text><text id="SvgjsText1035" font-family="Helvetica" x="165" y="109.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1036" dy="26" x="165" svgjs:data="{&quot;newLined&quot;:true}">   decrement </tspan></text><line id="SvgjsLine1037" x1="135" y1="130" x2="150" y2="130" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1038" font-family="Helvetica" x="430" y="9.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1039" dy="26" x="430" svgjs:data="{&quot;newLined&quot;:true}">   std_logic_vector(4 downto 0) </tspan></text><text id="SvgjsText1040" font-family="Helvetica" x="395" y="9.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1041" dy="26" x="395" svgjs:data="{&quot;newLined&quot;:true}">   pos </tspan></text><line id="SvgjsLine1042" x1="410" y1="30" x2="425" y2="30" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1043" font-family="Helvetica" x="430" y="29.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1044" dy="26" x="430" svgjs:data="{&quot;newLined&quot;:true}">   std_logic_vector(3 downto 0) </tspan></text><text id="SvgjsText1045" font-family="Helvetica" x="395" y="29.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1046" dy="26" x="395" svgjs:data="{&quot;newLined&quot;:true}">   out_1 </tspan></text><line id="SvgjsLine1047" x1="410" y1="50" x2="425" y2="50" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1048" font-family="Helvetica" x="430" y="49.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1049" dy="26" x="430" svgjs:data="{&quot;newLined&quot;:true}">   std_logic_vector(3 downto 0) </tspan></text><text id="SvgjsText1050" font-family="Helvetica" x="395" y="49.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1051" dy="26" x="395" svgjs:data="{&quot;newLined&quot;:true}">   out_10 </tspan></text><line id="SvgjsLine1052" x1="410" y1="70" x2="425" y2="70" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1053" font-family="Helvetica" x="430" y="69.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1054" dy="26" x="430" svgjs:data="{&quot;newLined&quot;:true}">   std_logic_vector(3 downto 0) </tspan></text><text id="SvgjsText1055" font-family="Helvetica" x="395" y="69.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1056" dy="26" x="395" svgjs:data="{&quot;newLined&quot;:true}">   out_100 </tspan></text><line id="SvgjsLine1057" x1="410" y1="90" x2="425" y2="90" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1058" font-family="Helvetica" x="430" y="89.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1059" dy="26" x="430" svgjs:data="{&quot;newLined&quot;:true}">   std_logic_vector(3 downto 0) </tspan></text><text id="SvgjsText1060" font-family="Helvetica" x="395" y="89.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1061" dy="26" x="395" svgjs:data="{&quot;newLined&quot;:true}">   out_1000 </tspan></text><line id="SvgjsLine1062" x1="410" y1="110" x2="425" y2="110" stroke-linecap="rec" stroke="black" stroke-width="5"></line><text id="SvgjsText1063" font-family="Helvetica" x="430" y="109.3015625" font-size="20" text-anchor="start" family="Helvetica" size="20" anchor="start" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1064" dy="26" x="430" svgjs:data="{&quot;newLined&quot;:true}">   std_logic_vector(3 downto 0) </tspan></text><text id="SvgjsText1065" font-family="Helvetica" x="395" y="109.3015625" font-size="20" text-anchor="end" family="Helvetica" size="20" anchor="end" svgjs:data="{&quot;leading&quot;:&quot;1.3&quot;}"><tspan id="SvgjsTspan1066" dy="26" x="395" svgjs:data="{&quot;newLined&quot;:true}">   out_10000 </tspan></text><line id="SvgjsLine1067" x1="410" y1="130" x2="425" y2="130" stroke-linecap="rec" stroke="black" stroke-width="5"></line></svg>equency.svg…]()

-clear	in	std_logic	Clear the display
-en	in	std_logic	Enable the display
-pos	out	std_logic_vector(4 downto 0)	Current working position
-left	in	std_logic	Move to the left
-right	in	std_logic	Move to the right
-increment	in	std_logic	Increment the frequency
-decrement	in	std_logic	Decrement the frequency
-out_1	out	std_logic_vector(3 downto 0)	Output for the next stage
-out_10	out	std_logic_vector(3 downto 0)	Output for the next stage
-out_100	out	std_logic_vector(3 downto 0)	Output for the next stage
-out_1000	out	std_logic_vector(3 downto 0)	Output for the next stage
-out_10000	out	std_logic_vector(3 downto 0)	Output for the next stage
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
- clk             in  std_logic                    Clock input
- freq_in1        in  std_logic_vector(3 downto 0) Frequency - units
- freq_in10       in  std_logic_vector(3 downto 0) Frequency - tens
- freq_in100      in  std_logic_vector(3 downto 0) Frequency - hundreds
- freq_in1000     in  std_logic_vector(3 downto 0) Frequency - thousands
- freq_in10000    in  std_logic_vector(3 downto 0) Frequency - tens of thousands
- duty_cycle1     in  std_logic_vector(3 downto 0) Duty - units
- duty_cycle10    in  std_logic_vector(3 downto 0) Duty - tens
- pwm_out         out std_logic                    Modulated signal output

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
- clk             in std_logic                Clock input
- rst             in std_logic                Reset input   
- freq_in1        in unsigned(3 downto 0)     Frequency - units
- freq_in10       in unsigned(3 downto 0)     Frequency - tens
- freq_in100      in unsigned(3 downto 0)     Frequency - hundreds
- freq_in1000     in unsigned(3 downto 0)     Frequency - thousands
- freq_in10000    in unsigned(3 downto 0)     Frequency - tens of thousands
- pwm_out         out STD_LOGIC               Modulated signal output

- Scheme
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/154025342/f2c91e4f-8bb3-4244-a1c4-783126a33414)


- Simulation for 20 kHz
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/154025342/3f5ba261-aaba-4225-aeb7-93ced3d2f7f6)


- Simulation for 500 Hz
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
