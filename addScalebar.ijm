// Add scale bar to image in 1-2-5 series size
// and saves the labeled image as JPEG

// set the appearance of scalebar
scalebarsettings = "height=10 font=24 color=White background=None location=[Lower Right] bold overlay"; 
scalebarsize = 0.1; // approximate size of the scale bar relative to image width

getPixelSize(unit,w,h);
if (unit == "pixels") exit("Image not spatially calibrated");

imagewidth = w*getWidth();  // image width in measurement units
scalebarlen = 1; // initial scale bar length in measurement units

// recursively calculate a 1-2-5 series until the length reaches scalebarsize, default to 1/10th of image width
// 1-2-5 series is calculated by repeated multiplication with 2.3, rounded to one significant digit
while (scalebarlen < imagewidth * scalebarsize) {
	scalebarlen = round((scalebarlen*2.3)/(Math.pow(10,(floor(Math.log10(abs(scalebarlen*2.3)))))))*(Math.pow(10,(floor(Math.log10(abs(scalebarlen*2.3))))));
}

run("Scale Bar...", "width=&scalebarlen "+scalebarsettings);
saveAs("jpeg");
