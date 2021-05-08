library CamOffset initializer Init

globals
	location cameramapLoc
    real mapMinX
	real mapMinY
    real array offsets[10000]
	boolean array offsetsSet[10000]
	rect map
	real mapMaxX
	real mapW
	integer yfact
endglobals

function GetCamOffsetInitGrid takes real x, real y returns real
	local integer index
	local integer iX = -6
	local integer iY
	local real z
	local real r
	local integer i = 64 --9*4+12*2+4
	call MoveLocation(cameramapLoc,x,y)
	set z = GetLocationZ(cameramapLoc)
	set r = 0.
	call MoveLocation(cameramapLoc,x-128.,y)
	set r = r+GetLocationZ(cameramapLoc)*4./i
	call MoveLocation(cameramapLoc,x,y)
	set r = r+GetLocationZ(cameramapLoc)*4./i
	call MoveLocation(cameramapLoc,x+128.,y)
	set r = r+GetLocationZ(cameramapLoc)*4./i
	call MoveLocation(cameramapLoc,x-128.,y+128.)
	set r = r+GetLocationZ(cameramapLoc)*4./i
	call MoveLocation(cameramapLoc,x,y+128.)
	set r = r+GetLocationZ(cameramapLoc)*4./i
	call MoveLocation(cameramapLoc,x+128.,y+128.)
	set r = r+GetLocationZ(cameramapLoc)*4./i
	call MoveLocation(cameramapLoc,x-128.,y-128.)
	set r = r+GetLocationZ(cameramapLoc)*4./i
	call MoveLocation(cameramapLoc,x,y-128.)
	set r = r+GetLocationZ(cameramapLoc)*4./i
	call MoveLocation(cameramapLoc,x+128.,y-128.)
	set r = r+GetLocationZ(cameramapLoc)*4./i
	call MoveLocation(cameramapLoc,x-256.,y-128.)
	set r = r+GetLocationZ(cameramapLoc)*2./i
	call MoveLocation(cameramapLoc,x-256.,y)
	set r = r+GetLocationZ(cameramapLoc)*2./i
	call MoveLocation(cameramapLoc,x-256.,y+128.)
	set r = r+GetLocationZ(cameramapLoc)*2./i
	call MoveLocation(cameramapLoc,x+256.,y-128.)
	set r = r+GetLocationZ(cameramapLoc)*2./i
	call MoveLocation(cameramapLoc,x+256.,y)
	set r = r+GetLocationZ(cameramapLoc)*2./i
	call MoveLocation(cameramapLoc,x+256.,y+128.)
	set r = r+GetLocationZ(cameramapLoc)*2./i
	call MoveLocation(cameramapLoc,x-128.,y-256.)
	set r = r+GetLocationZ(cameramapLoc)*2./i
	call MoveLocation(cameramapLoc,x,y-256.)
	set r = r+GetLocationZ(cameramapLoc)*2./i
	call MoveLocation(cameramapLoc,x+128.,y-256.)
	set r = r+GetLocationZ(cameramapLoc)*2./i
	call MoveLocation(cameramapLoc,x-128.,y+256.)
	set r = r+GetLocationZ(cameramapLoc)*2./i
	call MoveLocation(cameramapLoc,x,y+256.)
	set r = r+GetLocationZ(cameramapLoc)*2./i
	call MoveLocation(cameramapLoc,x+128.,y+256.)
	set r = r+GetLocationZ(cameramapLoc)*2./i
	call MoveLocation(cameramapLoc,x+256.,y+256.)
	set r = r+GetLocationZ(cameramapLoc)*1./i
	call MoveLocation(cameramapLoc,x+256.,y-256.)
	set r = r+GetLocationZ(cameramapLoc)*1./i
	call MoveLocation(cameramapLoc,x-256.,y+256.)
	set r = r+GetLocationZ(cameramapLoc)*1./i
	call MoveLocation(cameramapLoc,x-256.,y-256.)
	set r = r+GetLocationZ(cameramapLoc)*1./i
	return r
endfunction
    
function GetCamOffsetAt takes integer x, integer y returns real
	local integer idx = y*yfact+x
	local real res = offsets[idx]
	if offsetsSet[idx] then
		return res
	endif
	set res = GetCamOffsetInitGrid(mapMinX+256+512*x, mapMinY+256+512*y)
	set offsets[idx] = res
	set offsetsSet[idx] = true
	return res
endfunction
	
