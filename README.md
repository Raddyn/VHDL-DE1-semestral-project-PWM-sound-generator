# VHDL-DE1-semestral-project-PWM-sound-generator

## Team members
 - 246958 - Radoslav Tomčala -> responsible for main design, frequency, duty calculation blocks, flowcharts, documentation,PWM proof of concept, rotary encoder and auxiliary hardware
 - 246955 - Jaroslav Švec -> responsible for 8x7seg display, counters, simulations
 - 246960 - Marek Vacula -> responsible for main design, top level, mode select, simulations, README+component documentation, GitHub implementation, contraints file
 - 253225 - Dominik Chalupka -> responsible for PWM, documentation, description

## Theoretical description and explanation
In analogue domain, signal is continuous, in various shapes and amplitudes that are derived from the used circuit elements. In digital electronics, there are only discrete values, one single pin can only attain values one and zero. There is though still one remaining continuous element, time. In order to represent a continuous signal, such as a sin wave, we can do that through time. We can describe the trace by adjusting a high frequency square signal with the max being 1, 'enabled', and the min being 0, 'disabled'. By increasing and decreasing the duration, at which the value of the square signal is equal to 1. The longer the output is at one, the higher is the amplitude of the described analogue signal. If we do this for an entire sin period, we would see that around the minimum of the sinusoid the square pulses are very short, around the middle, the square signal is symetrical and around the maximum, the pulses are very long, almost a continuous line. This description of an analogue signal by a square signal and it's duty cycle is called a pulse width modulation, PWM. Since this signal is used to drive an electronic device, such as an LED, electric motor or an audio driver, all of those devices have inertia and transient events, which causes, that the device cannot react to the sudden changes of the square signal so quickly and thanks to these delays a continuous signal is basically "reconstructed" from the PWM signal. This method is very efficient and could be very precise.

  
## Links & References
- [PWM controller](https://vhdlwhiz.com/pwm-controller/)
- [Constraints file](https://raw.githubusercontent.com/Digilent/digilent-xdc/master/Nexys-A7-50T-Master.xdc)
- [Project assignment](https://github.com/tomas-fryza/vhdl-course/tree/master/lab8-project)
- [vhdl-course](https://github.com/tomas-fryza/vhdl-course/tree/master/solutions) 

 
## Features
- Switch input determines if frequency or duty cycle is to be altered through a mode selector block
- Frequency and duty cycle displayed on 7 segment disp.
- Current display position selected using buttons, flicker as indicator 
- Frequency or duty cycle selected using rotary encoder (or buttons) 

## Hardware

- [Nexys A7-50T](https://digilent.com/reference/programmable-logic/nexys-a7/start)
- [Rotary encoder](https://en.wikipedia.org/wiki/Rotary_encoder#:~:text=A%20rotary%20encoder%2C%20also%20called,analog%20or%20digital%20output%20signals.)

## Software
- [Visual Studio Code](https://code.visualstudio.com/)
- [Vivado](https://www.xilinx.com/support/download.html)
- [TerosHDL](https://terostechnology.github.io/terosHDLdoc/)
- [draw.io](https://app.diagrams.net/)
- [GitHub Copilot AI](https://github.com/features/copilot) 
## Software description

### Top level (Marek Vacula)
- Purpose: connect and wire blocks together. Hardware/software interface.
- Component declaration and instantiation
- Variables are tied to contraints file
- [Design source](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/blob/9881643e60a4f021ec1428981713540c23b01249/Design%20sources/top_level.vhd)


- Port map \
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/feddb630-654f-4436-b7ec-6f8210da3b6f)
- Signal map:\
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/d08f93c6-56fa-41bb-8bf9-794f39538621)
- Schematic\
 ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/fb9ce06e-5a06-4dd7-b6e9-123c62d282d2)

### Frequency (Radoslav Tomčala)
- Controlling unit responsible for changing frequency and sending it for a further proccessing
- Frequency is changed by reciving a input signal from rotary encoder. Value change is dependent on which type of input is recived and the momentary cursor position. Frequency is outputed as a five 4-bit logic vectors, each representing a separate decade. Frequency value can be set in range from 20 to 20k Hz.
- Unit tracks the position of internal cursor which can change its value by pressing either left or right input.
This allows for either more coarse or finer frequency tuning. When the end is reached the cursor loops over.
- [Design source](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/blob/main/Design%20sources/frequency.vhd)
  

- Port map:\
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/124372068/0d7bda4c-0345-4ff1-9e71-e07b12c745e4)
- clear	in	std_logic	Clear the display
- en	in	std_logic	Enable the display
- pos	out	std_logic_vector(4 downto 0)	Current working position
- left	in	std_logic	Move to the left
- right	in	std_logic	Move to the right
- increment	in	std_logic	Increment the frequency
- decrement	in	std_logic	Decrement the frequency
- out_1	out	std_logic_vector(3 downto 0)	Output for the next stage
- out_10	out	std_logic_vector(3 downto 0)	Output for the next stage
- out_100	out	std_logic_vector(3 downto 0)	Output for the next stage
- out_1000	out	std_logic_vector(3 downto 0)	Output for the next stage
- out_10000	out	std_logic_vector(3 downto 0)	Output for the next stage
- Schematic:\
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/124372068/c6c388d3-d51f-4f21-9376-2890f407faea)
- Simulation:\
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/124372068/7c67680b-23ec-4105-b334-af2a9b15f8d3)

### Duty (Radoslav Tomčala)
  - Controlling unit responsible for changing duty value and sending it for a further proccessing
  - Works in a same way as frequency
  - Value can be set from 1 to 99
  - [Design source](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/blob/48aa9f34e04b3aeb054bf05a7d9421874b69ed71/Design%20sources/duty.vhd)
   
  - Port map:
    ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/124372068/c1b192d6-a568-46bf-ae48-f46b663d9299)
- clear	in	std_logic	Clear the display
- en	in	std_logic	Enable the display
- pos_duty	out	std_logic_vector(4 downto 0)	Current working position
- left	in	std_logic	Move to the left
- right	in	std_logic	Move to the right
- increment	in	std_logic	Increment the duty
- decrement	in	std_logic	Decrement the duty
- out_1	out	std_logic_vector(3 downto 0)	Output for the next stage
- out_10	out	std_logic_vector(3 downto 0)	Output for the next stage
- Schematic:\
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/124372068/392b71a5-4ebb-4ae9-89a1-c3e7cd85bb08)
- Simulation:\
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/124372068/633da4d5-dabf-429b-b4dc-c982767bfff6)
 

### Mode selector (Marek Vacula)
- simple MUX to send a signal to current variable data to display
- [Design source](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/blob/48aa9f34e04b3aeb054bf05a7d9421874b69ed71/Design%20sources/mode_selector.vhd)
  
- Port map\
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/094598d2-8d4e-4574-a0ab-4b12f7e95aa8)
- Schematic\
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/bf4fb4ef-bbd3-49d9-b5f7-a5b14537c681)


