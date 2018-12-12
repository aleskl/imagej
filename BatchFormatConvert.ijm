//Fabrice Senger 09/07/09 
//Ales Kladnik 12/12/18
//Adapted from : 
// recursiveTiffConvert.txt 
// Written by Curtis Rueden 
// Last updated on 2008 May 6 

// Recursively converts files using Bio-Formats. 

// It was originally written to convert Gatan DM3 files, but you can easily 
// change the code below to work with any or all extensions of your choice. 

// USER SETTINGS //
ext = "zvi"; // this variable controls the extension of source files 
convertToFormat = "tiff"; // which format to convert to, from the list of ImageJ save as options
includeDirName = false; // set to true if you want to prepend filename with directory name
singleDirOutput = true; // set this to false if you want files ordered in the original directory structure

// CODE //

inDir = getDirectory("Choose directory containing " + ext + " files "); 
outDir = getDirectory("Choose directory for " + convertToFormat + " output "); 
setBatchMode(true); 
processFiles(inDir, outDir, ""); 
print("-- Done --"); 

// recursively process files and directories
function processFiles(inBase, outBase, sub) { 
  
  list = getFileList(inBase + sub); 
  Array.print(list);
  if (!singleDirOutput)
  	File.makeDirectory(outBase + sub); 
  for (i=0; i<list.length; i++) { 
    path = sub + list[i]; 
    // if you run into a directory, go deeper
    if (endsWith(path, "/")) { 
      // recurse into subdirectories 
	  print("going deeper");
      processFiles(inBase, outBase, path); 
    }
    // process only files with selected extension
	else if (endsWith(path, ext)) { 
		print("Processing file: " + path); 
		run("Bio-Formats Importer", "open='" + inBase + path + "' autoscale view=[Standard ImageJ] stack_order=Default"); 
		dir = substring(path, 0, lastIndexOf(path, "/")+1);
		filename = substring(path, lastIndexOf(path, "/")+1, lengthOf(path));
		if (includeDirName) 
			filename = replace(dir, "/", " ") + filename;
		if (singleDirOutput)
			outputFileName = outDir+filename;
		else 
			outputFileName = outDir+dir+filename;
		run("Stack to RGB");
		saveAs(convertToFormat, outputFileName); 
	} 
	else print("Skipping file: " + path);
      
    } 
} 

exit();