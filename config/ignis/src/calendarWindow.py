from ignis import widgets, utils
import datetime
class calendar(widgets.Window):
    show = False 
    def child(self):
        return widgets.EventBox(
            child=[widgets.Calendar(
                css_classes=["calendar"],
                day=datetime.datetime.now().day,
                month=datetime.datetime.now().month -1,
                year=datetime.datetime.now().year,
                show_day_names=True,
                show_heading=True,
                show_week_numbers=False
            )],
            vertical=True,
            homogeneous=False,
            spacing=52,
            on_hover_lost=lambda self: self.hide(),
            )
    def __init__(self):
        super().__init__(

            anchor=["right", "bottom"],
            margin_bottom=20,
            style="border-radius:2rem; margin-right:5.5rem;",
            namespace="Calendar-test",
        )
    def show(self):
        self.child = self.child()

    def hide(self):
        self.child = None