function GetGridCamOffset takes integer ix, integer iy, real offx, real offy returns real
	local real r
	local integer ixl = ix-1
	local integer ixr = ix+1
	local integer iyd = iy-1
	local integer iyu = iy+1
	if ixl < 0 then
		set ixl = 0
	endif
	if iyd < 0 then
		set iyd = 0
	endif
	if ixr > 256 then
		set ixr = 256
	endif
	if iyu > 256 then
		set iyu = 256
	endif
	if offx>0 then
		if offy>0 then
			set r =   .089696*GetCamOffsetAt(ixl,iyu)+ .139657*GetCamOffsetAt(ix,iyu)+ .097349*GetCamOffsetAt(ixr,iyu)
			set r = r+.130989*GetCamOffsetAt(ixl,iy) + .099380*GetCamOffsetAt(ix,iy) + .139657*GetCamOffsetAt(ixr,iy)
			set r = r+.082587*GetCamOffsetAt(ixl,iyd)+ .130989*GetCamOffsetAt(ix,iyd)+ .089696*GetCamOffsetAt(ixr,iyd)
		elseif offy<0 then
			set r =   .082587*GetCamOffsetAt(ixl,iyu)+ .130989*GetCamOffsetAt(ix,iyu)+ .089696*GetCamOffsetAt(ixr,iyu)
			set r = r+.130989*GetCamOffsetAt(ixl,iy) + .099380*GetCamOffsetAt(ix,iy) + .139657*GetCamOffsetAt(ixr,iy)
			set r = r+.089696*GetCamOffsetAt(ixl,iyd)+ .139657*GetCamOffsetAt(ix,iyd)+ .097349*GetCamOffsetAt(ixr,iyd)
		else
			set r =   .084604*GetCamOffsetAt(ixl,iyu)+ .134226*GetCamOffsetAt(ix,iyu)+ .091913*GetCamOffsetAt(ixr,iyu)
			set r = r+.134017*GetCamOffsetAt(ixl,iy) + .101594*GetCamOffsetAt(ix,iy) + .142877*GetCamOffsetAt(ixr,iy)
			set r = r+.084604*GetCamOffsetAt(ixl,iyd)+ .134226*GetCamOffsetAt(ix,iyd)+ .091913*GetCamOffsetAt(ixr,iyd)
		endif
	elseif offx<0 then
		if offy>0 then
			set r =   .097349*GetCamOffsetAt(ixl,iyu)+ .139657*GetCamOffsetAt(ix,iyu)+ .089696*GetCamOffsetAt(ixr,iyu)
			set r = r+.139657*GetCamOffsetAt(ixl,iy) + .099380*GetCamOffsetAt(ix,iy) + .130989*GetCamOffsetAt(ixr,iy)
			set r = r+.089696*GetCamOffsetAt(ixl,iyd)+ .130989*GetCamOffsetAt(ix,iyd)+ .082587*GetCamOffsetAt(ixr,iyd)
		elseif offy<0 then
			set r =   .089696*GetCamOffsetAt(ixl,iyu)+ .130989*GetCamOffsetAt(ix,iyu)+ .082587*GetCamOffsetAt(ixr,iyu)
			set r = r+.139657*GetCamOffsetAt(ixl,iy) + .099380*GetCamOffsetAt(ix,iy) + .130989*GetCamOffsetAt(ixr,iy)
			set r = r+.097349*GetCamOffsetAt(ixl,iyd)+ .139657*GetCamOffsetAt(ix,iyd)+ .089696*GetCamOffsetAt(ixr,iyd)
		else
			set r =   .091913*GetCamOffsetAt(ixl,iyu)+ .134226*GetCamOffsetAt(ix,iyu)+ .084604*GetCamOffsetAt(ixr,iyu)
			set r = r+.142877*GetCamOffsetAt(ixl,iy) + .101594*GetCamOffsetAt(ix,iy) + .134017*GetCamOffsetAt(ixr,iy)
			set r = r+.091913*GetCamOffsetAt(ixl,iyd)+ .134226*GetCamOffsetAt(ix,iyd)+ .084604*GetCamOffsetAt(ixr,iyd)
		endif
	else
		if offy>0 then
			set r =   .091913*GetCamOffsetAt(ixl,iyu)+ .142877*GetCamOffsetAt(ix,iyu)+ .091913*GetCamOffsetAt(ixr,iyu)
			set r = r+.134226*GetCamOffsetAt(ixl,iy) + .101594*GetCamOffsetAt(ix,iy) + .134226*GetCamOffsetAt(ixr,iy)
			set r = r+.084604*GetCamOffsetAt(ixl,iyd)+ .134017*GetCamOffsetAt(ix,iyd)+ .084604*GetCamOffsetAt(ixr,iyd)
		elseif offy<0 then
			set r =   .084604*GetCamOffsetAt(ixl,iyu)+ .134017*GetCamOffsetAt(ix,iyu)+ .084604*GetCamOffsetAt(ixr,iyu)
			set r = r+.134226*GetCamOffsetAt(ixl,iy) + .101594*GetCamOffsetAt(ix,iy) + .134226*GetCamOffsetAt(ixr,iy)             
			set r = r+.091913*GetCamOffsetAt(ixl,iyd)+ .142877*GetCamOffsetAt(ix,iyd)+ .091913*GetCamOffsetAt(ixr,iyd)
		else
			set r =   .086125*GetCamOffsetAt(ixl,iyu)+ .136429*GetCamOffsetAt(ix,iyu)+ .086125*GetCamOffsetAt(ixr,iyu)
			set r = r+.136429*GetCamOffsetAt(ixl,iy) + .109784*GetCamOffsetAt(ix,iy) + .136429*GetCamOffsetAt(ixr,iy)
			set r = r+.086125*GetCamOffsetAt(ixl,iyd)+ .136429*GetCamOffsetAt(ix,iyd)+ .086125*GetCamOffsetAt(ixr,iyd)
		endif
	endif
	return r
