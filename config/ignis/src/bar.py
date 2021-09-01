from ignis import widgets, utils    
from ignis.services.niri import NiriService, NiriWorkspace
from ignis.services.upower import UPowerDevice, UPowerService
import datetime
from src.calendarWindow import calendar
from src.controlCenter import controlCenter
from src.utils import updateBatteryName


class bar():
    def __init__(self):
        widgets.Window(
            namespace="vertical-bar",
            anchor=["top", "right", "bottom"],
            margin_top=5,
            margin_left=10,# margin_top - with
            margin_right=0,
            margin_bottom=5,
            style="border-radius:1.7rem; padding:0.4rem 0.4rem 0.4rem 0.4rem; margin:0.5rem 0.25rem 0.5rem 0rem;",
            child= widgets.CenterBox(
                css_classes=["bar"],
                vertical=True,
                center_widget=MenuButton(),
                start_widget=Workspaces(),
                end_widget=TimeButton(),
        )
    )

class WorkspaceButton(widgets.Button):
    def __init__(self, workspace: NiriWorkspace) -> None:
        super().__init__(
            css_classes=["workspace", "unset", "workspaceButton"],
            on_click=lambda x: workspace.switch_to(),
            child = widgets.Icon(
            image="empty",
            pixel_size = 25, 
            ),
            halign="fill",
            hexpand = True,
            valign="center",
        )

        if workspace.is_active:
            self.add_css_class("active")


class MenuButton(widgets.Button):
    controlCenter = controlCenter()


    def update(self, batteryIcon):
        batteryIcon.image = updateBatteryName(batteryIcon)
    def __init__(self):
        batteryIcon = widgets.Icon(pixel_size=25)
        utils.Poll(1000, lambda x: self.update(batteryIcon))

        super().__init__(
                css_classes=["menuButton"],
                child=widgets.CenterBox(
                    vertical = True,
                    start_widget=widgets.Icon(
                        image= "music",
                        pixel_size=25,
                    ),
                    end_widget=batteryIcon,
                    center_widget=widgets.Icon(
                        image="brightness",
                        pixel_size=25,
                    )
                ),
                on_click=lambda self: self.controlCenter.show(),
            )

class TimeButton(widgets.Button):
    calendar = calendar()
    
    def updateTime(self, label: widgets.label):
        text = datetime.datetime.now().strftime("%H\n%M")
        label.set_label(text)

    def __init__(self, children = None):
        label = widgets.Label()
        utils.Poll(1000, lambda x: self.updateTime(label))
        
        super().__init__(
            css_classes=["time"],
            child=label,
            on_click=lambda self: self.calendar.show(),
        )

class Workspaces(widgets.Box):
    def selectList(self, workspaces):
        size = 5

        if len(workspaces) > size*2:
            activeIndex = 7
            for index, item in enumerate(workspaces):
                if item.is_active:
                    activeIndex = index

            leftSelection = 0
            rightSelection = 1
            if len(workspaces) - activeIndex < size:
                rightSelection = len(workspaces)
                leftSelection = max(0,rightSelection -(size*2))

            elif activeIndex < size:
                rightSelection = min(len(workspaces), activeIndex + (size - activeIndex + size))
                leftSelection = 0
            else:
                rightSelection = activeIndex + size
                leftSelection = activeIndex  - size 
            return workspaces[leftSelection:rightSelection]
        else:
            return workspaces

    def __init__(self):
        niri = NiriService.get_default()
        if NiriService.is_available:
            super().__init__(
                    css_classes=["workspaces"],
                    vertical = True,
                    hexpand = True,
                    child=niri.bind_many(
                        ["workspaces"],
                        transform=lambda workspaces, *_: [
                            WorkspaceButton(i) for i in self.selectList(workspaces)
                        ],
                    ),
                )
 
