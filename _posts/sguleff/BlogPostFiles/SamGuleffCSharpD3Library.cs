//Code to generate HTML, JSON, Javascrip, and csv files needed for various D3 datacharts that I want (namely Chord Charts and Dynamic Bar Charts)
//Code by Sam Guelff for EDAV STATW4701 Columbia University Spring 2015
//Code can be used as is with out any attribution
//I would recommend refactoring of many of the methods below.

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace eDVA
{
    //main windows form
    public partial class Form1 : Form
    {
        //mydatastore, colorselection, nodeWeights, and overallDistribution data.
        private dataStore myData;
        private goodColors myColors;
        private DataTable DistributionData;
        private Dictionary<String, float> nodeWeights;

        //initialize the data but do nothing.
        public Form1()
        {
            InitializeComponent();
            myData = new dataStore();
            myColors = new goodColors();
            nodeWeights = new Dictionary<string, float>();
        }

        //run the code
        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                myData = new dataStore(); //reset
                myColors = new goodColors(); //reset

                //do the chordgraph
                readData(); //read tsv with data into a datatable for processing
                BuildWeights(); //crudely read the weights of the nodes for access later
                addData(); //build out the data in memory 
                outputChordData(); //format and write to file

                //build a bargraph
                buildBar(); //format and write to file

            }
            catch (Exception exp)
            {
                MessageBox.Show("There was an error" + exp.Message);
            }
            MessageBox.Show("Done");
        }

        //methods below are for tsv to datatable
        private void readData()
        {
            //Read tsv into a datatable for processing
            var filename = "FinalWineDistributionData.tsv";
            var reader = ReadAsLines(filename);
            var data = new DataTable();

            //this assume the first record is filled with the column names
            var headers = reader.First().Split('\t');
            foreach (var header in headers)
                data.Columns.Add(header);
            var records = reader.Skip(1);
            foreach (var record in records)
                data.Rows.Add(record.Split('\t'));
            DistributionData = data;
        }
        static IEnumerable<string> ReadAsLines(string filename)
        {
            using (var reader = new StreamReader(filename))
                while (!reader.EndOfStream)
                    yield return reader.ReadLine();
        }

        //final output data
        private void outputChordData()
        {
            //generate the CSV file with names and appropriate colors
            String csvFile = "name,color" + "\r\n";
            List<String> nodeOrdered = new List<string>();

            foreach (eDVA.Location loc in myData.storedData)
            {
                nodeOrdered.Add(loc.Name);
                csvFile += loc.Name + "," + loc.hexColor + "\r\n";
            }

            //write the file
            System.IO.File.WriteAllText(@"chordChart.csv", csvFile);

            //now for the json file output
            String jsonFile = "[";
            foreach (eDVA.Location loc in myData.storedData)
            {
                jsonFile += "[";
                foreach (String str in nodeOrdered)
                {
                    if (loc.connections.ContainsKey(str))
                        jsonFile += Convert.ToString(loc.connections[str] * loc.LocationWeight) + ",";
                    else
                        jsonFile += Convert.ToString(0) + ",";

                }
                jsonFile = jsonFile.TrimEnd(',');
                jsonFile += "],";

            }
            jsonFile = jsonFile.TrimEnd(',');
            jsonFile += "]";

            System.IO.File.WriteAllText(@"chordChart.json", jsonFile);

            //html with propoper formating
            System.IO.File.WriteAllText(@"chordChart.html", htmlgen.chordPage.Replace("ZZZZZZZ", "test.csv").Replace("YYYYYYY", "test.json"));
        }
        public void buildBar()
        {
            string barData = "";
            barData += "Country" + "\t" + "WineProduction" + "\r\n";
            foreach (KeyValuePair<string, float> kvp in nodeWeights)
            {
                barData += kvp.Key.ToString() + "\t" + (kvp.Value * 270864000).ToString() + "\r\n";

            }

            System.IO.File.WriteAllText(@"barChart.tsv", barData);
            System.IO.File.WriteAllText(@"barChart.html", htmlgen.barplotPage.Replace("ZZZZZZZ", "barChart.tsv").Replace("YYYYYYY", "WineProduction").Replace("XXXXXXX", "Country"));

        }

        //crude can read from file later
        private void BuildWeights()
        {
            nodeWeights.Add("France",.17f);
            nodeWeights.Add("Italy",.164f);
            nodeWeights.Add("Spain",.137f);
            nodeWeights.Add("United States",.083f);
            nodeWeights.Add("Argentina",.056f);
            nodeWeights.Add("Australia",.043f);
            nodeWeights.Add("China",.042f);
            nodeWeights.Add("South Africa",.042f);
            nodeWeights.Add("Chile",.037f);
            nodeWeights.Add("Germany",.036f);
        }

        //build dataset
        private void addData()
        {
            String ColorSet = "DivSetC";
            String EUColors = myColors.getNextColor(ColorSet);
            

            eDVA.Location loc = null;

            HashSet<String> allNodes = new HashSet<string>(); // will need this to check for missing nodes in the rows and add
            for (int i = 1; i < DistributionData.Columns.Count; ++i)
            {
                String Nodename = DistributionData.Columns[i].Caption;
                allNodes.Add(Nodename);
                loc = new Location(Nodename, myColors.getNextColor(ColorSet), myData.storedData);
                loc.LocationWeight = nodeWeights[Nodename];

                //need to discout weights for domestic consumption
                var percentDomestic = 0f;
                foreach (DataRow dr in DistributionData.Rows)
                {
                    if (dr[0].ToString() == Nodename)
                    {
                        percentDomestic = float.Parse(dr[i].ToString());
                        break;
                    }
                }


                foreach (DataRow dr in DistributionData.Rows)
                {
                    if (dr[0].ToString() != Nodename)
                        loc.addConnection(dr[0].ToString(), (1 - percentDomestic) * float.Parse(dr[i].ToString()));
                    else
                        loc.addConnection(dr[0].ToString(), float.Parse(dr[i].ToString()));
                }

                myData.storedData.Add(loc);

            }

            foreach (DataRow dr in DistributionData.Rows)
            {
                String testNode = dr[0].ToString();
                if (!allNodes.Contains(testNode))
                {
                    loc = new Location(testNode, myColors.getNextColor(ColorSet), myData.storedData);
                    //NEED TO LOOP TO SELF SO THERE'S WEIGHT ON THE GRAPH
                    loc.LocationWeight = .01f; //TODO what should this be test
                    loc.addConnection(testNode, 1);
                    myData.storedData.Add(loc);
                }
                
            }

            //LegacyMethod(ColorSet, EUColors, ref percentDomestic, ref loc);

        }

    }


    /// <summary>
    /// In memory store of all location data for manipulation to json
    /// </summary>
    public class dataStore
    {
        //public data accessor
        public List<eDVA.Location> storedData;

        //defult contructor
        public dataStore()
        {
            storedData = new List<eDVA.Location>();
        }

    }

    //Location data with list of all connections and relative distributions to those connections
    public class Location
    {
        public String Name;
        public String hexColor;
        public float LocationWeight;
        public List<Location> _Owner;
        public Dictionary<String, float> connections;

        public void addConnection(string name, float percent)
        {
            connections.Add(name, percent);
        }

        public Location(string Name, String hexColor, List<Location> _Owner)
        {
            this._Owner = _Owner;
            this.Name = Name;
            this.hexColor = hexColor;
            connections = new Dictionary<string, float>();
        }

    }


    //code to generate the json and html needed to render the charts
    public static class htmlgen
    {
        //Generate a Chordplot
        //replace ZZZZZZZ in string with test.csv
        //replace YYYYYYY in string with test.json
        #region chordpagecode

        public static string chordPage = @"
<!DOCTYPE html>
<html class=""testy"">
<meta charset=""utf-8"">
<title>My Chart</title>
<style>


#circle circle {
  fill: none;
  pointer-events: all;
}

