macro "White balance [w]" {
	ti=getTitle;
	run("Select None");
	setBatchMode(true);
	run("RGB Color");

	run("Duplicate...", "title=rgbstk-temp");
	run("RGB Stack");

	val = newArray(3);
	for (s=1;s<=3;s++) {
		setSlice(s);
		List.setMeasurements; 
		val[s-1] = List.getValue("Mode");
	}

	for (s=1;s<=3;s++) {
		setSlice(s);
		dR=230/val[s-1];
		run("Multiply...", "slice value="+dR);
	}

	run("Convert Stack to RGB");
	selectWindow(ti);
	close();
	selectWindow("rgbstk-temp (RGB)");
	rename(ti);

	setBatchMode(false);
}