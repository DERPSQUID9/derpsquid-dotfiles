import math
import shutil
from collections.abc import Callable
from datetime import datetime
from time import gmtime, strftime

import psutil  # Not included by default
from ignis.app import IgnisApp
from ignis.services.audio import AudioService
from ignis.services.hyprland import HyprlandService
from ignis.services.mpris import MprisPlayer, MprisService
from ignis.services.network import NetworkService, WifiDevice
from ignis.services.system_tray import SystemTrayItem, SystemTrayService
from ignis.utils import Utils
from ignis.variable import Variable
from ignis.widgets import Widget

app = IgnisApp.get_default()
app.apply_css(f"{Utils.get_current_dir()}/style.scss", "user")

audio = AudioService.get_default()
hyprland = HyprlandService.get_default()
mpris = MprisService.get_default()
network = NetworkService.get_default()
system_tray = SystemTrayService.get_default()

# Global constants
BAR_SPACING = 10
WIDGET_SPACING = 5
ICON_SPACING = 2

# Make sure to match window manager gaps
GAPS_IN = 5
GAPS_OUT = 20

TERMINAL = "handlr launch x-scheme-handler/terminal -- -e"

# Global variables
show_calendar = Variable(value=False)
show_media_info = Variable(value=False)


def toggle_variable(var: Variable):
    def _inner(_) -> None:
        var.value = not var.value

    return _inner


@Utils.debounce(75)
def scroll_workspaces(step: int) -> None:
    current = hyprland.active_workspace["id"]
    hyprland.switch_to_workspace(min(max(current + step, 0), 10))


def workspace_button(workspace: dict[str, int]) -> Widget.Button:
    widget = Widget.Button(
        css_classes=["flat"],
        on_click=lambda _, id=workspace["id"]: hyprland.switch_to_workspace(id),
        child=Widget.Label(label=str(workspace["id"])),
    )

    if workspace["id"] == hyprland.active_workspace["id"]:
        widget.add_css_class("active")

    return widget


# TODO: get icons of open programs
def workspaces() -> Widget.EventBox:
    return Widget.EventBox(
        on_scroll_up=lambda _: scroll_workspaces(-1),
        on_scroll_down=lambda _: scroll_workspaces(1),
        spacing=WIDGET_SPACING,
        child=hyprland.bind(
            "workspaces",
            transform=lambda value: [workspace_button(i) for i in value],
        ),
    )


# TODO: get icon of active window
def active_window() -> Widget.Box:
    title = hyprland.bind(
        "active_window",
        transform=lambda window: window.get("title", ""),
    )

    return Widget.Box(
        spacing=WIDGET_SPACING,
        child=[
            Widget.Icon(image="desktop"),
            Widget.Label(
                ellipsize="end",
                max_width_chars=15,
                label=title,
                tooltip_text=title,
            ),
        ],
    )


def track_progress(player: MprisPlayer):
    return player.bind_many(
        ["position", "length"],
        transform=lambda position,
        length: f"{strftime("%M:%S", gmtime(position))} / {strftime("%M:%S", gmtime(length))}",
    )


def mpris_title(player: MprisPlayer) -> Widget.EventBox:
    artist_revealer = Widget.Revealer(
        child=Widget.Box(
            spacing=WIDGET_SPACING,
            child=[
                Widget.Label(
                    label=player.bind("artist"),
                    ellipsize="end",
                    max_width_chars=20,
                ),
                Widget.Label(
                    # Only show if there is an artist
                    visible=player.bind(
                        "artist",
                        transform=lambda artist: artist != "",
                    ),
                    label="-",
                ),
            ],
        ),
        reveal_child=False,
        transition_type="slide_right",
    )

    return Widget.EventBox(
        spacing=WIDGET_SPACING,
        setup=lambda self: player.connect(
            "closed",
            lambda _: self.unparent(),  # remove widget when player is closed
        ),
        child=[
            Widget.Icon(image="audio-x-generic"),
            artist_revealer,
            Widget.Label(
                ellipsize="end",
                max_width_chars=20,
                label=player.bind(
                    "title",
                ),
            ),
        ],
        tooltip_text=track_progress(player),
        on_hover=lambda _: artist_revealer.set_reveal_child(True),
        on_hover_lost=lambda _: artist_revealer.set_reveal_child(False),
        on_click=toggle_variable(show_media_info),
    )


def media() -> Widget.Box:
    return Widget.Box(
        spacing=WIDGET_SPACING,
        setup=lambda self: mpris.connect(
            "player-added", lambda _, player: self.append(mpris_title(player))
        ),
    )


def desymbolize(icon_name: str | None) -> str:
    """Given an icon name, removes "-symbolic" from the end"""
    if icon_name is None:
        return ""
    else:
        return "-".join(icon_name.split("-")[:-1])


