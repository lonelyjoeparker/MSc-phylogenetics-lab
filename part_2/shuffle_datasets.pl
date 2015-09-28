#! /usr/bin/perl
# simple script to shuffle tips in an alignment a random number of times in (2...5)
use File::Copy;

$replicate_datasets = 10;	# number of students to generate

#open the original input alignment
open(IN,$ARGV[0]);

#hold the sequences and tips in order
@original_sequences;
@original_tips;

#read in the alignment
while(<IN>){
	chomp($line = $_);
	if($line =~ />/){
		#this is a tip name, add it to the tip array
		push(@original_tips,$line);
	}else{
		#this is a sequence, add it to the sequence array
		push(@original_sequences,$line);
	}
}

close(IN);

#for each of $replicate_datasets
for($student=0;$student<$replicate_datasets;$student++){
	#make a subdir
	$student_dir = './student_files/student_'.$student;
	mkdir($student_dir);
	#copy the genus A alignment into it
	copy($ARGV[0],$student_dir."/".$ARGV[0]) or die("could not copy [./genus_A_master/".$ARGV[0]."] to [".$student_dir."/".$ARGV[0]."] $!\n");
	#random int for number of shuffles between [3...7)
	$shuffles = 0;
	while($shuffles<2){
		$shuffles = int(rand(7));
	}
	print "making $shuffles tip shuffles for student $student\n";
	#fisher-yates copy shuffle 
	@shuffled_tips;
	@indices = 0..scalar(@original_tips);
	for($swap=0;$swap<$shuffles;$swap++){
		$swap_index_A = int(rand(scalar(@indices)));
		$swap_index_B = $swap_index_A;
		while($swap_index_B == $swap_index_A){
			$swap_index_B = int(rand(scalar(@indices)));
		}
		#swap the indices
		print "\tswapping [$swap_index_A] [$swap_index_B]\n";
		@indices_shuffled;
		$swapped = 0;
		$existing_A = $indices[$swap_index_A];
		$existing_B = $indices[$swap_index_B];
		for($i=0;$i<scalar(@indices);$i++){
			if(($i==$swap_index_A)or($i==$swap_index_B)){
				$indices_shuffled[$swap_index_A] = $existing_B;
				$indices_shuffled[$swap_index_B] = $existing_A;
			}else{
				$indices_shuffled[$i] = $indices[$i];
			}
		}
		@indices = @indices_shuffled;
		print "\tshuffled indices:\t".join(',',@indices)."\n";
	}
	#copy the shuffled tips
	for($i=0;$i<scalar(@original_tips);$i++){
		$shuffled_tips[$i] = $original_tips[$indices[$i]];
	}
	#open output alignment
	open(OUT,'>',$student_dir."/other_genus.fa");
	#write it REMEMBERING that we've chomp()ed the input lines
	for($i=0;$i<scalar(@original_tips);$i++){
		print OUT "$shuffled_tips[$i]\n$original_sequences[$i]\n";
	}
	close(OUT);
}



