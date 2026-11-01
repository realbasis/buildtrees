// JavaScript Document Banner
function runBanner() {

var currentdate = 0;
var core = 0;

function initArray() {

this.length = initArray.arguments.length;
  for (var i = 0; i < this.length; i++) {
  this[i] = initArray.arguments[i];
  }
}

link = new initArray(
"http://www.lamineba.com/",
"http://www.yahoo.com/",
"http://www.jspin.com/"
);

image = new initArray(
"/RbJobs/images/careers.gif",
"/RbJobs/images/employer.gif",
"/RbJobs/images/balboa.png"
);

text = new initArray(
"Lamine Web Page",
"Yahoo Link",
"Jspin"
);

var currentdate = new Date();
var core = currentdate.getSeconds() % image.length;
var ranlink  = link[core];
var ranimage = image[core];
var rantext  = text[core];

document.write('<a href=\"' +ranlink+ '\" target=\"_blank\"><img src=\"'+ranimage+'\" border="0" alt=\"'+rantext+'\"></a>');

}