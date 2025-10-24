from ignis import widgets, utils
from ignis.services.mpris import MprisService
from ignis.services.network import NetworkService
from ignis.services.bluetooth import BluetoothService
from ignis.services.audio import AudioService
from ignis.services.backlight import BacklightService

backlight = BacklightService.get_default()
mpris = MprisService.get_default()
network = NetworkService.get_default()
bluetoothService = BluetoothService.get_default()
audio = AudioService.get_default()
class powermenu(widgets.CenterBox):
    def __init__(self):
        super().__init__(
            css_classes = ["powermenu"],
            vertical = True,
            center_widget=widgets.Box(vertical = True,spacing=10,child = [
                widgets.Box(
                    spacing = 10,
                    child=[
                    widgets.Button(
                        child=widgets.Icon(pixel_size=60, image="system-shut" ),
                        on_click = lambda x : utils.exec_sh("shutdown now")
                    ),
                    widgets.Button(
                        child=widgets.Icon(pixel_size=30, image="system-restart" ),
                        on_click = lambda x : utils.exec_sh("shutdown -r now")
                    )
                ]),
                widgets.Box(
                    spacing = 10,
                    child=[
                    widgets.Button(
                        child=widgets.Icon(pixel_size=30, image="log-out" ),
                        on_click = lambda x : utils.exec_sh("niri msg action quit -s")
                    ),
                    widgets.Button(
                        child=widgets.Icon(pixel_size=60, image = "lock-square"),
                        on_click = lambda x: utils.exec_sh("hyprlock")
                    )
                ])
            ])
        )

class sliders(widgets.Button):
    def brightnessSlider(self):
        return widgets.Box(
                vertical= True, 
                spacing = 10,
                css_classes = ["slider", "button"],
                child=[widgets.Icon(pixel_size=25,image="brightness"),
                        widgets.Scale(vertical=True,
                            min=0,
                            max=backlight.max_brightness,
                            step=backlight.max_brightness/100,
                            value=backlight.brightness,
                            on_change=lambda x: setattr(backlight, "brightness", x.value),
                            inverted=True
                            )
                       ]
                )
        
    def setVolume(self,audio, value):
        audio.speakers[-1].volume = value

    def volumeSlider(self):
        return widgets.Box(
                vertical= True, 
                spacing = 10,
                css_classes = ["slider"],
                child=[widgets.Icon(pixel_size=25,image="sound-high"),
                        widgets.Scale(vertical=True,
                            min=0,
                            max=50,
                            step=0.01,
                            inverted=True,
                            value=audio.speakers[-1].volume,
                            on_change=lambda x: self.setVolume(audio, x.value),
                                      )
                       ]
                )


    def __init__(self):
        super().__init__(
            child=widgets.Box(
                child = [self.volumeSlider(), self.brightnessSlider()],
                ),
            css_classes = [ "sliders"],
        )




class vpn(widgets.Button):
    def toggel(self):
        if network.vpn.is_connected:
            utils.exec_sh("ghostty --title=vpn-toggle -e wg-quick down /home/mees/.config/wireguard/mg0.conf")
        else:
            utils.exec_sh("ghostty --title=vpn-toggle -e wg-quick up /home/mees/.config/wireguard/mg0.conf")

    def draw(self):
            if network.vpn.is_connected:
                self.child = widgets.Box(
                    child=[widgets.Icon(pixel_size=25,image="wireguard"), 
                           widgets.Label(label=network.vpn.active_vpn_id)],
                    )
            else:
                self.child = widgets.Box(
                    child=[widgets.Icon(pixel_size=30,image="wireguard"),widgets.Label(label="not connected")],
                    )

    def __init__(self):
        super().__init__(
            css_classes = ["vpn","networkBlock"],
            on_click = lambda self: self.toggel()
        )
        self.draw()
        network.vpn.connect("notify::is-connected", lambda *args: self.draw())

class bluetooth(widgets.Button):
    service = bluetoothService

    def draw(self):
            if len(self.service.connected_devices) >= 1:
                self.child = widgets.CenterBox(
                    start_widget=widgets.Box(child=[
                        widgets.Icon(pixel_size=25,image="bluetooth"), 
                        widgets.Label(label=self.service.connected_devices[0].alias)]),
                    end_widget=widgets.Label(label=f"{bluetoothService.connected_devices[0].battery_percentage:3.0f}%"),
                    )
            else:
                self.child = widgets.Box(
                    child=[widgets.Icon(pixel_size=25,image="bluetooth"),widgets.Label(label="no device connected")],
                    spacing=15
                    )
    
    

    def __init__(self):
        super().__init__(
            css_classes = ["bluetooth","networkBlock"],
            on_click = lambda self: utils.exec_sh("bzmenu -l walker")
        )
        for device in bluetoothService.devices:
            device.connect("notify::connected", lambda x,y: self.draw())
        bluetoothService.connect("device_added",lambda y, x: self.draw())
        self.draw()




