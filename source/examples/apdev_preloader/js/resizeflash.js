function setFlashHeight(newH)
{
  window.scroll(0,0);
	//document.getElementById(divid).style.height = newH+"px";
	swffit(mw_flashMovieId, width, newH);
	document.getElementById(mw_flashMovieId).setAttribute("height",newH);
}