.group path {
  fill-opacity: .5;
}

path.chord {
  stroke: #000;
  stroke-width: .25px;
}

#circle:hover path.fade {
  display: none;
}

</style>

<header>

</header>

<script src=""http://d3js.org/d3.v2.min.js?2.8.1""></script>
<script>

var width = 800,
    height = 800,
    outerRadius = Math.min(width, height) / 2 - 10,
    innerRadius = outerRadius - 24;

var formatPercent = d3.format("".1%"");

var arc = d3.svg.arc()
    .innerRadius(innerRadius)
    .outerRadius(outerRadius);

var layout = d3.layout.chord()
    .padding(.04)
    .sortSubgroups(d3.descending)
    .sortChords(d3.ascending);

var path = d3.svg.chord()
    .radius(innerRadius);

var svg = d3.select(""body"").append(""svg"")
    .attr(""width"", width)
    .attr(""height"", height)
  .append(""g"")
    .attr(""id"", ""circle"")
    .attr(""transform"", ""translate("" + width / 2 + "","" + height / 2 + "")"");

svg.append(""circle"")
    .attr(""r"", outerRadius);

d3.csv(""ZZZZZZZ"", function(cities) {
  d3.json(""YYYYYYY"", function(matrix) {

    // Compute the chord layout.
    layout.matrix(matrix);

    // Add a group per neighborhood.
    var group = svg.selectAll("".group"")
        .data(layout.groups)
      .enter().append(""g"")
        .attr(""class"", ""group"")
        .on(""mouseover"", mouseover);

    // Add a mouseover title.
    group.append(""title"").text(function(d, i) {
      return cities[i].name + "": "" + formatPercent(d.value) + "" of origins"";
    });

    // Add the group arc.
    var groupPath = group.append(""path"")
        .attr(""id"", function(d, i) { return ""group"" + i; })
        .attr(""d"", arc)
        .style(""fill"", function(d, i) { return cities[i].color; });

    // Add a text label.
    var groupText = group.append(""text"")
        .attr(""x"", 6)
        .attr(""dy"", 15);

    groupText.append(""textPath"")
        .attr(""xlink:href"", function(d, i) { return ""#group"" + i; })
        .text(function(d, i) { return cities[i].name; });

    // Remove the labels that don't fit. :(
    groupText.filter(function(d, i) { return groupPath[0][i].getTotalLength() / 2 - 16 < this.getComputedTextLength(); })
        .remove();

    // Add the chords.
    var chord = svg.selectAll("".chord"")
        .data(layout.chords)
      .enter().append(""path"")
        .attr(""class"", ""chord"")
        .style(""fill"", function(d) { return cities[d.source.index].color; })
        .attr(""d"", path);

    // Add an elaborate mouseover title for each chord.
    chord.append(""title"").text(function(d) {
      return cities[d.source.index].name
          + "" → "" + cities[d.target.index].name
          + "": "" + formatPercent(d.source.value)
          + ""\n"" + cities[d.target.index].name
          + "" → "" + cities[d.source.index].name
          + "": "" + formatPercent(d.target.value);
    });

    function mouseover(d, i) {
      chord.classed(""fade"", function(p) {
        return p.source.index != i
            && p.target.index != i;
      });
    }
  });
});

</script>
";
        #endregion

        //generate a barplot
        //replace ZZZZZZZ in string with barChart.tsv
        //replace YYYYYYY in string with Y-Axis name
        //replace XXXXXXX in string with X-Axis name
        #region dynamicBar
        public static string barplotPage = @"
<!DOCTYPE html>
<meta charset=""utf-8"">
<style>

body {
  font-family: ""Helvetica Neue"", Helvetica, Arial, sans-serif;
  position: relative;
  width: 960px;
}

.axis text {
  font: 10px sans-serif;
}

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.bar {
  fill: steelblue;
  fill-opacity: .9;
}

.x.axis path {
  display: none;
}

label {
  position: absolute;
  top: 10px;
  right: 10px;
}

</style>
<label><input type=""checkbox""> Sort By Production</label>
<script src=""http://d3js.org/d3.v3.min.js""></script>
<script>

var margin = {top: 20, right: 20, bottom: 30, left: 60},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var formatPercent = d3.format("".0"");

var x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1, 1);

var y = d3.scale.linear()
    .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient(""bottom"");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient(""left"")
    .tickFormat(formatPercent);

var svg = d3.select(""body"").append(""svg"")
    .attr(""width"", width + margin.left + margin.right)
    .attr(""height"", height + margin.top + margin.bottom)
  .append(""g"")
    .attr(""transform"", ""translate("" + margin.left + "","" + margin.top + "")"");

d3.tsv(""ZZZZZZZ"", function(error, data) {

  data.forEach(function(d) {
    d.YYYYYYY = +d.YYYYYYY;
  });

  x.domain(data.map(function(d) { return d.XXXXXXX; }));
  y.domain([0, d3.max(data, function(d) { return d.YYYYYYY; })]);

  svg.append(""g"")
      .attr(""class"", ""x axis"")
      .attr(""transform"", ""translate(0,"" + height + "")"")
      .call(xAxis);

  svg.append(""g"")
      .attr(""class"", ""y axis"")
      .call(yAxis)
    .append(""text"")
      .attr(""transform"", ""rotate(-90)"")
      .attr(""y"", 6)
      .attr(""dy"", "".71em"")
      .style(""text-anchor"", ""end"")
      .text(""YYYYYYY"");

  svg.selectAll("".bar"")
      .data(data)
    .enter().append(""rect"")
      .attr(""class"", ""bar"")
      .attr(""x"", function(d) { return x(d.XXXXXXX); })
      .attr(""width"", x.rangeBand())
      .attr(""y"", function(d) { return y(d.YYYYYYY); })
      .attr(""height"", function(d) { return height - y(d.YYYYYYY); });

  d3.select(""input"").on(""change"", change);

  var sortTimeout = setTimeout(function() {
    d3.select(""input"").property(""checked"", true).each(change);
  }, 2000);

  function change() {
    clearTimeout(sortTimeout);

    // Copy-on-write since tweens are evaluated after a delay.
    var x0 = x.domain(data.sort(this.checked
        ? function(a, b) { return b.YYYYYYY - a.YYYYYYY; }
        : function(a, b) { return d3.ascending(a.XXXXXXX, b.XXXXXXX); })
        .map(function(d) { return d.XXXXXXX; }))
        .copy();

    svg.selectAll("".bar"")
        .sort(function(a, b) { return x0(a.XXXXXXX) - x0(b.XXXXXXX); });

    var transition = svg.transition().duration(750),
        delay = function(d, i) { return i * 50; };

    transition.selectAll("".bar"")
        .delay(delay)
        .attr(""x"", function(d) { return x0(d.XXXXXXX); });

    transition.select("".x.axis"")
        .call(xAxis)
      .selectAll(""g"")
        .delay(delay);
  }
});
</script>
";
        #endregion

    }

    //class to retrieve a color set from  ColorBrewer and automatically pick the next value in the List.
    public class goodColors
    {
        private int setAi, setBi, DivSetCi, QualsetAi;

        public goodColors()
        {
            DivSetCi = setBi = setAi = QualsetAi = 0;
        }

        public string getNextColor(string setSelect)
        {
            string ret = "#CCCCCC";
            switch (setSelect)
            {
                case "SetA":
                    if (setAi == SetA.Count)
                        setAi = 0;
                    ret =  SetA[setAi];
                    setAi++;
                break;
                case "SetB":
                    if (setBi < SetB.Count)
                        ret = SetB[setBi];
                    setBi++;
                break;
                case "DivSetC":
                    if (DivSetCi < DivSetC.Count)
                        ret = DivSetC[DivSetCi];
                    DivSetCi++;
                break;
                case "QualsetA":
                    if (QualsetAi < QualsetA.Count)
                        ret = DivSetC[QualsetAi];
                    QualsetAi++;
                break;


            }

            return ret;
        }

        public static List<String> SetA = new List<string>() { "#f7fcf0", "#e0f3db", "#ccebc5", "#a8ddb5", "#7bccc4", "#4eb3d3", "#2b8cbe", "#0868ac", "#084081" };
        public static List<String> SetB = new List<string>() { "#ffffd9", "#edf8b1", "#c7e9b4", "#7fcdbb", "#41b6c4", "#1d91c0", "#225ea8", "#253494", "#081d58" };
        public static List<String> DivSetC = new List<string>() { "#67001f", "#b2182b", "#d6604d", "#f4a582", "#fddbc7", "#f7f7f7", "#d1e5f0", "#92c5de", "#4393c3", "#2166ac", "#053061" };
         public static List<String> QualsetA = new List<string>() {"#a6cee3", "#1f78b4","#b2df8a","#33a02c","#fb9a99","#e31a1c","#fdbf6f","#ff7f00","#cab2d6","#6a3d9a","#ffff99","#b15928"};

    }

}

