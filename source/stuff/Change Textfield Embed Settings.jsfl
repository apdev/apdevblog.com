replaceEmbedCharacter();

function replaceEmbedCharacter()
{
  doc = fl.getDocumentDOM();

  var el = doc.selection[0];
  var mainTimeline = doc.currentTimeline;

  if(el == undefined || el.elementType != "text")
  {
    alert("Please select a Textfield");
    return;
  }

  var rangeToApply = el.embedRanges;
  var charsToApply = el.embeddedCharacters;
  
  var font = el.getTextAttr("face");
  
  lib = doc.library;
  it = lib.items

  for(var i in it)
  {
    if(it[i].itemType == "movie clip")
    {
      lib.editItem(it[i].name)
      timeline = doc.getTimeline();
      
      var elementsToEdit = new Array();
      
      for(var j=0; j < timeline.layers.length; j++)
      {
        for(var k=0; k < timeline.layers[j].frames.length; k++)
        {
          var elements = timeline.layers[j].frames[k].elements;

          for(var l in elements)
          {
            if(elements[l].elementType == "text")
            {
              if(elements[l].textType != "static" && elements[l].getTextAttr("face") == font)
              {
                elementsToEdit.push(elements[l]);
              }
            }
          }
        }
      }
      
      for(var m = 0; m < elementsToEdit.length; m++)
      {
        elementsToEdit[m].embedRanges = rangeToApply;
        elementsToEdit[m].embeddedCharacters = charsToApply;
      }
    }
  }
  
  fl.getDocumentDOM().currentTimeline = mainTimeline;
}