// Equalize images in stack to the same brightness.
// Use a normal stack, virtual stack is not working
// Select an empty region first, images will be normalized to the mean of selection
// Modified by Ales Kladnik, 2017, Univ. of Ljubljana, Slovenia


macro "Equalize stack" {
	if (nSlices==0) exit("open a stack");
	if (selectionType==-1) exit("draw a sample region first");
    getRawStatistics(dummy, targetmean, dummy, dummy, dummy, dummy2);

	setBatchMode(true);
	 
	total = 0;
	for (i = 1; i <= nSlices; i++) {
	    setSlice(i);
	    getRawStatistics(dummy, mean, dummy, dummy, dummy, dummy2);
	    ratio = targetmean/mean;
	    //print(i,mean,ratio);
		run("Select None");
	    run("Multiply...", "value=" + ratio);
	    run("Restore Selection");
	}
	 
	setBatchMode(false);
}