### x7seg (Jaroslav Švec)

- [Design source](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/blob/48aa9f34e04b3aeb054bf05a7d9421874b69ed71/Design%20sources/x7seg.vhd)
 - Ports
  - clk	in	std_logic Main clock
  - rst	in	std_logic Main reset
  - out_1	in	std_logic_vector(3 downto 0)	Selected frequency - units
  - out_10	in	std_logic_vector(3 downto 0)	Selected frequency - tens
  - out_100	in	std_logic_vector(3 downto 0)	Selected frequency - hundreds
  - out_1000	in	std_logic_vector(3 downto 0)	Selected frequency - thousands
  - out_10000	in	std_logic_vector(3 downto 0)	Selected frequency - tens of thousands
  - out_1_duty	in	std_logic_vector(3 downto 0)	Selected duty cycle - units
  - out_10_duty	in	std_logic_vector(3 downto 0)	Selected duty cycle - tens
  - sw	in	std_logic	switching between frequency mode and duty cycle mode
  - position_in	in	std_logic_vector(4 downto 0)	Switching between number positions
  - pos_mulx_freq	out	std_logic_vector(7 downto 0)	Vector controling a common electrode of the display
  - seg	out	std_logic_vector(6 downto 0)	Data flow for 7 segment display

 - Schematic\
   ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/84c0b52f-4fb4-496d-be87-8665ddf796b3)
 - Simulation\
   ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/d9bfdbc6-fca3-42ff-8fd4-495630150823)
    Indication of changed value at level of tens, then hundreds\
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/b8d8a40f-9c82-4ce7-8b86-02955e60f2d2)
Mode change (data showing on 2 positions instead of 5)\
 ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/5a52632d-f5e8-4c35-8e87-071d73644559)
