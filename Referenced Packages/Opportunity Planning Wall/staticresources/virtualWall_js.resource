/* ============================================================
	Copyright (c) 2011 LogicLine EDV-SystemService GmbH
	All rights reserved.
	
	Redistribution in source and binary forms, with or without
	modification, are not permitted.
	
	THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
	IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
	OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
	IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, 
	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
	NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
	THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
	THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * ============================================================  
 */

// Prevent conflicts with other jquery instances
var j$ = jQuery.noConflict();

// Do when page loaded
j$(document).ready(function(){

    j$(".column-body").sortable({
        connectWith: '.column-body', 
        items: 'li',
        
        // Change cards group field value when card was moved between columns
        receive: function(event, ui) {
        	// Get moved card element
            var sortedElement = j$(ui.item);
                    
            // Find group value of card's column
            var parents =  sortedElement.parentsUntil(".wall");
            var hiddenInput = parents.find("div > input[id$='columnId']").val();  
            
            // Reset the value inside the card
            var input = sortedElement.find("input[name*='movedToColumn']");
        	j$(input).attr("value", hiddenInput); 
        	
        	// Set reminder that card has changed
        	setHasMoved(j$(input));
        }
	}).addTouch();
    
    // Detect and remember form changes
    j$(".card input, .card select, .card textarea").change(function(){
	    setHasChanged(j$(this));
	});
	
	setHasChanged = function(node) {
	    var parents =  j$(node).parentsUntil(".column-body");
	    var hiddenField = parents.find("input[name*='hasChanged']");
	    j$(hiddenField).attr("value", "true"); 	
	};
	
	setHasMoved = function(node) {
	    var parents =  j$(node).parentsUntil(".column-body");
	    var hiddenField = parents.find("input[name*='hasMoved']");
	    j$(hiddenField).attr("value", "true"); 	
	};

	// (Un)collapse cards on checkbox toggle
	j$('#toggleCollapse').change(function() {
		if (j$(this).is(':checked')) {
			j$(".card-body").parent().addClass("collapsed");
		}
		else {
			j$(".card-body").parent().removeClass("collapsed");
		}
	});
	 
	// Create corners
    j$("li").corner();
    if (navigator.appName != "Microsoft Internet Explorer") {
    	j$("div.innerbox").corner("round 4px"); 
    }
    
    // Set all columns to maximum height
    var H = 0;
	j$(".wall ul").each(function(i){
		var h = j$(".wall ul").eq(i).height();		
		if(h > H) H = h;
	});
	j$(".wall ul").height(H + 30);
	
	// Scroll to newly created card
	j$('.New').intoViewport();
	
	// Scroll to first error message
	j$('.errorMsg').intoViewport();
	
	// Color input with error
	j$('.errorMsg').prev().css('border', 'solid 1px #d55');
});
