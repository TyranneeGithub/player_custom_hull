local f = { FCVAR_ARCHIVE, FCVAR_REPLICATED };

hull_x     = CreateConVar( "hull_xsize", "32", f, "How big should our hull's width be? Valve's default is (32)", 1, 512 );
hull_y     = CreateConVar( "hull_ysize", "72", f, "How big should our hull's height be? Valve's default is (72)", 1, 512 );
hull_d     = CreateConVar( "hull_duck_ysize", "36", f, "How big should our hull's height be when crouched? Valve's default is (36)", 1, 512 );

hull_debug = CreateConVar( "hull_debug_mode", "0", f, "Enable debug mode for custom hull?", 0, 1 );
hull_hitbx = CreateConVar( "hull_debug_hitbox", "0", f, "Should we also show the Player's hitbox?", 0, 1 );

hull_r     = CreateConVar( "hull_colour_r", "0", f, "Colour for the debug hull (red)", 0, 255 );
hull_g     = CreateConVar( "hull_colour_g", "100", f, "Colour for the debug hull (green)", 0, 255 );
hull_b     = CreateConVar( "hull_colour_b", "255", f, "Colour for the debug hull (blue)", 0, 255 );
hull_a     = CreateConVar( "hull_colour_a", "255", f, "Debug hull's transparency", 0, 255 );

hook.Add( "PlayerPostThink", "PlayerUpdateHull", function( p ) 

    local x = hull_x:GetInt() * 0.5;

    local min  = Vector( -x, -x, 0 );
    local max  = Vector(  x,  x, hull_y:GetInt() );
    local maxd = Vector(  x,  x, hull_d:GetInt() );

    p:SetHull( min, max );
    p:SetHullDuck( min, maxd );
end );