Comparison of clock with the display refresh rate 
(period differs from reality due to the difficulty of simulation)

### Clock Enable 
- [Design source](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/blob/48aa9f34e04b3aeb054bf05a7d9421874b69ed71/Design%20sources/clock_enable.vhd)
 - Ports
- clk	in	std_logic	Main clock
- rst	in	std_logic	Main reset
- pulse	out	std_logic	Pulse with adjustable period
- Schematic\
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/8e2e25e3-0e80-45b9-b6eb-149f152b2ce3)
- Simulation\
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/1bed116b-f8cd-4867-a06f-a2115e600b51)

### bin2seg
- [Design source](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/blob/48aa9f34e04b3aeb054bf05a7d9421874b69ed71/Design%20sources/bin2seg.vhd)
- Ports
- clear	in	std_logic	Turns off display
- bin	in	std_logic_vector(3 downto 0)	Displayed character in binary
- seg	out	std_logic_vector(6 downto 0)	Data flow to 7 segment display
- Schematic\
- ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/1b6e2dd1-b156-4671-a6d0-5df6a1076842)

### counter
- [Design source](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/blob/48aa9f34e04b3aeb054bf05a7d9421874b69ed71/Design%20sources/counter.vhd)
- Ports
- clk	in	std_logic	Main clock
- rst	in	std_logic	Main reset
- en	in 	std_logic	enables and disables counter on demand
- count 	in 	std_logic_vector(2 downto 0)	Binary output counting selected values
- Schematic\
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/6ecef32f-84cc-4454-8c91-9cf7ec4f4010)
- simulation\
  ![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/80957105/7ff6c433-c3be-4788-9d1c-af132b7f249d)

### Encoder (Radoslav Tomčala)
- Purpose: Add more tactile way to change frequency
- [Design source](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/blob/48aa9f34e04b3aeb054bf05a7d9421874b69ed71/Design%20sources/encoder.vhd)
- Circuit:\
![enc_hardw](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/124372068/1ce6ade4-f3d2-49b5-8559-934f3b667100)
- Simulation 
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/124372068/c74828cd-9dfe-44a9-8bd6-451f306b50f4)
- Schematic\
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/124372068/61b03e8e-379b-4c77-beaa-d27c064ea69f)


### PWM Module (Dominik Chalupka and Radoslav Tomčala)
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

[Design source](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/blob/250f665e0e72adb011da8e0b643ef4e261352ef9/Design%20sources/pwm_module.vhd)

- Schematic
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/154025342/8d1407c2-77c5-402c-8565-3d6e2a73f812)



- Simulation for 1kHz and 50% Duty cycle
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/154025342/b990bea6-499c-468c-9569-452268adc9d3)



- Simulation for 1kHz and 25% Duty cycle
![image](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/154025342/b603ead6-7c73-410d-93dc-b2bee3e0db6e)



### Advanced PWM
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


[Design source](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/blob/be501989562627cded8fc61b43f4cc9f1e11ddce/Design%20sources/pwmV2.vhd)

- Schematic
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
  2. Select variable to modify through Switch 1 (SW1). Up (HIGH) -> duty cycle, Down(LOW)-> frequency
  3. Using left and right buttons, select number position/order to modify
  4. Turn rotary encoder to increment or decrement value of chosen variable
  5. Use clear button to reset values
  6. Current variable, frequency or duty cycle, and its value is displayed on 7segment displays
  7. Audio signal will be played through 3.5mm jack connector