endfunction
	
function GetCamOffset takes real x, real y returns real
	local integer iXLo = R2I((x-mapMinX)/512.+.5)
	local integer iYLo = R2I((y-mapMinY)/512.+.5)
	local integer iXHi = iXLo+1
	local integer iYHi = iYLo+1
	local integer iChkXLo
	local integer iChkXLoOff
	local integer iChkXHi
	local integer iChkXHiOff
	local integer iChkYLo
	local integer iChkYLoOff
	local integer iChkYHi
	local integer iChkYHiOff
	local real XLo
	local real YLo
	local integer XHi
	local integer YHi
	local real rX
	local real rY
	local real r
	local real LoDX = (x-mapMinX)-(iXLo*512.-256.)
	local real LoDY = (y-mapMinY)-(iYLo*512.-256.)
	if LoDX<=12 then
		set iChkXLo = iXLo
		set iChkXLoOff = 0
		set iChkXHi = iXLo
		set iChkXHiOff = 1
	elseif LoDX<500 then
		set iChkXLo = iXLo
		set iChkXLoOff = 1
		set iChkXHi = iXHi
		set iChkXHiOff =-1
	else
		set iChkXLo = iXHi
		set iChkXLoOff =-1
		set iChkXHi = iXHi
		set iChkXHiOff = 0
	endif
	if LoDY<=12 then
		set iChkYLo = iYLo
		set iChkYLoOff = 0
		set iChkYHi = iYLo
		set iChkYHiOff = 1
	elseif LoDY<500 then
		set iChkYLo = iYLo
		set iChkYLoOff = 1
		set iChkYHi = iYHi
		set iChkYHiOff =-1
	else
		set iChkYLo = iYHi
		set iChkYLoOff =-1
		set iChkYHi = iYHi
		set iChkYHiOff = 0
	endif
	set XLo = iChkXLo*512.+iChkXLoOff*12.-256.
	set XHi = iChkXHi*512+iChkXHiOff*12-256
	set YLo = iChkYLo*512.+iChkYLoOff*12.-256.
	set YHi = iChkYHi*512+iChkYHiOff*12-256
	set rX = ((x-mapMinX)-XLo)/(XHi-XLo)
	set rY = ((y-mapMinY)-YLo)/(YHi-YLo)
	set r =   GetGridCamOffset(iChkXHi,iChkYHi,iChkXHiOff,iChkYHiOff)*rX*rY
	set r = r+GetGridCamOffset(iChkXLo,iChkYHi,iChkXLoOff,iChkYHiOff)*(1-rX)*rY
	set r = r+GetGridCamOffset(iChkXHi,iChkYLo,iChkXHiOff,iChkYLoOff)*rX*(1-rY)
	set r = r+GetGridCamOffset(iChkXLo,iChkYLo,iChkXLoOff,iChkYLoOff)*(1-rX)*(1-rY)
	return r
endfunction

function GetCamOffsetToUnit takes unit u returns real
	return 1600 + BlzGetLocalUnitZ(u) - GetCamOffset(GetUnitX(u), GetUnitY(u))
endfunction

private function Init takes nothing returns nothing
	set map = GetWorldBounds()
	set mapMinX = GetRectMinX(map)
	set mapMinY = GetRectMinY(map)
	set mapMaxX = GetRectMaxX(map)
	set mapW = mapMaxX - mapMinX
	set yfact = R2I(mapW / 512 + 0.5)
	call RemoveRect(map)
	set cameramapLoc = Location(0,0)
endfunction

endlibrary