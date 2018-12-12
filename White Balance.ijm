// This macro white balances RGB to a selected region (equal R,G,B =gray)
// Draw a selection around a backrground region prior to running the macro
// 
// White balance is adjusted by multiplication of a channel with the
// ratio between the channel average with the mean of all channels.
//  
// Vytas Bindokas; Oct 2006, Univ. of Chicago
// Modified by Patrice Mascalchi, 2014, Univ. of Cambridge UK
// published at: http://www.lightmicroscopy.cruk.cam.ac.uk/?p=627
// Modified by Ales Kladnik, 2016, Univ. of Ljubljana, Slovenia (modified additive to multiplicative adjustment)

macro "White balance [w]" {
	if (selectionType==-1) exit("you must draw a region first");
	run("Set Measurements...", "  mean redirect=None decimal=3");

	ti=getTitle;
	run("Select None");
	setBatchMode(true);
	run("RGB Color");

	run("Duplicate...", "title=rgbstk-temp");
	run("RGB Stack");
	run("Restore Selection");
	val = newArray(3);
	for (s=1;s<=3;s++) {
		setSlice(s);
		run("Measure");
		val[s-1] = getResult("Mean");
	}
	run("Select None");

	run("16-bit");
	run("32-bit");
	Array.getStatistics(val, min, max, mean);

	for (s=1;s<=3;s++) {
		setSlice(s);
		dR=mean/val[s-1];
		run("Multiply...", "slice value="+dR);
	}

	run("16-bit");
	run("Convert Stack to RGB");
	selectWindow("Results");
	run("Close");
	selectWindow(ti);
	close();
	selectWindow("rgbstk-temp (RGB)");
	rename(ti);

	setBatchMode(false);
}