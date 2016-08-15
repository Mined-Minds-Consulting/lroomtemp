// product image next to product drop down on the estimation page
$('#school').change(function(){
  var selectionImage = $('.selection img');
  var itemType = $('#school').val();
  
  if (itemType === "casd") {
    selectionImage.prop("src","img/school_logos/mightymikelogo.jpg");
  } else if (itemType === "wcsd") {
    selectionImage.prop("src","img/school_logos/waynesburg_sm.jpg");
  } else if (itemType === "wgsd") {
    selectionImage.prop("src","img/school_logos/pioneer.jpg");
  } else if (itemType === "jmsd") {
    selectionImage.prop("src","img/school_logos/jefferson_sm.jpg");
  } else if (itemType === "sgsd") {
    selectionImage.prop("src","img/school_logos/maple_leaf_sm.jpg");
  } else if (itemType === "wu") {                  selectionImage.prop("src","img/school_logos/WaynesburgJackets_sm.jpg");
  } 
});