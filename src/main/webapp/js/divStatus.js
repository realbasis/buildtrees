// JavaScript Document

	function cachediv(divID)
	{
		if ( document.getElementById && document.getElementById( divID ) )	// pour les navigateurs recents
			{
				Pdiv = document.getElementById( divID );
				Pch = true;
			}
		else if ( document.all && document.all[ divID ] ) // pour les vieilles versions
			{
				Pdiv = document.all[ divID ];
				Pch = true;
			}
		else if ( document.layers && document.layers[ divID ] )	// pour les tres vieilles versions
			{
				Pdiv = document.all[ divID ];
				Pch = true;
			}
		else
			{
				Pch = false;
			}
		
		if ( Pch )
			{
				Pdiv.className = 'cachediv';
				/* Pdiv.className = ( Pdiv.className == 'cachediv' ) ? '' : 'cachediv'; */
			}
		
	}
	function showdiv(divID)
	{
		if ( document.getElementById && document.getElementById( divID ) )	// pour les navigateurs recents
			{
				Pdiv = document.getElementById( divID );
				Pch = true;
			}
		else if ( document.all && document.all[ divID ] ) // pour les vieilles versions
			{
				Pdiv = document.all[ divID ];
				Pch = true;
			}
		else if ( document.layers && document.layers[ divID ] )	// pour les tres vieilles versions
			{
				Pdiv = document.all[ divID ];
				Pch = true;
			}
		else
			{
				Pch = false;
			}
		
		if ( Pch )
			{
				Pdiv.className = 'showdiv';
				/* Pdiv.className = ( Pdiv.className == 'cachediv' ) ? '' : 'cachediv'; */
			}
		
	}
