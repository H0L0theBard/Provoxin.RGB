global function RGBModSettingsInit

void function RGBModSettingsInit(){

	AddModTitle("Provoxin RGB")
	AddModCategory("Ally Colour Settings")
	AddConVarSettingSlider( "rgb_ally_color_r", "Red value", 0, 255, 0.1, true)
	AddConVarSettingSlider( "rgb_ally_color_g", "Green value", 0, 255, 0.1, true)
	AddConVarSettingSlider( "rgb_ally_color_b", "Blue value", 0, 255, 0.1, true)
	AddConVarSettingSlider( "rgb_ally_brightness", "Brightness", 0, 50, 0.1, true)
	AddModCategory("Enemy Colour Settings")
	AddConVarSettingSlider( "rgb_enemy_color_r", "Red value", 0, 255, 0.1, true)
	AddConVarSettingSlider( "rgb_enemy_color_g", "Green value", 0, 255, 0.1, true)
	AddConVarSettingSlider( "rgb_enemy_color_b", "Blue value", 0, 255, 0.1, true)
	AddConVarSettingSlider( "rgb_enemy_brightness", "Brightness", 0, 50, 0.1, true)
	AddModCategory("Colour Cycling Settings")
	AddConVarSettingEnum("rgb_ally_rainbow", "Enable colour cycling for allies", [ "No", "Yes" ])
	AddConVarSettingEnum("rgb_enemy_rainbow", "Enable colour cycling for enemies", [ "No", "Yes" ])
	AddConVarSetting("rgb_cycle_speed", "Colour cycling speed", "float")
	
}