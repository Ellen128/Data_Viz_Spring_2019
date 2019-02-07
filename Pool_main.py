import os
import csv
#import math

#csvpath = os.path.join('.','budget_data.csv')
#print(csvpath)

votes = {}
names = []
#a="'.',"Desktop","LearnPython","python-challenge","PyBank""
csvpath = os.path.join('.',"Desktop","LearnPython","python-challenge","PyPool","election_data.csv")
#csvpath = "election_data.csv"

with open(csvpath, newline="") as csvfile:
    csvreader = csv.reader(csvfile, delimiter=',')
    print(csvreader)

    csv_header = next(csvreader)
    print(f"CSV Header: {csv_header}")

#    dates = [row[0] for row in csvreader]
#    money = [row[1] for row in csvreader]

    for row in csvreader:
        names.append(row[2])
    
    for name in names:
        if name not in votes:
            votes[name] = 1
        else:
            votes[name] = votes[name] + 1
    print(votes)
        

# Create a list of sorted by index 1 i.e. value field     
orderedvotes = sorted(votes.items() , reverse=True, key=lambda x: x[1])
print(orderedvotes)
outputpath = os.path.join('.',"Desktop","LearnPython","python-challenge","PyPool","Pool_analysis.txt")
#outputpath = "Pool_analysis.txt"

with open(outputpath, 'w', newline='') as datafile:
    
    csvwriter = csv.writer(datafile)
    
    # Write the first row header
    csvwriter.writerow(['Election Results'])
    csvwriter.writerow(['---------------------------------------------------------------'])
    #The total number of months included in the dataset
    csvwriter.writerow(['Total Votes: ' + str(len(names))])
    csvwriter.writerow(['---------------------------------------------------------------'])
    #The net total amount of "Profit/Losses" over the entire period
    a=len(orderedvotes)

    print(range(a))

    print("printing data...")
    # print(str(orderedvotes[0][0]) + ": " + )
    # print(str(orderedvotes[i][0]) + ':  ' + str(100*orderedvotes[i][1]/len(names)) +'%   ' +str(orderedvotes[i][1]))

    for i in range(a):
        csvwriter.writerow([str(orderedvotes[i][0]) + ':  ' + str(100*orderedvotes[i][1]/len(names)) +'%   ' + str(orderedvotes[i][1])])

    #The average of the changes in "Profit/Losses" over the entire period
    csvwriter.writerow(['Winner: ' + str(orderedvotes[0][0])])
   


