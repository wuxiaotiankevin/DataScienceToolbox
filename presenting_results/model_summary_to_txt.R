# output model summary to text file
out <- capture.output(summary(lm1))
cat(out, '\n\n\n', 
    file="model_output_zinf_161117.txt", sep="\n", append=F)