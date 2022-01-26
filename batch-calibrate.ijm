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
	
	// scaling
	run("Select None");
	while (selectionType()!=5) {
		setTool("line");
		waitForUser("Draw a line for 10 cm");
	}
	run("Measure");
	length = getResult("Length");
	run("Set Scale...", "distance=" + length + " known=100 unit=mm");

	// rotation
	run("Select None");
	while (selectionType()!=5) {
		setTool("line");
		waitForUser("Draw a line that has to be vertical");
	}
	run("Measure");
	angle = getResult("Angle") - 90;
	run("Rotate... ", "angle=" + angle + " interpolation=Bicubic enlarge");

	// scaling to 10px per unit (mm)
	var p1=1;
	toScaled(p1);
	ratio = 10 * p1; 
	run("Scale...", "x="+ratio+" y="+ratio+" interpolation=Bicubic average create");
	
	print("Saving to: " + output);
	run("Select None");
	run("Remove Overlay");
	saveAs("tif", output + File.separator + file + ".tif");
	close("*");
}