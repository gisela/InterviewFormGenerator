# Interview Form Generator
# Made by Gisela Jönsson
# http://www.giselajonsson.se

# Available roles depend on the file roles.csv
# the rows in roles.csv represent the 10 KSA's (which can be found as columns in questions.csv), and 
# are marked with 1 if they belong the profile, 0 if they're periferal

# The function intformgen takes the attributes rolename, 
# which should match exactly roles in roles.csv (there is no check)
# and the filename one wants to give the OUTPUT FORM
# As the code is here, it looks for the files in the same folder as the script runs.
intformgen <- function(rolename, filename="interviewform.csv") { 
	
	# Read in the data from fragorna.csv
	questions <- data.frame(read.csv("questions.csv", colClasses = "character", sep = ";"))
	
	# I use this variable as a kind of key to the complete register of KSAs, but it just holds 1:10
	allcols <- c(1:10)

	# Get the profile KSAs based on rolename
	getksas <- function(rolename) {
		# Read in the data from roles.csv
		roles <- data.frame(read.csv("roles.csv", colClasses = "character", sep = ";"))
		
		# Get the relevant KSA's for the role by checking rolename, get that data, 
		# transform "1" and "0" to integers, 1 and 0, and the to logicals
		logksas <- as.logical(as.integer(roles[,rolename]))
		
		# Select which numbers from allcols correspond the relevant KSA logical array
		ksas <- allcols[logksas%in%allcols]
		return(ksas)
	}

	# Get the profile KSA numbers by calling the function
	ksas <- getksas(rolename)


	# Print all colnames
	# n = 1
	#for(i in names(questions)) {
	#	print(paste(n, ". ", i, sep = ""))
	#	n = n+1
	#}

	#print(names(questions))

	# Initiate a list, These Questions are to be used
	theseq <- list()
	theseq <- rbind(theseq, paste("ROLE: ", rolename))

	# These loops are probably not beautiful but they do the job
	# For each profile KSA, append the title of the KSA to theseq
	for (i in ksas) { 
		appendthis <- paste("===:: ", names(questions[i]), " ::===", sep = "")
		theseq <- rbind(theseq, appendthis)

		# For each profile KSA, we want 3 questions, and for each of the questions
		# append the question text to theseq
		for (o in 1:3) {
			appendthis <- questions[o, i]
				if(!is.na(appendthis)) {
				theseq <- rbind(theseq, appendthis)
			} 
		}
	}

	# For the rest we want just 1 question per KSA, so we need to know what the "rest" are
	rest <- allcols[!allcols%in%ksas]

	# Same as previous loop but for the rest, and only 1 question
	for (i in rest) { 
		
		appendthis <- paste("===:: ", names(questions[i]), " ::===", sep = "")
		theseq <- rbind(theseq, appendthis)
		for (o in 1) {
			appendthis <- questions[o, i]
			if(!is.na(appendthis)) {
				theseq <- rbind(theseq, appendthis)
			} 
		}
	}


	# Uncomment below if you want the program to print what will go into the file
	#print("This will go in the file: ")
	#print(theseq)
	# return(theseq)

	# Write a CSV output
	write.table(theseq, filename, row.names=FALSE, col.names=FALSE, na="")
	print(paste("Writing file: ", filename, " ... Done.", sep = ""))

	# Uncomment below if you want it to print what was outputted to a file
	#thefile <- data.frame(read.csv(filename), colClasses = "character", sep = ";")
	#print("This is the file: ")
	#print(thefile)
}
	
