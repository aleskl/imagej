# A collection of ImageJ macros for microscopy images

## White balance.ijm
ImageJ macro for setting white balance of brightfield microscopy images - dark object on a white background. A small area of background needs to be selected before running the macro. This is a modification of a macro by Vytas Bindokas (2006) & Patrice Mascalchi (2014).

## WB-modes.ijm
An attempt to automatically correct white balance by using the modes of the RGB histograms. Works well in brightfield microscopy images with a large background area.

## EqualizeStack.ijm
Normalize brightness of all slices in a stack to the same value. Used this for fluorescence Z-stacks.

## BatchFormatConvert.ijm
Batch convert images between formats supported by Bio-formats importer. The macro will recursively process whole directory with subdirectories. The input and output formats for conversion are set by editing the macro, as well as processing options: you can set the macro to store all converted images in a single directory or in the original directory structure, and you can also choose to prepend the directory name to the filename (this can be useful if you store all converted images in a single directory). When starting the macro you will be asked for the directory with source images and where to store converted files. If you choose the same directory, converted files will be stored alongside originals.
