from ignis import widgets, utils    
from ignis.services.niri import * 
import os
from ignis.app import IgnisApp
from ignis.css_manager import CssInfoPath, CssManager
from ignis.icon_manager import IconManager

import datetime
from src.bar import bar

css_manager = CssManager.get_default()
icon_manager = IconManager.get_default()
icon_manager.add_icons(os.path.join(utils.get_current_dir(), "icons"))
css_manager.apply_css(
    CssInfoPath(
        name="main",
        path=os.path.join(utils.get_current_dir(), "style.scss"),
    )
)

bar()




