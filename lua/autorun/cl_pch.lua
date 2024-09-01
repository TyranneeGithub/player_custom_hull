// Menu
hook.Add( "AddToolMenuCategories", "CustomHullModCategory", function()
    
	spawnmenu.AddToolCategory( "Options", "CustomHullMod", "#Custom hull" );
end );

hook.Add( "PopulateToolMenu", "CustomHullModOptions", function()

	spawnmenu.AddToolMenuOption( "Options", "CustomHullMod", "CustomHullMenu", "#Settings", "", "", function( p )

		p:Clear();
		p:Help( "Presets:" );

        local preset = p:ToolPresets( "Default", { [ "hull_xsize" ] = 32, [ "hull_ysize" ] = 72, [ "hull_duck_ysize" ] = 36 } );
        preset:AddOption( "1 - Garry's mod", {     [ "hull_xsize" ] = 32, [ "hull_ysize" ] = 72, [ "hull_duck_ysize" ] = 36 } );
        preset:AddOption( "2 - Alyx", {            [ "hull_xsize" ] = 12, [ "hull_ysize" ] = 71, [ "hull_duck_ysize" ] = 36 } );
        preset:AddOption( "3 - Combine", {         [ "hull_xsize" ] = 17, [ "hull_ysize" ] = 73, [ "hull_duck_ysize" ] = 38 } );
        preset:AddOption( "4 - Heavy", {           [ "hull_xsize" ] = 22, [ "hull_ysize" ] = 79, [ "hull_duck_ysize" ] = 45 } );
        p:ControlHelp( "NOTE: Character presets are purely demonstrative and NOT meant to be accurate!" );

        p:Help( "Settings:" );


        local s = p:NumSlider( "Hull width", "hull_xsize", 1, 512, 0 );
        s:SetTooltip( "You can also manually set it in console using 'hull_xsize'" );
		p:ControlHelp( "How big should our hull's width be? Valve's default is (32)" );

        local s = p:NumSlider( "Hull height", "hull_ysize", 1, 512, 0 );
        s:SetTooltip( "You can also manually set it in console using 'hull_ysize'" );
		p:ControlHelp( "How big should our hull's height be? Valve's default is (72)" );

        local s = p:NumSlider( "Crouched hull height", "hull_duck_ysize", 1, 512, 0 );
        s:SetTooltip( "You can also manually set it in console using 'hull_duck_ysize'" );
		p:ControlHelp( "How big should our hull's height be when crouched? Valve's default is (36)" );


        local b = p:CheckBox( "Player Hull", "hull_debug_mode" );
        s:SetTooltip( "You can also manually set it in console using 'hull_debug_mode'" );
		p:ControlHelp("Draws the player's hull dimensions. Useful for setting the hull you want!" );

        local b = p:CheckBox( "Player Hit-box", "hull_debug_hitbox" );
        s:SetTooltip( "You can also manually set it in console using 'hull_debug_hitbox'" );
		p:ControlHelp( "Draws the player's hit-box...\nNOTE: hit-boxes are NOT affected by your hull!" );


        p:ColorPicker( "Hull colour:", "hull_colour_r", "hull_colour_g", "hull_colour_b", "hull_colour_a" );


        p:Help( "Thanks for installing my mod!" );
	end );
end );


// Debug stuff
hook.Add( "PostPlayerDraw" , "HullDebugMode" , function( p )
	
    if !p:Alive() then 
        return;
    end


    // Draw hull
    if hull_debug:GetBool() then

        local pos = p:GetPos();

        local ang = Angle( 0, 0, 0 );
        local col = Color( hull_r:GetInt(), hull_g:GetInt(), hull_b:GetInt(), hull_a:GetInt() );


        local x = hull_x:GetInt() * 0.5;

        local min = Vector( -x, -x, 0 );
        local max = Vector(  x,  x, hull_y:GetInt() );

        if p:Crouching() then

            max = Vector( x, x, hull_d:GetInt() );
        end

        render.DrawWireframeBox( pos, ang, min, max, col, true );

        render.SetMaterial( Material( "color" ) );
        render.DrawBox( pos, ang, min, Vector( x, x, 0 ), col, true );
    end


    // Draw hitbox
    if hull_hitbx:GetBool() then

        for i = 0, p:GetHitboxSetCount() - 1 do

            for j = 0, p:GetHitBoxCount( i ) - 1 do

                local pos, ang = p:GetBonePosition( p:GetHitBoxBone( j, i ) );
                local min, max = p:GetHitBoxBounds( j, i );

                local col = Color(255, 200, 50);

                render.DrawWireframeBox( pos, ang, min, max, col, true );
            end
        end
    end
end );