hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("~/.config/hypr/scripts/sync-dark-theme.sh")
end)
