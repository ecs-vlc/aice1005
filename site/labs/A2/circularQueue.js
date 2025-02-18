

var CQ = {
    w:400,
    h:400,
    n:10,
    head:0,
    noElements:0,
};

CQ.outerRadius = Math.min(CQ.w, CQ.h) / 2.1;
CQ.innerRadius = CQ.outerRadius*0.8;


	
var arc = d3.svg.arc()
    .outerRadius(CQ.outerRadius)
    .innerRadius(CQ.innerRadius);

var pie = d3.layout.pie()
    .sort(null)
    .value(function(d) { return 1; });

var svg = d3.select("#CircularQueue").append("svg")
    .attr("width", CQ.w)
    .attr("height", CQ.h)
    .append("g")
    .attr("transform", "translate(" + CQ.h / 2 + "," + CQ.h / 2 + ")");

CQ.data = [];
for(var i=0; i<CQ.n; ++i)
    CQ.data[i] = "null";


var arcs = svg.selectAll("g.arc")
    .data(pie(CQ.data))
    .enter().append("g")
    .attr("class", "arc")
    .attr("id", function(d,i) { return "CQarc"+i; });

 arcs.append("path")
    .attr("d", arc)
    .style("stroke", "black")
    .style("fill", "white");

 arcs.append("text")
    .attr("transform", function(d) {return "translate(" + arc.centroid(d) + ")"; })
    .attr("dy", ".60em")
    .attr("font-family", "sans-serif")
    .attr("font-size", "14px")
    .style("text-anchor", "middle")
    .text(function(d) { return d.data; });

var CQDialog = svg.append("text")
    .attr("y", -0.45*CQ.h)
    .attr("x", -0.49*CQ.w);

var CQResult = svg.append("text")
    .style("text-anchor", "middle");


function enqueue() {
    var x = Math.floor(Math.random()*100);
    if (CQ.noElements>=CQ.n) {
	resizeQueue();
    }
    var tail = (CQ.head + CQ.noElements) % CQ.n;
    CQ.data[tail] = x;
    CQ.noElements++;
    CQDialog.text("enqueue("+x+")");
    CQResult
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
    
    svg.select("#CQarc"+tail)
	.select("text")
	.attr("transform", function(d) {return "translate(" + arc.centroid(d) + ")"; })
	.attr("dy", ".60em")
	.attr("font-family", "sans-serif")
	.attr("font-size", "14px")
	.style("text-anchor", "middle")
	.transition()
	.delay(500)
	.duration(250)
	.text(x);
}

function dequeue() {
    CQDialog.text("dequeue( )");
    if (CQ.noElements>0) {
	var x = CQ.data[CQ.head];
	CQ.data[CQ.head] = "null";
	svg.select("#CQarc"+CQ.head)
	    .select("text")
	    .transition()
	    .delay(500)
	    .duration(500)
	    .attr("transform", function(d) {return "translate(" + arc.centroid(d) + ")"; })
	    .attr("dy", ".60em")
	    .attr("font-family", "sans-serif")
	    .attr("font-size", "14px")
	    .style("text-anchor", "middle")
	    .text("null");
	CQResult
	    .transition()
	    .delay(500)
	    .duration(500)
	    .text(x);
	CQ.head++;
	if (CQ.head==CQ.n)
	    CQ.head = 0;
	CQ.noElements--;
    } else {
	CQResult
	    .transition()
	    .delay(500)
	    .duration(500)
	    .text("throw NoSuchElementException");
    }
}

function isEmpty() {
    CQDialog.text("isEmpty()");
    if (CQ.noElements==0) {
	CQResult
	    .transition()
	    .delay(500)
	    .duration(500)
	    .text("true");
    } else {
	CQResult
	    .transition()
	    .delay(500)
	    .duration(500)
	    .text("false");
    }
}

function noItems() {
    CQDialog.text("noItems()");
    CQResult
	.transition()
	.delay(500)
	.duration(500)
	.text(CQ.noElements);
}

function resizeQueue() {
    if (CQ.n>30) {
	CQDialog.text("I'm too big to grow");
    } else {
	var newData = [];
	for (var i =0; i<CQ.noElements; ++i) {
	    newData[i] = CQ.data[CQ.head];
	    CQ.head++;
	    if (CQ.head==CQ.n)
		CQ.head = 0;
	}
	for (var i=CQ.noElements; i<2*CQ.n; ++i) {
	    newData[i] = "null";
	}
	CQ.data = newData;
	CQ.head = 0;
	CQ.n = 2*CQ.n;

	
	svg.selectAll("g.arc").remove();

	arcs = svg.selectAll("g.arc")
	    .data(pie(CQ.data))
	    .enter()
	    .append("g")
	    .attr("class", "arc")
	    .attr("id", function(d,i) { return "CQarc"+i; });

	
	svg.selectAll("g.arc").append("path")
	    .attr("d", arc)
	    .style("stroke", "black")
	    .style("fill", "white");

	svg.selectAll("g.arc").append("text")
	    .attr("transform", function(d) {return "translate(" + arc.centroid(d) + ")"; })
	    .attr("dy", ".60em")
	    .attr("font-family", "sans-serif")
	    .attr("font-size", "14px")
	    .style("text-anchor", "middle")
	    .text(function(d) { return d.data; });

    }
}

function getCapacityLeft() {
    CQDialog.text("getCapacityLeft()");
    CQResult
	.transition()
	.delay(500)
	.duration(500)
	.text((CQ.n-CQ.noElements));
}
