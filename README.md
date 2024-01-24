## Configuration

1. Choose a Marlin version and put it inside the `MARLIN_VERSION` environment variable in `Dockerfile`

2. Take config files from [MarlinFirmware/Configurations](https://github.com/MarlinFirmware/Configurations) as reference and drop them inside `config`, double check you're taking those files from a git branch or tag that matches `MARLIN_VERSION`
   e.g.: https://github.com/MarlinFirmware/Configurations/tree/2.1.2.1

3. Check which `MOTHERBOARD` is used inside your `Configuration.h`
   e.g.: https://github.com/MarlinFirmware/Marlin/blob/2.1.2.1/Marlin/Configuration.h#L90

4. Look for that value inside `pins.h` and find for something like `env:mega2560`
   e.g.: https://github.com/MarlinFirmware/Marlin/blob/2.1.2.1/Marlin/src/pins/pins.h#L84

5. Put that value inside the [build](https://github.com/emilianobovetti/MarlinBuilder/blob/c672c46d1545e8a617c77f99525e5b46d62923cd/build#L20) script
   e.g.: `mega2560`

---

I've upgraded my Ender-3 with the Sprite Extruder Pro,
for this reason the following values were copied from
Ender-3 S1 configuration

```
ref: https://github.com/MarlinFirmware/Configurations/blob/2.1.2.1/config/examples/Creality/Ender-3/BigTreeTech%20SKR%20Mini%20E3%203.0/Configuration.h
ref: https://github.com/MarlinFirmware/Configurations/blob/2.1.2.1/config/examples/Creality/Ender-3%20S1/STM32F4/Configuration.h

DEFAULT_AXIS_STEPS_PER_UNIT (430 -> 424.9)
DEFAULT_Kd
DEFAULT_Ki
DEFAULT_Kp
DEFAULT_MAX_ACCELERATION
DEFAULT_MAX_FEEDRATE
EXTRUDE_MAXLENGTH
FILAMENT_CHANGE_UNLOAD_LENGTH
FILAMENT_CHANGE_FAST_LOAD_LENGTH
```
