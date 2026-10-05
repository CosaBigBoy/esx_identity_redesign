Config = {}
Config.Locale = GetConvar("esx:locale", "en")

-- [Config.EnableCommands]
-- Enables Commands Such As /char and /chardel
Config.EnableCommands = ESX.GetConfig().EnableDebug

-- Date format used by the registration menu
-- Choices: DD/MM/YYYY | MM/DD/YYYY | YYYY/MM/DD
Config.DateFormat = "DD/MM/YYYY"

Config.MaxNameLength = 20
Config.MinHeight = 120
Config.MaxHeight = 220
Config.MaxAge = 100

Config.FullCharDelete = true
Config.EnableDebugging = ESX.GetConfig().EnableDebug

-- Identity NUI theme
-- Change these values to instantly recolor the complete menu.
-- Hex colors are recommended.
Config.UI = {
    Primary = "#8B5CF6",
    PrimaryDark = "#6D3FD1",
    PrimarySoft = "#A78BFA",
    Background = "#07060B",
    Surface = "#0E0C14",
    SurfaceAlt = "#14111C",
    Text = "#F8F7FF",
    Muted = "#9691A8",
    Success = "#55D68A",
    Danger = "#FF5F73"
}