def volume() -> Widget.EventBox:
    slider_revealer = Widget.Revealer(
        child=Widget.Scale(
            value=audio.speaker.bind_many(
                ["volume", "is_muted"],
                lambda volume, is_muted: 0 if is_muted else volume,
            ),
            on_change=lambda self: audio.speaker.set_volume(self.value),
        ),
        transition_type="slide_left",
        reveal_child=False,
    )
    return Widget.EventBox(
        child=[
            Widget.Icon(
                image=audio.speaker.bind("icon_name", transform=desymbolize),
            ),
            Widget.Label(
                label=audio.speaker.bind(
                    "volume", transform=lambda volume: f"{volume}%"
                )
            ),
            slider_revealer,
        ],
        on_hover=lambda _: slider_revealer.set_reveal_child(True),
        on_hover_lost=lambda _: slider_revealer.set_reveal_child(False),
        on_right_click=lambda _: Utils.exec_sh_async("pavucontrol"),
    )


def format_bitrate(kbits: int) -> str:
    magnitude = math.floor(math.log(kbits, 1000))
    prefix = "K"
    # Higher magnitudes are too high to ever come up in practice
    match magnitude:
        case 1:
            prefix = "M"
        case 2:
            prefix = "G"
    return f"󰓅 {round(kbits / (1000 * magnitude))} {prefix}bit/s"


def connection_name(device: WifiDevice) -> Widget.Box:
    return Widget.Box(
        child=[Widget.Label(label=device.ap.bind("ssid"))],
        tooltip_text=device.ap.bind("max_bitrate", transform=format_bitrate),
    )


def connections() -> Widget.EventBox:
    ssid_revealer = Widget.Revealer(
        child=Widget.Box(
            spacing=WIDGET_SPACING,
            child=network.wifi.bind(
                "devices",
                transform=lambda devices: [connection_name(d) for d in devices],
            ),
        ),
        transition_type="slide_left",
        reveal_child=False,
    )
    return Widget.EventBox(
        child=[
            Widget.Icon(image=network.wifi.bind("icon_name", transform=desymbolize)),
            ssid_revealer,
            Widget.Icon(image=network.vpn.bind("icon_name", transform=desymbolize)),
        ],
        on_right_click=lambda _: [
            c.toggle_connection() for c in network.vpn.connections
        ],
        on_hover=lambda _: ssid_revealer.set_reveal_child(True),
        on_hover_lost=lambda _: ssid_revealer.set_reveal_child(False),
        on_click=lambda _: Utils.exec_sh_async(f"{TERMINAL} nmtui"),
    )


def statistic(
    css_class: str,
    icon_name: str,
    data: Callable[[], float],
    unit: str = "%",
    urgent: int = 70,
    critical: int = 90,
) -> Widget.Box:
    css_classes = Variable(value=[])
    label = Widget.Label()

    def update(_) -> None:
        latest = data()

        css_classes.value = [css_class]

        if latest >= critical:
            css_classes.value += ["error"]
        elif latest >= urgent:
            css_classes.value += ["warning"]

        label.set_label("{:02d}{}".format(round(latest), unit))

    Utils.Poll(2000, update)

    return Widget.Box(
        spacing=ICON_SPACING,
        css_classes=css_classes.bind("value"),
        child=[Widget.Icon(image=icon_name), label],
    )


def statistics() -> Widget.Box:
    def disk_usage() -> float:
        total, usage, _ = shutil.disk_usage("/persist")
        return usage / total * 100

    return Widget.Box(
        spacing=WIDGET_SPACING,
        child=[
            statistic(
                "memory",
                "utilities-system-monitor",
                lambda: psutil.virtual_memory().percent,
            ),
            statistic(
                "cpu",
                "firmware-manager",
                psutil.cpu_percent,
            ),
            statistic(
                "disk",
                "disk-manager",
                disk_usage,
            ),
            statistic(
                "temperature",
                "thermal-monitor",
                lambda: psutil.sensors_temperatures()["k10temp"][1].current,
                "°C",
                60,
                75,
            ),
        ],
    )


def tray_item(item: SystemTrayItem) -> Widget.Button:
    if item.menu:
        menu = item.menu.copy()
    else:
        menu = None

    return Widget.Button(
        child=Widget.Box(
            child=[
                Widget.Icon(image=item.bind("icon")),
                menu,
            ]
        ),
        setup=lambda self: item.connect("removed", lambda _: self.unparent()),
        tooltip_text=item.bind("tooltip"),
        on_click=lambda _: menu.popup() if menu else None,
        on_right_click=lambda _: menu.popup() if menu else None,
        css_classes=["flat"],
    )


def tray() -> Widget.Box:
    return Widget.Box(
        spacing=WIDGET_SPACING,
        setup=lambda self: system_tray.connect(
            "added", lambda _, item: self.append(tray_item(item))
        ),
    )


def clock() -> Widget.EventBox:
    clock_label = Widget.Label()
    military_time = Variable(value=False)

    def update_clock(*_args) -> None:
        clock_label.set_label(
            datetime.now().strftime("%T" if military_time.value else "%r")
        )

    # Update the clock once per second
    Utils.Poll(1000, update_clock)

    # Instantly update the clock when it changes to military time
    military_time.connect("notify::value", update_clock)

    return Widget.EventBox(
        spacing=WIDGET_SPACING,
        child=[Widget.Icon(image="accessories-clock"), clock_label],
        on_click=toggle_variable(show_calendar),
        on_right_click=toggle_variable(military_time),
        tooltip_text=datetime.now().strftime(" %a, %b %d, %Y"),
    )


