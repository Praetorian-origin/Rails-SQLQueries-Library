// **** COPY CODE
var classElements = document.getElementsByClassName("copy");



var myFunction = function() {
var parents = this.parentNode.parentNode;
var childs = parents.childNodes;
var range;
var selection;

selection = window.getSelection();
range = document.createRange();

 for( i = 0; childs.length; i++) {

 
 	if (childs[i].className =="query-text") {
 		
        range.selectNodeContents(childs[i]);
        selection.removeAllRanges();
        selection.addRange(range);    
        document.execCommand('copy');
 		break;
 	}

 }


};


for (i = 0; i < classElements.length; i++) {
	classElements[i].addEventListener('click', myFunction, false);
}





$(function () {
  $('[data-toggle="popover"]').popover( {
  	trigger: 'focus'
  })

})


// SEARCH CODE


$("#searchBar").keyup(function () {
    //split the current value of searchInput
    var data = this.value.split(" ");
    //create a jquery object of the rows
    var jo = $("#tbodyData").find("tr");
    if (this.value == "") {
        jo.show();
        return;
    }
    //hide all the rows
    jo.hide();

    //Recusively filter the jquery object to get results.
    jo.filter(function (i, v) {
        var $t = $(this);
        for (var d = 0; d < data.length; ++d) {
            if ($t.is(":contains('" + data[d] + "')")) {
                return true;
            }
        }
        return false;
    })
    //show the rows that match.
    .show();})