-- This script is meant to be run before running a ReaScript from the command line in order to get scripts with UI to close for updating.
reaper.ClearConsole()
reaper.Main_OnCommand(41898, 0) -- ReaScript: Close all running ReaScripts
