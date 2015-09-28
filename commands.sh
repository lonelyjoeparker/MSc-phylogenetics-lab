#! /usr/bin/bash

#####################################
#									#
#	These are the commands you		#
#	should be able to use to		#
#	finish today's lab session.		#
#									#
#	If you have any problems 		#
#	check you have entered the		#
#	commands exactly, then if 		#
#	in doubt, ask an instructor.	#
#									#
#####################################


## Part 1 ##
# You'll need to be in the directory '~/Desktop/phylogenetics/part_1'

# building a tree - first go
muscle -in orchids.short.initial.fa -out orchids.short.out -maxiters 2
# (view output in CONTEXT graphical user interface (GUI)
# (either close it once you're done and reopen when you need to)
# (or leave it open if the Pi isn't running _too_ slowly)
java -jar ../software/CONTEXT-PhylogenomicDatasetBrowser-v0.8.1.jar
# convert muscle output to phylip format for RAxML
java -jar ../software/PrepareFilesForPaml.jar orchids.short.out
# build a phylogeny in RAxML
../software/raxmlHPC -m GTRCAT -n orchids.short.initial -p 1  -s orchids.short.out.stops.removed.phy 
# (view output in FigTree GUI)
# (either close it once you're done and reopen when you need to)
# (or leave it open if the Pi isn't running _too_ slowly)
java -jar ../software/figtree.jar

# building a tree - second go after removing the rogue/contaminant sequence
muscle -in orchids.short.filtered.fa -out orchids.short.filtered.out -maxiters 2
# (view output in CONTEXT GUI)
# convert muscle output to phylip format for RAxML
java -jar ../software/PrepareFilesForPaml.jar orchids.short.filtered.out 
# build a phylogeny in RAxML
../software/raxmlHPC -m GTRCAT -n orchids.short.filtered -p 111  -s orchids.short.filtered.out.stops.removed.phy 
# (view output in FigTree GUI)


## Part 2 ##
# You'll need to be in the directory '~/Desktop/phylogenetics/part_2'

# building a tree, genus A
muscle
java -jar PrepareFilesForPaml.jar
raxmlHPC
# (view output in FigTree GUI)

# building a tree, genus B
muscle
java -jar PrepareFilesForPaml.jar
raxmlHPC
# (view output in FigTree GUI)

# (running the BEAST MCMC)
#java -jar beast.jar mc.paml_MCMC_slow.xml


## Part 3 ##
# You'll need to be in the directory '~/Desktop/phylogenetics/part_3'