library(nlme)

# Load the data
wisc<-read.table("/Users/wuxiatian/Downloads/2021Win/PSC205G_Longitudinal Data/Session/Session1/Session_01_Computer/wisc.dat")
nsub<-204
nocc<-4

# Transform to long-format data structure
wisctran<-array(,dim=c(nsub*nocc,6))
grade<-c(1,2,4,6)
for (i in 1:nsub){
  for (j in 1:nocc){
    wisctran[nocc*(i-1)+j,1]=i
    wisctran[nocc*(i-1)+j,2]=grade[j] 
    wisctran[nocc*(i-1)+j,3]=wisc[i,j+1]
    wisctran[nocc*(i-1)+j,4]=wisc[i,j+5]
    wisctran[nocc*(i-1)+j,5]=wisc[i,18]
    wisctran[nocc*(i-1)+j,6]=wisc[i,19]
    }
}

# Give the variable names
wisctran<-data.frame(wisctran)
names(wisctran)<-c('id','occ','verb','perf','momed','grad')

# Plot the data
attach(wisctran)
interaction.plot(occ,id,verb,xlab='Occasion',ylab='Verb score',legend=F)

# Save the transformed data into a file
write.table(wisctran, "E:/Teaching/PSC 290_Long/Lecture_01/Session_01_Computer/wiscRtran.dat",row.names = FALSE)    

#transforming from long-form data to wide-form data
wiscwide<-array(,dim=c(nsub,11))
for (i in 1:nsub){
	wiscwide[i,1]<-i
	wiscwide[i,2]<-wisctran[4*(i-1)+1,3]
	wiscwide[i,3]<-wisctran[4*(i-1)+2,3]
	wiscwide[i,4]<-wisctran[4*(i-1)+3,3]
	wiscwide[i,5]<-wisctran[4*(i-1)+4,3]
	wiscwide[i,6]<-wisctran[4*(i-1)+1,4]
	wiscwide[i,7]<-wisctran[4*(i-1)+2,4]
	wiscwide[i,8]<-wisctran[4*(i-1)+3,4]
	wiscwide[i,9]<-wisctran[4*(i-1)+4,4]
	wiscwide[i,10]<-wisctran[i,5]
	wiscwide[i,11]<-wisctran[i,6]
}
wiscwide<-data.frame(wiscwide)
names(wiscwide)<-c('id','v1','v2','v4','v6','p1','p2','p4','p6','momed','grad')
