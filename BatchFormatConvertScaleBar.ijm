// Fabrice Senger 09/07/09 
// Ales Kladnik 08/01/13
// Ales Kladnik 12/12/18 single dir output, convert to format setting
// Ales Kladnik 05/11/21 added auto-scalebar
// Adapted from recursiveTiffConvert.txt by Curtis Rueden

// Recursively converts file format using Bio-Formats. 

// It was originally written to convert Gatan DM3 files, but you can easily 
// change the code to work with any or all extensions of your choice. 

// USER SETTINGS
ext = "zvi"; // this variable controls the extension of source files 
convertToFormat = "jpeg"; // which format to convert to, from the list of ImageJ save as options
includeDirName = false; // set to true if you want to prepend filename with directory name
singleDirOutput = false; // set this to false if you want files ordered in the original directory structure
addscalebar = true; // add automatical scalebar to output image, works if the source images have spatial calibration
scalebarsettings = "height=10 font=24 color=White background=None location=[Lower Right] bold overlay"; // set the appearance of scalebar

// CODE //
inDir = getDirectory("Choose directory containing " + ext + " files "); 
outDir = getDirectory("Choose directory for " + convertToFormat + " output "); 
setBatchMode(true); 
File.makeDirectory(outDir);
processFiles(inDir, outDir, ""); 
print("-- Done --"); 

// recursively process files and directories
function processFiles(inBase, outBase, sub) { 
  
  list = getFileList(inBase + sub); 
  if (!singleDirOutput)
  	File.makeDirectory(outBase + sub); 
  for (i=0; i<list.length; i++) { 
    path = sub + list[i]; 
    if (endsWith(path, "/")) { 
      // recurse into subdirectories 
	  print("-- going deeper --");
      processFiles(inBase, outBase, path); 
    }
    // process only files with selected extension
	else if (endsWith(path, ext)) { 
		print("Processing file: " + path); 
		run("Bio-Formats Importer", "open='" + inBase + path + "' autoscale view=[Standard ImageJ] stack_order=Default"); 

		dir = substring(path, 0, lastIndexOf(path, "/")+1);
		filename = substring(path, lastIndexOf(path, "/")+1, lengthOf(path));
		if (includeDirName) 
			filename = replace(dir, "/", "_") + filename;
		if (singleDirOutput)
			outputFileName = outDir+filename;
		else 
			outputFileName = outDir+dir+filename;
		run("Stack to RGB");

		if (addscalebar) {
			scalebarlen = 1; // initial scale bar length
			getPixelSize(unit,w,h);
			imagewidth = w*getWidth();
			while (scalebarlen < imagewidth/10) {
				scalebarlen = round((scalebarlen*2.3)/(Math.pow(10,(floor(Math.log10(abs(scalebarlen*2.3)))))))*(Math.pow(10,(floor(Math.log10(abs(scalebarlen*2.3))))));
			} // recursively calculate a 1, 2, 5 series until the scalebar length reaches 1/10th of image width
			run("Scale Bar...", "width=&scalebarlen "+scalebarsettings);
		}

		saveAs(convertToFormat, outputFileName); 
	} 
	else print("Skipping file: " + path);
      
    } 
} 

exit();