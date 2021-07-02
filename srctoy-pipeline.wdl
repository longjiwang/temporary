workflow fastqtobam
    File fastq1
	File fastq2
	File Ref
	call bwa_mem{ input: fastq1=fastq1, fastq2=fastq2.Ref=Ref}
	call samtobam{ input: sam =bwa_mem.sam
	output{
	      File bam_file = samtobam.bam\
		  }
}

task bwa_mem{
    File fastq1
	File fastq2
	File Ref
	command{
	    /bio/bwa/bwa mem ${fastq1} ${fastq2} > toy.sam
		}
		output {
		File sam = "toy.sam"
	}
	runtime {docker:"bwa:0.7.16a";cpu:"5";memory:"2G"
}

task samtobam{
    File sam
	command {
	    /bio/samtools/samtools view -bS ${sam} -o toy.bam
	}
	output{
	   File bam="toy.bam"
	}
	runtime {docker:"bwa:0.7.16a";cpu:"1";memory:"2G"
}