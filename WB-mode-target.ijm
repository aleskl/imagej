macro "White balance [w]" {
	target = 70;
	ti = getTitle;
	//setBatchMode(true);
	run("RGB Color");

	run("Select None");
	run("Duplicate...", "title=rgbstk-temp");
	run("RGB Stack");

	run("Restore Selection");
	val = newArray(3);
	for (s=1;s<=3;s++) {
		setSlice(s); 
		val[s-1] = getValue("Mode");
	}
	Array.show(val);

	run("Select None");
	for (s=1;s<=3;s++) {
		setSlice(s);
		dR = target/val[s-1];
		run("Multiply...", "slice value="+dR);
	}

	run("Convert Stack to RGB");
	selectWindow(ti);
	close();
	selectWindow("rgbstk-temp (RGB)");
	rename(ti);

	//setBatchMode(false);
}