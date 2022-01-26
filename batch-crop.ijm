/*
 * Macro template to process multiple images in a folder
 */

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".jpg") suffix

waitForUser("Draw a cropping rectangle and press Space");

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
		while (!isKeyDown("space")) {
		    wait(10);
		}
		//waitForUser("Draw a cropping rectangle");
	}
	run("Crop");
	print("Saving to: " + output);
	saveAs("tif", output + File.separator + file + ".tif");
	close("*");
}