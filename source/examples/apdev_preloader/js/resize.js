function resizeToScreen() {
	window.moveTo(0,0);
	window.resizeTo(screen.availWidth,screen.availHeight);
	
	setSize();
}

function getBrowserWidth() {
	// returns window width
  if (window.innerWidth)
    return window.innerWidth;
  else if (document.body)
    return document.body.clientWidth;
}

function getBrowserHeight() {
	// return window height
  if (window.innerHeight)
    return window.innerHeight;
  else if (document.body)
    return document.body.clientHeight;
}

function setFlashAttribute(attribute,value){
	// wert fuer flashobject setzen
	//alert("setFlashAttribute() "+movieName+" -> "+attribute+":"+value);
	document[movieName].setAttribute(attribute,value);
}

function setSize( diff ){
	if (!diff) diff = 0;
	// bei resize des browsers flash objekt an fenster anpassen. dabei minimal abmessungen beruecksichtigen,
	// damit der hauptcontent ueber die browser scrollbars erreichbar ist
	// @diff is ein hilfsparamter. damit das ganze auch bei netscape 7 und mozilla klappt, muss der film
	// zunaechst auf eine flaeche abzueglich der scrollbarabmessungen gesetzt werden.
	setFlashAttribute("width",(getBrowserWidth() > width) ? getBrowserWidth()+diff : width);
	setFlashAttribute("height",(getBrowserHeight() > height) ? getBrowserHeight()+diff : height);
}

function setSizeTimer( ) {
	// für mozilla und netscape setSize zeitversetzt 2 mal ausführen, damit weissraum von scrollbars immer gefuellt wird
	if (!document.all) {
		setSize ( -16 );
		self.setTimeout("setSize( )", 100);
	}
	else setSize( );
}

//window.onload = resizeToScreen;
window.onload = setSize;
window.onresize = setSizeTimer;