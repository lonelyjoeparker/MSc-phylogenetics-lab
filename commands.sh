#! /bin/bash

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

## The files needed for this practical 
## are also available at 
## https://github.com/lonelyjoeparker/MSc-phylogenetics-lab


## Part 1 ##
# You'll need to be in the directory '~/Desktop/phylogenetics/part_1'

# (view output in CONTEXT graphical user interface (GUI)
# (either close it once you're done and reopen when you need to)
# (or leave it open if the Pi isn't running _too_ slowly)
java -jar ../software/CONTEXT-PhylogenomicDatasetBrowser-v0.8.1.jar
# building a tree - first go
muscle -in orchids.short.initial.fa -out orchids.short.out -maxiters 2
# (view output in CONTEXT graphical user interface (GUI))
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
muscle -in genus_A_master_ungapped.fa -out genus_A_aligned.out  -maxiters 2
java -jar PrepareFilesForPaml.jar genus_A_aligned.out
../software/raxmlHPC -m GTRCAT -n genus_A -p 222  -s genus_A_aligned.out.stops.removed.phy 
# (view output in FigTree GUI)

# building a tree, genus B
muscle -in genus_B_master_ungapped.fa -out genus_B_aligned.out  -maxiters 2
java -jar PrepareFilesForPaml.jar
../software/raxmlHPC -m GTRCAT -n genus_B -p 2222  -s genus_B_aligned.out.stops.removed.phy 
# (view output in FigTree GUI)

# (running the BEAST MCMC)
#java -jar beast.jar mc.paml_MCMC_slow.xml

# (look at output in Tracer GUI)
#java -jar tracer.jar

# (look at output dated tree in FigTree GUI)


## Part 3 ##
# You'll need to be in the directory '~/Desktop/phylogenetics/part_3'
# building a tree, genus A
muscle -in Trich_ITS.NXS.short.fa -out Trich_ITS.aligned.fa  -maxiters 2
java -jar PrepareFilesForPaml.jar Trich_ITS.aligned.fa 
../software/raxmlHPC -m GTRCAT -n Trich_ITS -p 333  -s Trich_ITS.aligned.fa.stops.removed.phy 
# (view output in FigTree GUI)
