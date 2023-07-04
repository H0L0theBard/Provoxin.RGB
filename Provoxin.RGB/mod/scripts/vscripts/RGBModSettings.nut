global function RGBModSettingsInit

void function RGBModSettingsInit()
{
	ModSettings_AddModTitle("Provoxin RGB")

	ModSettings_AddModCategory( "Colors" )

	AddModSettingsRGBColorPicker( "idcolor_ally", "rgb_ally_color", "Friendly Color" )
	AddModSettingsRGBColorPicker( "idcolor_enemy", "rgb_enemy_color", "Enemy Color" )

	ModSettings_AddSliderSetting( "rgb_ally_brightness", "Friendly Brightness", 0, 50, 0.1, true )

	ModSettings_AddSliderSetting( "rgb_enemy_brightness", "Enemy Brightness", 0, 50, 0.1, true )

	ModSettings_AddModCategory("Colour Cycling Settings")

	ModSettings_AddDropDown( "rgb_ally_rainbow", "Ally Rainbow Cycle", [ "Disabled", "Enabled" ], true )
	ModSettings_AddDropDown( "rgb_enemy_rainbow", "Enemy Rainbow Cycle", [ "Disabled", "Enabled" ], true )
	AddConVarSetting("rgb_cycle_speed", "Colour cycling speed", "float")
}

void function AddModSettingsRGBColorPicker( string conVar, string archive, string buttonLabel, bool liveUpdate = false )
{
	ModSettings_AddButton( buttonLabel,
		void function() : ( conVar, archive )
		{
			thread void function() : ( conVar, archive )
			{
				EndSignal( uiGlobal.signalDummy, "ColorPickerSelected" )
				OpenColorPickerDialog( conVar, false, false, false )

				OnThreadEnd( void function()
					{
						CloseSubmenu()
					}
				)

				// color blind stuff
				int cbMode = GetConVarInt( "colorblind_mode" )
				string conVarSuffix = cbMode != 0 ? "_cb" + cbMode : ""
				string fullColorConVar = conVar + conVarSuffix

				while( true )
				{
					table response = WaitSignal( uiGlobal.signalDummy, "ColorPickerLiveUpdate", "ColorPickerDialogReset" )

					if( response.signal == "ColorPickerDialogReset" )
					{
						SetConVarToDefault( fullColorConVar )
						SetConVarToDefault( archive )
						return
					}

					vector ornull rgb = expect vector ornull( response[ "color" ] )
					if( rgb == null )
						continue
					expect vector( rgb )

					SetConVarString( fullColorConVar, format( "%.1f %.1f %1.f %s", rgb.x / 255, rgb.y / 255, rgb.z / 255, GetConVarString( "rgb_ally_brightness" ) ) )
					SetConVarString( archive, format( "%.1f %.1f %1.f", rgb.x / 255, rgb.y / 255, rgb.z / 255 ) )
				}
			}()
		}, 3
	)
}
