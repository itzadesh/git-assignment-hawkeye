# Bandits writeups

### level 0
''' ssh bandit0@bandit.labs.overthewire.org -p2220 '''
Key : ' bandit0 ' 

level 1
Reading a file using cat command
ls
cat readme
Key: NH2SXQwcBdpmTEzi3bvBHMM9H66vVXjL

level 2
Contains the use of full path of file so that dashed filename can be passed
cat ./-
Key : rRGizSaX8Mk1RTb1CNQoXTcYZWU6lgzi

level 3
Conatins spaces
cat ./'spaces in this filename'
Key : aBZ0W5EmUfAf7kHTQeOwd8bauFJ2lAiG

level 4
Need to navigate to the inhere directory and view hidden files and display it using cat command
ls #displays the directories
cd inhere
ls -a #displays hidden files
cat .hidden #displays content of file with filename .hidden in terminal
Key : 2EW7BBsr6aMMoJ2HjW067dm8EgX26xNe

level 5
cd inhere
ls
#Displays that all files are of the form -file0*
# Using file command identifies the type of the file and we need to look for the one which has ASCII text in it
file ./-file0* | grep ASCII
Key : lrIWWI6bB37kxfiCQZqUdOIYfr6eEeqR


