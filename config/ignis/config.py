from ignis import widgets, utils    
from ignis.services.niri import * 
import os
from ignis.app import IgnisApp
from ignis.css_manager import CssInfoPath, CssManager
from ignis.icon_manager import IconManager

import datetime

css_manager = CssManager.get_default()
icon_manager = IconManager.get_default()
icon_manager.add_icons("/home/mees/.config/ignis/icons")#os.path.join(utils.get_current_dir(), "icons"))
css_manager.apply_css(
    CssInfoPath(
        name="main",
        path=os.path.join(utils.get_current_dir(), "style.scss"),
    )
)

class WorkspaceButton(widgets.Button):
    def __init__(self, workspace: NiriWorkspace) -> None:
        super().__init__(
            css_classes=["workspace", "unset"],
            on_click=lambda x: workspace.switch_to(),
            child = widgets.Icon(
            image="empty",
            pixel_size = 25, 
                ),
            halign="start",
            valign="center",
        )
        if workspace.is_active:
            self.add_css_class("active")

class MenuButton(widgets.Button):
    def updateBatteryIcon(self, batteryIcon: widgets.Icon):
        names = ["battery-full","battery75","battery50","battery25","battery-empty","battery-charging"]
        batteryIcon.image = names[1]  
    def __init__(self):

        batteryIcon = widgets.Icon(pixel_size=25)
        utils.Poll(10000, lambda x: self.updateBatteryIcon(batteryIcon))
        

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
                on_click=lambda self: print("test"),
                
                )

class TimeButton(widgets.Button):
    def updateTime(self, label: widgets.label):
        text = datetime.datetime.now().strftime("%H\n%M")
        label.set_label(text)

    def __init__(self, children = None):

        label = widgets.Label()
        utils.Poll(1000, lambda x: self.updateTime(label))
        
        super().__init__(
            css_classes=["time"],
            child=label,
            on_click=lambda self: print("clicked time"),
        )

class Workspaces(widgets.Box):
    def selectList(self, workspaces):

        size = 6
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
                    child=niri.bind_many(
                        ["workspaces"],
                        transform=lambda workspaces, *_: [
                            WorkspaceButton(i) for i in self.selectList(workspaces)
                        ],
                    ),
                )
        

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
            #child = [Workspaces(), TimeButton()]
        )
)

