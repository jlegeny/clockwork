function recordOutboundLink(link, category, action) { 
  try { 
    var pageTracker=_gat._getTracker("UA-XXXXX-X"); 
    pageTracker._trackEvent(category, action); 
    setTimeout('document.location = "' + link.href + '"', 100) 
  }catch(err){} 
} 