# VHDL-DE1-semestral-project-PWM-sound-generator
## TO-DO:

- Find sources, test function of PWM module -> DOMINIK
- Test audio jack out -> DOMINIK
- configure constraints file -> MAREK
- IMPORTANT! - Delegation of further tasks
- Rotary encoder -> ?
- Configuration of 7seg.vhd, mainly position of each display -> JARA
- Rough sketch of hardware, algorithm flowchart, top_level -> RADEK, MAREK
- Documentation -> MAREK, RADEK
- TO-DO management -> MAREK
- schematics -> RADEK
- clock -> MAREK


## File responsibility:
- top_level.vhd -> MAREK, RADEK
- frequency.vhd -> RADEK
- mode_selector.vhd -> MAREK
- x7seg.vhd -> JARA
- top_x7seg.vhd -> JARA
- pwm_controller.vhd -> DOMINIK
- jack.vhd -> DOMINIK
- nexys-a7-50t.xdc -> MAREK
- clock.vhd -> MAREK

## Links
- [PWM controller](https://vhdlwhiz.com/pwm-controller/)
- [Constraints file](https://raw.githubusercontent.com/Digilent/digilent-xdc/master/Nexys-A7-50T-Master.xdc)
- [Project assignment](https://github.com/tomas-fryza/vhdl-course/tree/master/lab8-project)
- [Rotary encoder](https://github.com/Yourigh/Rotary-encoder-VHDL-design)
## Team members

246958 - Radoslav Tomčala -> responsible for ()\
246955 - Jaroslav Švec -> responsible for ()\
246960 - Marek Vacula -> responsible for ()\
253225 - Dominik Chalupka -> responsible for ()
## Description

- To be added
## Features
- Switch input determines if frequency or duty cycle is to be altered
- Frequency or (and?) duty cycle displayed on 7 segment disp.
- Current display position selected using buttons, flicker as indicator 
- Frequency or duty cycle selected using rotary encoder (or buttons?) 
- (optional QoL) LEDs indicate current frequency at all times
## Hardware

- [Nexys A7-50T](https://digilent.com/reference/programmable-logic/nexys-a7/start)
- [Rotary encoder]()
- Initial CRUDE sketch
- ![IMG_1153](https://github.com/Raddyn/VHDL-DE1-semestral-project-PWM-sound-generator/assets/124372068/395b58a0-7fdd-476a-a2ee-0f101e7057f6)

## Software

- To be added
## How to use

- to be added
## References
- [PWM Controller](https://vhdlwhiz.com/pwm-controller/)
- 
