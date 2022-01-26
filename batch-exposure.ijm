/*
 * Macro template to process multiple images in a folder
 */

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".jpg") suffix

// See also Process_Folder.py for a version of this code
// in the Python scripting language.

processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		showProgress(-i/list.length);
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder(input + File.separator + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, output, list[i]);
	}
}

function processFile(input, output, file) {
	// Do the processing here by adding your own code.
	// Leave the print statements until things work, then remove them.
	print("Processing: " + input + File.separator + file);
	open(input + File.separator + file);
	run("Select None");
	
	// exposure
	while (selectionType()!=0) {
		setTool("rectangle");
		waitForUser("Draw a neutral rectangle");
	}
	target = 70;
	ti = getTitle;
	setBatchMode(true);
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

	print("Saving to: " + output);
	saveAs("tif", output + File.separator + file + ".tif");
	close("*");
	setBatchMode(false);
}