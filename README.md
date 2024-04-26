## Configuration

1. Choose a Marlin version and put it inside the `MARLIN_VERSION` environment variable in `Dockerfile`

2. Take config files from [MarlinFirmware/Configurations](https://github.com/MarlinFirmware/Configurations) as reference and drop them inside `config`, double check you're taking those files from a git branch or tag that matches `MARLIN_VERSION`
   e.g.: https://github.com/MarlinFirmware/Configurations/tree/2.1.2.2

3. Check which `MOTHERBOARD` is used inside your `Configuration.h`
   e.g.: https://github.com/MarlinFirmware/Marlin/blob/2.1.2.2/Marlin/Configuration.h#L91

4. Look for that value inside `pins.h` and find for something like `env:mega2560`
   e.g.: https://github.com/MarlinFirmware/Marlin/blob/2.1.2.2/Marlin/src/pins/pins.h#L84

5. Put that value inside the [build](https://github.com/emilianobovetti/MarlinBuilder/blob/c672c46d1545e8a617c77f99525e5b46d62923cd/build#L20) script
   e.g.: `mega2560`

---

As a starting point I'm using [Creality/Ender-3/BigTreeTech SKR Mini E3 3.0](https://github.com/MarlinFirmware/Configurations/tree/2.1.2.2/config/examples/Creality/Ender-3/BigTreeTech%20SKR%20Mini%20E3%203.0) with the following parameters changed:

```
ref: https://github.com/MarlinFirmware/Configurations/blob/2.1.2.2/config/examples/Creality/Ender-3/BigTreeTech%20SKR%20Mini%20E3%203.0/Configuration.h

#define BED_TRAMMING_HEIGHT      0.2
#define DEFAULT_bedKd 448.3
#define DEFAULT_bedKi  21.4
#define DEFAULT_bedKp 120.1

#define PID_AUTOTUNE_MENU     // enabled
#define PID_EDIT_MENU         // enabled

#define PREHEAT_1_TEMP_BED     60
#define PREHEAT_1_TEMP_HOTEND 190

#define Z_MAX_POS 230

ref: https://github.com/MarlinFirmware/Configurations/blob/2.1.2.2/config/examples/Creality/Ender-3/BigTreeTech%20SKR%20Mini%20E3%203.0/Configuration_adv.h

#define LCD_PROGRESS_BAR      // enabled
#define SHOW_REMAINING_TIME   // enabled
#define SOUND_MENU_ITEM       // enabled
```

I've upgraded my Ender-3 with the Sprite Extruder Pro,
for this reason the following values were copied from
Ender-3 S1 configuration

```
ref: https://github.com/MarlinFirmware/Configurations/blob/2.1.2.2/config/examples/Creality/Ender-3%20S1/STM32F4/Configuration.h


#define DEFAULT_AXIS_STEPS_PER_UNIT   { 80, 80, 400, 424.9 }
#define DEFAULT_Kd  54.63
#define DEFAULT_Ki   1.69
#define DEFAULT_Kp  19.54
#define DEFAULT_MAX_ACCELERATION      { 1000, 1000, 100, 2500 }
#define DEFAULT_MAX_FEEDRATE          { 200, 200, 5, 50 }
#define EXTRUDE_MAXLENGTH 1000

ref: https://github.com/MarlinFirmware/Configurations/blob/2.1.2.2/config/examples/Creality/Ender-3%20S1/STM32F4/Configuration_adv.h

#define FILAMENT_CHANGE_FAST_LOAD_LENGTH     0
#define FILAMENT_CHANGE_UNLOAD_LENGTH      100
```