class wifi(widgets.Button):
    service = network
    def event(self, func):
        func()
        self.draw()
    def draw(self):
            if self.service.ethernet.is_connected:
                self.child = widgets.Box(
                    child=[widgets.Icon(pixel_size=25,image="network"),
                    widgets.Label(label="wired connection")]
                    )
            elif self.service.wifi.is_connected:
                self.child = widgets.CenterBox(
                    start_widget = widgets.Box(child=[widgets.Icon(pixel_size=25,image="wifi"),
                    widgets.Label(label=self.service.wifi.devices[0].ap.ssid)]), 
                    end_widget=widgets.Label(label=f"{self.service.wifi.devices[0].ap.frequency/1000:1.1f}GHz"),
                    )
            else:
                self.child = widgets.Box(child=[
                    widgets.Icon(pixel_size=25,image="wifi-off"),
                    widgets.Label(label="not connected")]
                    )
            
    def __init__(self):
        super().__init__(
            css_classes = ["wifi","networkBlock"],
            on_click = lambda self: self.event(lambda: utils.exec_sh("nmgui"))
        )
        for device in self.service.wifi.devices:
            device.connect("notify::state", lambda x, y: self.draw())
        
        self.draw()
class networkBlock(widgets.Box):
    def __init__(self):
        super().__init__(
        css_classes= ["controlCenterBlock","network"],
        child = [wifi(),bluetooth(),vpn()],
        spacing = 10,
        vertical = True
                )

class mediaPlayer(widgets.Overlay):
    service = mpris
    def draw(self):
        player = None
        if len(self.service.players) >=1:
            player = mpris.players[-1]
        children = [widgets.Box(child=[widgets.Label(style="margin : 1rem 0rem;",label=" " if player==None else " " + player.identity)]),
            widgets.Box(
                child=[widgets.Label(label=" no music " if player ==None else " " + player.title[:32]),
                       widgets.Label(label=" " if player == None else player.artist[:30])],
                vertical = True,
                spacing = 4
                ),
            widgets.Box(
            vertical=True,
            child=[widgets.CenterBox(
                start_widget=widgets.Button(
                    on_click= lambda self: player.previous(),
                    child=widgets.Icon(
                        image="skip-prev",
                        pixel_size = 25
                    )
                ),
                center_widget=widgets.Button(
                    on_click= lambda self: player.play_pause(),
                    child=widgets.Icon(
                        image="pause" if player and player.playback_status == "Paused" else "play",
                        pixel_size = 25
                        )
                    ),
                end_widget=widgets.Button(
                    on_click= lambda self: player.next(),
                    child=widgets.Icon(
                        image = "skip-next",
                        pixel_size = 25
                    )
                ),
            ),

                   ])]
        self.overlays = [widgets.Box(child = children,  vertical=True)]
        self.child = widgets.Picture(image=player.art_url if player != None else "none", css_classes = ["image"])
    def __init__(self):
        
        super().__init__(
            css_classes=["mediaPlayer", "controlCenterBlock"],
            )
        self.draw()
        
        mpris.connect("player_added", lambda y, x: self.draw())
        for players in mpris.players:
            players.connect("notify::playback-status", lambda y, x: self.draw())
            players.connect("notify::metadata", lambda y, x: self.draw())

class controlCenter(widgets.Window):
    is_visible = False
    def __init__(self):
        super().__init__(

            anchor=["top","right", "bottom"],
            margin_bottom=10,
            margin_top=10,
            style="border-radius:2rem; margin-right:5.5rem;",
            namespace="control-center",
        )

    def show(self):
        self.is_visible = True
        self.child = widgets.EventBox(
            child=[mediaPlayer(),
                   networkBlock(),
                   widgets.CenterBox(css_classes = ["controlCenterBlock"], start_widget= sliders(), end_widget = powermenu())],
            vertical=True,
            homogeneous=False,
            spacing=10,
            on_hover_lost=lambda self: self.hide(),
            )
 
    
    def hide(self):
        self.is_visible = False
        self.child = None

