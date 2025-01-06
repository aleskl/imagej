// works well with 8-bit RGB images with lots of light background
// sets background peak to 240 (target)
// takes a background sample from selection, if an area was selected
// background values are measured as a Mode of a channel (not averages)

macro "White balance [w]" {
	target = 240;
	ti = getTitle;
	setBatchMode(true);
	run("RGB Color");

	run("Select None");
	run("Duplicate...", "title=rgbstk-temp");
	run("RGB Stack");

	run("Restore Selection"); // measure background only in selected area
	val = newArray(3);
	for (s=1;s<=3;s++) {
		setSlice(s); 
		val[s-1] = getValue("Mode");
	}

	run("Select None");
	for (s=1;s<=3;s++) {
		setSlice(s);
		dR = target/val[s-1];
		run("Multiply...", "slice value="+dR);
	}

	selectWindow(ti);
	close();
	selectWindow("rgbstk-temp");
	rename(ti);
	run("Convert Stack to RGB");

	setBatchMode(false);
}