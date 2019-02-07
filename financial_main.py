import os
import csv
#import math

#csvpath = os.path.join('.','budget_data.csv')
#print(csvpath)

dates = []
money = []
#a="'.',"Desktop","LearnPython","python-challenge","PyBank""
csvpath = os.path.join('.',"Desktop","LearnPython","python-challenge","PyBank","budget_data.csv")

with open(csvpath, newline="") as csvfile:
    csvreader = csv.reader(csvfile, delimiter=',')
    print(csvreader)

    csv_header = next(csvreader)
    print(f"CSV Header: {csv_header}")

    #dates = [row[0] for row in csvreader]
    #money = [row[1] for row in csvreader]

    for row in csvreader:
        dates.append(row[0])
        money.append(float(row[1]))

outputpath = os.path.join('.',"Desktop","LearnPython","python-challenge","PyBank","Financial_analysis.txt")

with open(outputpath, 'w', newline='') as datafile:
    
    csvwriter = csv.writer(datafile)
    
    # Write the first row header
    csvwriter.writerow(['Financial Analysis'])
    csvwriter.writerow(['---------------------------------------------------------------'])
    #The total number of months included in the dataset
    csvwriter.writerow(['Total Month: ' + str(len(money))])
    #The net total amount of "Profit/Losses" over the entire period
    csvwriter.writerow(['Total:  $' + str(sum(money))])
    #The average of the changes in "Profit/Losses" over the entire period
    csvwriter.writerow(['Average change: ' + str(sum(money)/len(money))])
    #The greatest increase in profits (date and amount) over the entire period
    maxind = money.index(max(money))
    minind = money.index(min(money))

    
    csvwriter.writerow(['Greatest Increase in Profits: '+ dates[maxind] + '  $'+ str(max(money))])
    #The greatest decrease in losses (date and amount) over the entire period
    csvwriter.writerow(['Greatest Decrease in Profits: ' + dates[minind] + '  $' + str(min(money))])


