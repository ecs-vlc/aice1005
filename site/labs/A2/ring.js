

var Ring = {
    w:400,
    h:400,
    n:10,
    current:-1,
    noElements:0,
};

Ring.outerRadius = Math.min(Ring.w, Ring.h) / 2.1;
Ring.innerRadius = Ring.outerRadius*0.8;


	
var arc = d3.svg.arc()
    .outerRadius(Ring.outerRadius)
    .innerRadius(Ring.innerRadius);

var pie = d3.layout.pie()
    .sort(null)
    .value(function(d) { return 1; });

var Ringsvg = d3.select("#Ring").append("svg")
    .attr("width", Ring.w)
    .attr("height", Ring.h)
    .append("g")
    .attr("transform", "translate(" + Ring.h / 2 + "," + Ring.h / 2 + ")");

Ring.data = [];
for(var i=0; i<Ring.n; ++i)
    Ring.data[i] = "null";


var Ringarcs = Ringsvg.selectAll("g.arc")
    .data(pie(Ring.data))
    .enter().append("g")
    .attr("class", "arc")
    .attr("id", function(d,i) { return "Ringarc"+i; });

 Ringarcs.append("path")
    .attr("d", arc)
    .style("stroke", "black")
    .style("fill", "white");

 Ringarcs.append("text")
    .attr("transform", function(d) {return "translate(" + arc.centroid(d) + ")"; })
    .attr("dy", ".60em")
    .attr("font-family", "sans-serif")
    .attr("font-size", "14px")
    .style("text-anchor", "middle")
    .text(function(d) { return d.data; });

var RingDialog = Ringsvg.append("text")
    .attr("y", -0.45*Ring.h)
    .attr("x", -0.49*Ring.w);

var RingResult = Ringsvg.append("text")
    .style("text-anchor", "middle");


function add() {
    var x = Math.floor(Math.random()*100);
    Ringsvg.select("#Ringarc"+Ring.current)
	.select("text")
	.attr("fill", "black");
    Ring.current++;
    if (Ring.current==Ring.n)
	Ring.current = 0;
    Ring.data[Ring.current] = x;
    if (Ring.noElements<Ring.n)
	Ring.noElements++;
    RingDialog.text("enqueue("+x+")");
    RingResult
	.transition()
	.duration(500)
	.each("start", function() {
	    d3.select(this)
		.text(x);
	})
	    .each("end", function() {
		d3.select(this)
		    .text("");
	    });
    
    Ringsvg.select("#Ringarc"+Ring.current)
	.select("text")
	.attr("transform", function(d) {return "translate(" + arc.centroid(d) + ")"; })
	.attr("fill", "blue")
	.attr("dy", ".60em")
	.attr("font-family", "sans-serif")
	.attr("font-size", "14px")
	.style("text-anchor", "middle")
	.transition()
	.delay(500)
	.duration(250)
	.text(x);
};


function ringsize() {
    RingDialog.text("size()");
    RingResult
	.transition()
	.delay(500)
	.duration(500)
	.text(Ring.noElements);
};

function get(i) {
    RingDialog.text("get(" + i + ")");
    if (Ring.noElements>i) {
	var j = Ring.current - i;
	if (j<0)
	    j += Ring.n;
	RingResult
	    .transition()
	    .delay(500)
	    .duration(500)
	    .text(Ring.data[j]);
    } else {
	RingResult
	    .transition()
	    .delay(500)
	    .duration(500)
	    .text("IndexOutOfBoundsException");
    }
};



function iterator() {
    RingDialog.text("iterator( )");
    for(var i=0; i<Ring.noElements; ++i) {
	var j = Ring.current - i;
	if (j<0)
	    j += Ring.n;
	RingResult
	    .transition()
	    .delay(1000*i)
	    .duration(1000)
	    .text(Ring.data[j]);
    }
    RingResult
	    .transition()
	    .delay(1000*Ring.noElements)
	    .duration(1000)
	    .text("");
}
