from ignis import widgets
from ignis.services.upower import UPowerService

upower = UPowerService.get_default()

def updateBatteryName(batteryIcon: widgets.Icon):
    names = ["battery-charging", "batteryfull","battery75","battery50","battery25","battery-empty"]
    percent = upower.batteries[0].percent
    name = names[0]
    if percent <= 10:
        name = names[-1]
    elif percent <= 25:
        name = names[-2]
    elif percent<= 50:
        name = names[-3]
    elif percent <= 75:
        name = names[-4]
    else:
        name = names[-5]
    if upower.batteries[0].charging:
        name = names[0]

    return name