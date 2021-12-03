// Add scale bar to image in 1-2-5 series size

scalebarlen = 1; // initial scale bar length
getPixelSize(unit,w,h);
imagewidth = w*getWidth();
print(imagewidth);
print(scalebarlen);

while (scalebarlen < imagewidth/10) {
	scalebarlen = round((scalebarlen*2.3)/(Math.pow(10,(floor(Math.log10(abs(scalebarlen*2.3)))))))*(Math.pow(10,(floor(Math.log10(abs(scalebarlen*2.3))))));
	print(scalebarlen);
}

run("Scale Bar...", "width=&scalebarlen height=10 font=24 color=White background=None location=[Lower Right] bold overlay");
saveAs("jpeg");