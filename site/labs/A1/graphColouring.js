
var GC = {
    w:400,
    h:400,
    n:6,
    k:3,
    p:0.6,
    count:0
};

function makeGraph() {
    var nodes = [];
    GC.colouring = [];
    for(var i=0; i<GC.n; ++i) {
	nodes[i] = {name: i};
	GC.colouring[i] = 0;
    }
    var edges = [];
    for(var i=1; i<GC.n; ++i) {
	for(var j=0; j<i; ++j) {
	    if(Math.random() < GC.p) {
		edges.push({source:i, target:j});
	    }
	}
    }
    GC.dataset = {nodes:nodes, edges:edges};
}

makeGraph();

var colours = d3.scale.category10();

GC.force = d3.layout.force()
    .nodes(GC.dataset.nodes)
    .links(GC.dataset.edges)
    .size([GC.w,GC.h])
    .linkDistance([100])
    .charge([-300])
    .start();

GC.svg = d3.select("#graphColouring")
    .append("svg")
    .attr("width", GC.w)
    .attr("height", GC.h+50);
//    .append("g")
//    .attr("transform", "translate(" + GC.h/2 + "," + (GC.h/2) + ")");


GC.edges = GC.svg.selectAll("line")
    .data(GC.dataset.edges)
    .enter()
    .append("line")
    .style("stroke", "#ccc")
    .style("strokewidth", 1);

GC.nodes = GC.svg.selectAll("circle")
    .data(GC.dataset.nodes)
    .enter()
    .append("circle")
    .attr("r", 10)
    .style("fill", function(d, i) {
	return colours(GC.colouring[i]);
    })
    .call(GC.force.drag);


GC.Dialog = GC.svg.append("text")
    .attr("y", GC.h+25)
    .attr("x", 0.5*GC.w)
    .style("text-anchor", "middle");


GC.force.on("tick", function() {
    GC.edges
	.attr("x1", function(d) {return d.source.x;})
	.attr("y1", function(d) {return d.source.y;})
	.attr("x2", function(d) {return d.target.x;})
	.attr("y2", function(d) {return d.target.y;});

    GC.nodes
	.attr("cx", function(d) {return d.x;})
	.attr("cy", function(d) {return d.y;});
});

function updateColouring(colouring, index) {
     if (colouring[index] < GC.k-1) {
	colouring[index]++;
	showColouring();
	updateColouring(colouring, 0);
    } else {
	colouring[index] = 0;
	if (index==GC.n-2) {
	    return;
	}
	updateColouring(colouring, index+1)
    }
}


function showColouring() {
    GC.nodes
	.transition()
        .delay(200*GC.count)
	.style("fill", function(d, i) {
	    return colours(GC.colouring[i]);
	});
    var cost = 0;
    GC.edges
	.transition()
        .delay(200*GC.count)
	.style("stroke", function(d) {
	    if (GC.colouring[d.source.name]==GC.colouring[d.target.name]) {
		cost++;
		return "#f00";
	    } else {
		return "#ccc";
	    }
	});
    GC.Dialog
	.transition()
        .delay(200*GC.count)
	.text("cost = " + cost);
    if (cost<GC.minCost) {
	GC.minCost = cost;
	GC.bestColouring = GC.colouring.slice(0);
    }
    GC.count++;
}


function solve() {
    GC.minCost = 100;
    GC.count = 0;
    for(var i=0; i<GC.n; ++i) {
	GC.colouring[i] = 0;
    }
    updateColouring(GC.colouring, 0);
    GC.colouring = GC.bestColouring.slice(0);
    showColouring();
};




