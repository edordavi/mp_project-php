function consulta(cadena)
    { 
    if (window.XMLHttpRequest)
      {// code for IE7+, Firefox, Chrome, Opera, Safari
      xmlhttp=new XMLHttpRequest();
      }
    else
      {// code for IE6, IE5
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
      }
    xmlhttp.onreadystatechange=function()
      {
      if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
         document.getElementById("datos").innerHTML=xmlhttp.responseText;
         console.log(xmlhttp.responseText);
        }
      }
    xmlhttp.open("GET",cadena,true);
    xmlhttp.send();
    }

function consulta2(cadena,idElemento)
    { 
    if (window.XMLHttpRequest)
      {// code for IE7+, Firefox, Chrome, Opera, Safari
      xmlhttp=new XMLHttpRequest();
      }
    else
      {// code for IE6, IE5
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
      }
    xmlhttp.onreadystatechange=function()
      {
      if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
         document.getElementById(idElemento).innerHTML=xmlhttp.responseText;
         console.log(xmlhttp.responseText);
        }
      }
    xmlhttp.open("GET",cadena,true);
    xmlhttp.send();
    }
