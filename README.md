# A collection of ImageJ macros for microscopy images

## BatchFormatConvertAddScaleBar.ijm
Batch conversion of image file types, based on the BatchFormatConvert.ijm, with the addition of an **automatically sized scale bar**. Source images need to be spatially calibrated (eg. images in ZVI format generated by Zeiss Axiovision software have spatial calibration built-in, if it is set-up during image acquisition). The scale bar length is calculated as a 1-2-5 series until it reaches 1/10th of the image width. The 1-2-5 series is calculated as a recursive function, where each previous number is multiplied by 2.3 (or 2.4) and rounded to 1 significant digit.
The updated version uses script parameters for initial setup and has gamma correction. The Windows file separator \ was replaced by File.separator function. You can exclude file formats from processing by listing multiple extensions in the settings dialog.

Download https://github.com/aleskl/imagej/blob/master/BatchFormatConvertAddScaleBar.ijm to your Fiji macros folder and run it from the script editor (you can drag and drop the BatchFormatConvertAddScaleBar.ijm file to the Fiji main window and choose Run). It won't work if you use Install, because it's an Imagej v2 macro.

## WB-modes.ijm
Automatically correct white balance by using the modes of the RGB histograms. Works well in brightfield microscopy images with a large background area. Sampling area for background estimation can be selected before running the macro for more precise results. The macro can be installed via Plugins - Install, and then run on the active image with keyboard shortcut [w].

## White balance.ijm
Another ImageJ macro for setting white balance of brightfield microscopy images - dark object on a white background. A small area of background needs to be selected before running the macro. This is a modification of a macro by Vytas Bindokas (2006) & Patrice Mascalchi (2014). It uses mean values in RGB channels for channel balancing - it is usually better to use WB-modes.ijm macro.

## EqualizeStack.ijm
Normalize brightness of all slices in a stack to the same value. Used this for fluorescence Z-stacks.

## BatchFormatConvert.ijm
Batch convert images between formats supported by Bio-formats importer. The macro will recursively process whole directory with subdirectories. The input and output formats for conversion are set by editing the macro, as well as processing options: you can set the macro to store all converted images in a single directory or in the original directory structure, and you can also choose to prepend the directory name to the filename (this can be useful if you store all converted images in a single directory). When starting the macro you will be asked for the directory with source images and where to store converted files. If you choose the same directory, converted files will be stored alongside originals.

## addScalebar.ijm
A macro to add automatically sized scalebar to the image.
