% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/taxonomy.R
\name{addSpecies}
\alias{addSpecies}
\title{Add species-level annotation to a taxonomic table.}
\usage{
addSpecies(taxtab, refFasta, allowMultiple = FALSE, tryRC = FALSE,
  verbose = FALSE)
}
\arguments{
\item{taxtab}{(Required). A taxonomic table, the output of \code{\link{assignTaxonomy}}.}

\item{refFasta}{(Required). The path to the reference fasta file, or an 
R connection. Can be compressed.
This reference fasta file should be formatted so that the id lines correspond to the
genus-species binomial of the associated sequence:
  
 >SeqID genus species  
 ACGAATGTGAAGTAA......}

\item{allowMultiple}{(Optional). Default FALSE.
Defines the behavior when multiple exact matches against different species are returned.
By default only unambiguous identifications are return. If TRUE, a concatenated string
of all exactly matched species is returned. If an integer is provided, multiple
identifications up to that many are returned as a concatenated string.}

\item{tryRC}{(Optional). Default FALSE. 
If TRUE, the reverse-complement of each sequences will be used for classification if it is a better match to the reference
sequences than the forward sequence.}

\item{verbose}{(Optional). Default FALSE.
If TRUE, print status to standard output.}
}
\value{
A character matrix one column larger than input. Rows correspond to
  sequences, and columns to the taxonomic levels. NA indicates that the sequence
  was not classified at that level.
}
\description{
\code{addSpecies} wraps the \code{\link{assignSpecies}} function to assign genus-species 
binomials to the input sequences by exact matching against a reference fasta. Those binomials
are then merged with the input taxonomic table with species annotations appended as an 
additional column to the input table.
Only species identifications where the genera in the input table and the binomial 
classification are consistent are included in the return table.
}
\examples{

seqs <- getSequences(system.file("extdata", "example_seqs.fa", package="dada2"))
training_fasta <- system.file("extdata", "example_train_set.fa.gz", package="dada2")
taxa <- assignTaxonomy(seqs, training_fasta)
species_fasta <- system.file("extdata", "example_species_assignment.fa.gz", package="dada2")
taxa.spec <- addSpecies(taxa, species_fasta)
taxa.spec.multi <- addSpecies(taxa, species_fasta, allowMultiple=TRUE)

}
\seealso{
\code{\link{assignTaxonomy}}, \code{\link{assignSpecies}}
}