def right_arrow() -> Widget.Arrow:
    return Widget.Icon(image="go-next")


def left_arrow() -> Widget.Arrow:
    return Widget.Icon(image="go-previous")


def bar(monitor_id: int) -> Widget.Window:
    Widget.Window(
        namespace=f"ignis_bar_{monitor_id}",
        monitor=monitor_id,
        exclusivity="exclusive",
        anchor=["left", "top", "right"],
        # NOTE: margin_top is different because it looks a bit nicer
        margin_top=15,
        margin_left=GAPS_OUT,
        margin_right=GAPS_OUT,
        child=Widget.CenterBox(
            start_widget=Widget.Box(
                css_classes=["left"],
                child=[
                    workspaces(),
                    right_arrow(),
                    active_window(),
                    right_arrow(),
                ],
            ),
            center_widget=Widget.Box(
                visible=mpris.bind("players", lambda value: len(value) != 0),
                child=[
                    left_arrow(),
                    media(),
                    right_arrow(),
                ],
            ),
            end_widget=Widget.Box(
                css_classes=["right"],
                child=[
                    left_arrow(),
                    volume(),
                    left_arrow(),
                    connections(),
                    left_arrow(),
                    statistics(),
                    left_arrow(),
                    tray(),
                    left_arrow(),
                    clock(),
                ],
            ),
        ),
    )


def calendar(monitor_id: int) -> Widget.Window:
    return Widget.Window(
        visible=show_calendar.bind("value"),
        namespace=f"ignis_popup_calendar_{monitor_id}",
        monitor=monitor_id,
        exclusivity="normal",
        anchor=["top", "right"],
        margin_top=GAPS_OUT,
        margin_right=GAPS_IN + GAPS_OUT,
        child=Widget.Calendar(),
    )


def mpris_button(
    player: MprisPlayer,
    icon_name: str,
    on_click: Callable[[], None],
    visible_when: str = "can_control",
) -> Widget.Button:
    return Widget.Button(
        css_classes=["circular"],
        visible=player.bind(visible_when),
        child=Widget.Icon(pixel_size=32, image=icon_name),
        on_click=lambda _: on_click(),
    )


def mpris_player(player: MprisPlayer) -> Widget.Box:
    return Widget.Box(
        spacing=WIDGET_SPACING,
        setup=lambda self: player.connect(
            "closed",
            lambda _: self.unparent(),  # remove widget when player is closed
        ),
        css_classes=["player"],
        child=[
            Widget.Picture(
                image=player.bind(
                    "art_url",
                    transform=lambda art_url: "applications-multimedia"
                    if art_url is None
                    else art_url,
                ),
                width=100,
                height=100,
            ),
            Widget.Box(
                spacing=WIDGET_SPACING,
                vertical=True,
                child=[
                    Widget.Label(
                        css_classes=["title-4", "accent"], label=player.bind("title")
                    ),
                    Widget.Label(label=player.bind("artist")),
                    Widget.Label(label=player.bind("album")),
                    Widget.Scale(
                        max=player.bind("length"),
                        value=player.bind("position"),
                        on_change=lambda self: player.set_property(
                            "position", self.value
                        ),
                    ),
                    Widget.Label(label=track_progress(player)),
                    Widget.Box(
                        spacing=WIDGET_SPACING,
                        visible=player.bind("can_control"),
                        homogeneous=True,
                        child=[
                            mpris_button(
                                player,
                                "media-skip-backward",
                                player.previous,
                                "can_go_previous",
                            ),
                            mpris_button(
                                player,
                                player.bind(
                                    "playback_status",
                                    transform=lambda playback_status: "media-playback-paused"
                                    if playback_status == "Playing"
                                    else "media-playback-playing",
                                ),
                                player.play_pause,
                                "can_pause",
                            ),
                            mpris_button(
                                player,
                                "media-playback-stopped",
                                player.stop,
                            ),
                            mpris_button(
                                player,
                                "media-skip-forward",
                                player.next,
                                "can_go_next",
                            ),
                        ],
                    ),
                ],
            ),
        ],
    )


# TODO: give each player its own window
def media_player(monitor_id: int) -> Widget.Window:
    return Widget.Window(
        visible=show_media_info.bind("value"),
        namespace=f"ignis_popup_media_info_{monitor_id}",
        monitor=monitor_id,
        exclusivity="normal",
        anchor=["top"],
        margin_top=GAPS_OUT,
        child=Widget.Box(
            setup=lambda self: mpris.connect(
                "player-added", lambda _, player: self.append(mpris_player(player))
            ),
        ),
    )


for i in range(Utils.get_n_monitors()):
    bar(i)
    calendar(i)
    media_player(i)